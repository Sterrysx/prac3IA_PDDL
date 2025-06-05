#!/usr/bin/env python3
"""generator.py — genera instancias PDDL (basicb + ext1b–ext5b)
   garantizando ≥5 pares primer+segon con 1000-1500 kcal y sin incompatibles."""

from __future__ import annotations
import argparse, json, random, itertools, textwrap
from pathlib import Path
from typing import Dict, List, Tuple

# --------------------------------------------------------------------------- #
# Configuración global
# --------------------------------------------------------------------------- #
ROOT          = Path(__file__).resolve().parent.parent
DATA_DIR      = ROOT / "data"
PROBLEMS_DIR  = ROOT / "problems"

DAYS          = ["dilluns", "dimarts", "dimecres", "dijous", "divendres"]
DUMMY_DAY     = "DummyD"
DUMMY_TIPUS   = "DummyT"

DEFAULT_FIRST  = 12
DEFAULT_SECOND = 12
MAX_RETRIES    = 100   # intentos máximos para hallar una muestra factible

# flags por extensión: (needsTypeInfo, needsOblig, needsCalories, needsPrice)
ext_flags = {
    "basicb": (False, False, False, False),
    "ext1b":  (False, False, False, False),
    "ext2b":  (True , False, False, False),
    "ext3b":  (True , True , False, False),
    "ext4b":  (True , True , True , False),
    "ext5b":  (True , True , True , True ),
}

# --------------------------------------------------------------------------- #
# Modelado de datos
# --------------------------------------------------------------------------- #
class Dish(dict):
    __getattr__ = dict.__getitem__
    def __repr__(self): return f"{self['name']}<{self['type']}>"

def _flatten(src: Dict[str, Dict[str, Dict]], cat: str) -> List[Dish]:
    out = []
    for tipus, dishes in src.items():
        for n, attrs in dishes.items():
            out.append(Dish(dict(name=n, type=tipus, cat=cat, **attrs)))
    return out

def load_data() -> Tuple[List[Dish], List[Dish], Dict[str, List[str]], Dict]:
    primers_json = json.loads((DATA_DIR / "primers_plats.json").read_text())
    segons_json  = json.loads((DATA_DIR / "segons_plats.json").read_text())
    tipus_json   = json.loads((DATA_DIR / "tipus.json").read_text())["incompatibilitats"]
    ext_cfg      = json.loads((DATA_DIR / "extensions.json").read_text())
    return _flatten(primers_json, "primer"), _flatten(segons_json, "segon"), tipus_json, ext_cfg

# --------------------------------------------------------------------------- #
# Feasibility check (≥5 valid pairs within kcal range)
# --------------------------------------------------------------------------- #
def is_feasible(firsts: List[Dish], seconds: List[Dish],
                tipus_incomp: Dict[str, List[str]],
                lo: int, hi: int) -> bool:
    n = 0
    for p, s in itertools.product(firsts, seconds):
        if s.type in tipus_incomp.get(p.type, []):
            continue
        kcal = p.calories + s.calories
        if lo <= kcal <= hi:
            n += 1
            if n >= 5:
                return True
    return False

# --------------------------------------------------------------------------- #
# helpers build_* (obj, init, etc.)
# --------------------------------------------------------------------------- #
def indent(txt: str, n: int = 4) -> str:
    pad = " " * n
    return "\n".join(pad + l if l.strip() else l for l in txt.splitlines())

def build_objects(first, second, tipus_needed):
    lines = [
        "(:objects",
        f"  {' '.join(DAYS)} - dia" + (f" {DUMMY_DAY} - dia" if tipus_needed else ""),
        f"  {' '.join(d.name for d in first)} - primer",
        f"  {' '.join(d.name for d in second)} - segon",
    ]
    if tipus_needed:
        tipus = sorted({d.type for d in first + second}) + [DUMMY_TIPUS]
        lines.append(f"  {' '.join(tipus)} - tipus")
    lines.append(")")
    return "\n".join(lines)

def build_incompat(first, second, tipus_incomp):
    return "\n".join(
        f"(incompatible {p.name} {s.name})"
        for p in first for s in second
        if s.type in tipus_incomp.get(p.type, [])
    )

