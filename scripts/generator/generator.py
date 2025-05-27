#!/usr/bin/env python3
"""
Menu-Planner PDDL Test-Case Generator
------------------------------------
Genera instancias aleatorias **SIEMPRE SOLUBLES** para el dominio «menu-setmanal»
(básico y métrico). A partir de los JSON de /data construye problemas que
cumplen progresivamente las extensiones 0-5 y garantiza:

* Ext ≥ 1  → Primeros y segundos NO se repiten en la semana.
* Ext ≥ 2  → No hay dos días consecutivos con el mismo *tipo* de plato.
* Ext ≥ 3  → Los platos obligatorios son compatibles con las restricciones.
* Ext ≥ 4  → Cada día aporta 1 000–1 500 kcal.

Uso rápido:
```

cd scripts/generator
python3 generator.py --ext 3 --count 5 --outdir ../../problems/ext3 --seed 42

```
El código es auto-contenible; sólo depende de la biblioteca estándar.
"""
from __future__ import annotations

import argparse
import json
import random
import textwrap
from pathlib import Path
from typing import Dict, List, Tuple, Sequence

# ──────────────────────────────────────────────────────────────────────────────
# Rutas y constantes
# ──────────────────────────────────────────────────────────────────────────────
ROOT_DIR      = Path(__file__).resolve().parents[2]
DATA_DIR      = ROOT_DIR / "data"
PRIMERS_FILE  = DATA_DIR / "primers_plats.json"
SEGONS_FILE   = DATA_DIR / "segons_plats.json"
TIPUS_FILE    = DATA_DIR / "tipus.json"
EXT_FILE      = DATA_DIR / "extensions.json"

DIES = ["dilluns", "dimarts", "dimecres", "dijous", "divendres"]

Dish = Tuple[str, str]            # (nombre, tipus)
Menu = List[Tuple[Dish, Dish]]    # 5 tuplas (primer, segon)

# ──────────────────────────────────────────────────────────────────────────────
# Carga de datos auxiliares
# ──────────────────────────────────────────────────────────────────────────────
def _flatten(raw: Dict[str, Dict[str, Dict]]) -> List[Dish]:
    return [(name, tipus) for tipus, d in raw.items() for name in d]

def load_data():
    with open(PRIMERS_FILE, "r", encoding="utf-8") as fh:
        primers_raw = json.load(fh)
    with open(SEGONS_FILE, "r", encoding="utf-8") as fh:
        segons_raw = json.load(fh)
    with open(TIPUS_FILE, "r", encoding="utf-8") as fh:
        incompat = json.load(fh)["incompatibilitats"]
    with open(EXT_FILE, "r", encoding="utf-8") as fh:
        ext_cfg = json.load(fh)

    primers   = _flatten(primers_raw)
    segons    = _flatten(segons_raw)
    calories  = {**{n: primers_raw[t][n]["calories"] for t in primers_raw for n in primers_raw[t]},
                 **{n: segons_raw[t][n]["calories"] for t in segons_raw for n in segons_raw[t]}}
    prices    = {**{n: primers_raw[t][n]["preu"]      for t in primers_raw for n in primers_raw[t]},
                 **{n: segons_raw[t][n]["preu"]       for t in segons_raw for n in segons_raw[t]}}
    return primers, segons, incompat, calories, prices, ext_cfg

# ──────────────────────────────────────────────────────────────────────────────
# Generación de un menú SOLUBLE
# ──────────────────────────────────────────────────────────────────────────────
def build_menu(
    ext: int,
    primers: Sequence[Dish],
    segons: Sequence[Dish],
    incompat: Dict[str, List[str]],
    calories: Dict[str, int],
    ext_cfg: Dict,
    max_attempts: int = 10_000,
) -> Tuple[Menu, Dict[str, Dish], Tuple[str, str]]:
    rnd = random.Random()
    # Pre-selección de platos obligatorios (ext ≥3)
    oblig: Dict[str, Dish] = {}
    if ext >= 3:
        num       = rnd.randint(1, 3)
        dias_disp = rnd.sample(DIES, k=num)
        prim_pool = primers.copy()
        seg_pool  = segons.copy()
        rnd.shuffle(prim_pool)
        rnd.shuffle(seg_pool)
        for dia in dias_disp:
            if rnd.random() < 0.5 and prim_pool:
                dish = prim_pool.pop()
            else:
                dish = seg_pool.pop()
            oblig[dia] = dish
    # Tipos previos (ext ≥2)
    tp_prev_init = rnd.choice(list({t for _, t in primers})) if ext >= 2 else "pasta"
    ts_prev_init = rnd.choice(list({t for _, t in segons}))  if ext >= 2 else "amanida"
    # Búsqueda estocástica
    for _ in range(max_attempts):
        menu: Menu          = []
        used_names: set[str] = set()
        tp_prev, ts_prev    = tp_prev_init, ts_prev_init
        ok                  = True
        for dia in DIES:
            # Primer
            if dia in oblig and oblig[dia] in primers:
                primer = oblig[dia]
            else:
                cand = [d for d in primers if d[1] != tp_prev]
                if ext >= 1:
                    cand = [d for d in cand if d[0] not in used_names]
                if not cand:
                    ok = False
                    break
                primer = rnd.choice(cand)
            # Segon
            if dia in oblig and oblig[dia] in segons:
                segon = oblig[dia]
            else:
                evitar = set(incompat.get(primer[1], []))
                cand   = [d for d in segons if d[1] != ts_prev and d[1] not in evitar]
                if ext >= 1:
                    cand = [d for d in cand if d[0] not in used_names]
                if not cand:
                    ok = False
                    break
                segon = rnd.choice(cand)
            # Calorías
            if ext >= 4:
                total = calories[primer[0]] + calories[segon[0]]
                lo, hi = ext_cfg["ext4"]["calories_min"], ext_cfg["ext4"]["calories_max"]
                if total < lo or total > hi:
                    ok = False
                    break
            menu.append((primer, segon))
            used_names.update({primer[0], segon[0]})
            tp_prev, ts_prev = primer[1], segon[1]
        if ok:
            if ext >= 1:
                if len({p[0] for p, _ in menu}) != len(DIES):
                    continue
                if len({s[0] for _, s in menu}) != len(DIES):
                    continue
            return menu, oblig, (tp_prev_init, ts_prev_init)
    raise RuntimeError("No se pudo generar un menú válido tras muchos intentos.")