def build_plat_tipus(ds):   return "\n".join(f"(platTipus {d.name} {d.type})" for d in ds)
def build_calories(ds):     return "\n".join(f"(= (calories {d.name}) {d.calories})" for d in ds)
def build_prices(ds):       return "\n".join(f"(= (preu {d.name}) {d.preu})" for d in ds)
def build_dia_ant():
    chain = [DUMMY_DAY] + DAYS
    return "\n".join(f"(diaAnt {a} {b})" for a, b in zip(chain, chain[1:]))
def build_dummy_init():
    return "\n".join([
        f"(primerAsignat {DUMMY_DAY})",
        f"(segonAsignat {DUMMY_DAY})",
        f"(diaPrimerTipus {DUMMY_DAY} {DUMMY_TIPUS})",
        f"(diaSegonTipus {DUMMY_DAY} {DUMMY_TIPUS})"
    ])

# --------------------------------------------------------------------------- #
# Generador de un problema
# --------------------------------------------------------------------------- #
def make_problem(ext: str, idx: int,
                 primers_all, segons_all, tipus_incomp, ext_cfg, opts):
    needsType, needsObl, needsCal, needsPrice = ext_flags[ext]

    for _ in range(MAX_RETRIES):
        first  = random.sample(primers_all, opts.num_first)
        second = random.sample(segons_all , opts.num_second)
        if needsCal and not is_feasible(first, second, tipus_incomp,
                                        ext_cfg["ext4"]["calories_min"],
                                        ext_cfg["ext4"]["calories_max"]):
            continue
        break
    else:
        print(f"   ⚠  {ext}-{idx}: sin muestra factible tras {MAX_RETRIES} intentos")
        return

    # ---- construir bloques PDDL ----
    obj_block   = build_objects(first, second, needsType)
    init_lines  = [build_incompat(first, second, tipus_incomp)]

    if needsType:
        init_lines += [build_plat_tipus(first + second), build_dia_ant(), build_dummy_init()]
    if needsCal:
        init_lines += [
            build_calories(first + second),
            f"(= (minCalories) {ext_cfg['ext4']['calories_min']})",
            f"(= (maxCalories) {ext_cfg['ext4']['calories_max']})"
        ]
    if needsPrice:
        init_lines += [
            build_prices(first + second),
            "(= (costDiari) 0)",
            "(= (costTotal) 0)"
        ]
    if needsObl:
        dishes = random.sample(first + second, 2)
        days   = random.sample(DAYS, 2)
        init_lines.append("\n".join(f"(platObligatori {d.name} {day})" for d, day in zip(dishes, days)))

    init_block = indent("\n".join(init_lines), 4)

    if ext == "basicb":
        goal = indent("( :goal (forall (?d - dia) (diaAmbMenuAsignat ?d) ) )", 2)
    else:
        goal = indent(textwrap.dedent("""
            (:goal (and
              (forall (?d - dia)
                (and (primerAsignat ?d) (segonAsignat ?d))
              )))
        """).strip(), 2)

    metric = "(:metric minimize (costTotal))" if needsPrice else ""

    problem_text = textwrap.dedent(f"""
        (define (problem menu-{ext}-{idx})
          (:domain menu{ext})

          {indent(obj_block, 2)}

          (:init
{init_block}
          )

          {goal}
          {metric}
        )
    """).strip()

    dest = PROBLEMS_DIR / ext / "test-case"
    dest.mkdir(parents=True, exist_ok=True)
    path = dest / f"menu-auto-{ext}-{idx}.pddl"
    path.write_text(problem_text)
    print("      ↳", path.relative_to(ROOT))

# --------------------------------------------------------------------------- #
# main
# --------------------------------------------------------------------------- #
def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--cases", type=int, default=2)
    ap.add_argument("--num-first", type=int, default=DEFAULT_FIRST)
    ap.add_argument("--num-second", type=int, default=DEFAULT_SECOND)
    ap.add_argument("--seed", type=int)
    opts = ap.parse_args()
    if opts.seed is not None:
        random.seed(opts.seed)

    primers, segons, tipus_incomp, ext_cfg = load_data()

    for ext in ext_flags:
        if not (PROBLEMS_DIR / ext).exists():
            continue
        print(f"Generating for {ext} …")
        for idx in range(1, opts.cases + 1):
            make_problem(ext, idx, primers, segons, tipus_incomp, ext_cfg, opts)

if __name__ == "__main__":
    main()