# ──────────────────────────────────────────────────────────────────────────────
# Creación de PDDL con incompatibilidades correctas y tipos completos
# ──────────────────────────────────────────────────────────────────────────────
def esc(name: str) -> str:
    return name.replace(" ", "_").lower()

def build_problem(
    idx: int,
    ext: int,
    menu: Menu,
    oblig: Dict[str, Dish],
    prev_types: Tuple[str, str],
    calories: Dict[str, int],
    prices: Dict[str, int],
    incompat: Dict[str, List[str]],
    ext_cfg: Dict,
) -> str:
    domain = "menu-setmanal" if ext < 4 else "menu-setmanal-metric"
    pname  = f"menu-auto-ext{ext}-{idx}"
    # Objetos
    prim_list  = [pair[0] for pair in menu]
    seg_list   = [pair[1] for pair in menu]
    prim_names = " ".join(sorted(esc(p[0]) for p in prim_list))
    seg_names  = " ".join(sorted(esc(s[0]) for s in seg_list))
    # Incluir también los tipos previos en la lista de - tipus
    tipus_set  = {t for _, t in prim_list + seg_list}
    tipus_set.update(prev_types)
    tipus_objs = " ".join(sorted(tipus_set))
    # Init
    init = []
    init += [f"(dia-seguent {d1} {d2})" for d1, d2 in zip(DIES, DIES[1:])]
    # plat-tipus y funciones numéricas
    for p, t in prim_list + seg_list:
        n = esc(p)
        init.append(f"(plat-tipus {n} {t})")
        if ext >= 4:
            init.append(f"(= (calories {n}) {calories[p]})")
            init.append(f"(= (preu {n}) {prices[p]})")
    # incompatibilidades primer-segon
    for primer, _ in prim_list:
        p_sym = esc(primer[0])
        for segon, typ_s in seg_list:
            if typ_s in incompat.get(primer[1], []):
                init.append(f"(incompatible {p_sym} {esc(segon)})")
    # tipos anteriores
    tp_prev, ts_prev = prev_types
    init.append(f"(tipus-primer-anterior {tp_prev})")
    init.append(f"(tipus-segon-anterior  {ts_prev})")
    if ext >= 4:
        init.append("(= (calories-actuals) 0)")
        init.append("(= (cost-total) 0)")
    # Estado inicial
    init.append("(dia-actual dilluns)")
    init += [f"(necessita-primer {d})" for d in DIES]
    if ext >= 3:
        for dia, dish in oblig.items():
            sym = esc(dish[0])
            if dish in prim_list:
                init.append(f"(primer-obligatori {dia} {sym})")
            else:
                init.append(f"(segon-obligatori {dia} {sym})")
    init_block = "\n    ".join(init)
    metric = "" if ext < 5 else "(:metric minimize (cost-total))"
    return textwrap.dedent(f"""
    (define (problem {pname})
      (:domain {domain})

      (:objects
        {' '.join(DIES)} - dia
        {tipus_objs} - tipus
        {prim_names}  - primer
        {seg_names}   - segon)

      (:init
        {init_block})

      (:goal (planificacio-completa))
      {metric}
    )
    """)

# ──────────────────────────────────────────────────────────────────────────────
# CLI principal
# ──────────────────────────────────────────────────────────────────────────────
def main():
    parser = argparse.ArgumentParser(description="Genera instancias PDDL (siempre solubles).")
    parser.add_argument("--ext",    type=int, choices=range(0,6), default=0)
    parser.add_argument("--count",  type=int, default=1)
    parser.add_argument("--outdir", type=Path, default=Path("../../problems/auto"))
    parser.add_argument("--seed",   type=int, default=None)
    args = parser.parse_args()
    if args.seed is not None:
        random.seed(args.seed)
    primers, segons, incompat, calories, prices, ext_cfg = load_data()
    args.outdir.mkdir(parents=True, exist_ok=True)
    for i in range(1, args.count+1):
        menu, oblig, prev_types = build_menu(args.ext, primers, segons, incompat, calories, ext_cfg)
        pddl = build_problem(i, args.ext, menu, oblig, prev_types, calories, prices, incompat, ext_cfg)
        path = args.outdir / f"menu-auto-ext{args.ext}-{i}.pddl"
        path.write_text(pddl, encoding="utf-8")
        path_abs = path.resolve()
        try:
            rel = path_abs.relative_to(ROOT_DIR)
        except ValueError:
            rel = path_abs
        print(f"[OK] → {rel}")

if __name__ == "__main__":
    main()
