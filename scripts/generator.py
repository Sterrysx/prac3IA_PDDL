#!/usr/bin/env python3
"""
generator.py
~~~~~~~~~~~~
Crea instàncies *aleatòries* de problema PDDL per a totes les extensions
(basic → ext 5) de la pràctica de planificació de menús.

Canvi destacat (juny 2025)
--------------------------
・ Ja **no es copia** `domain.pddl` dins de «test-cases/».  
  El problema generat apunta al domini que ja existeix a
  `problems/<extXb>/domain.pddl`.

Ús bàsic
--------
# 5 casos per a totes les extensions
python3 scripts/generator.py --all --cases 5

# 2 casos només per a ext2 i ext4, llavor fixada
python3 scripts/generator.py --ext 2 4 --cases 2 --seed 42
"""

from __future__ import annotations

import argparse
import datetime as _dt
import json
import random
import textwrap
from pathlib import Path
from typing import Dict, List, Tuple, Set

# ---------------------------------------------------------------------------
# Paths i constants
# ---------------------------------------------------------------------------

ROOT_DIR = Path(__file__).resolve().parent.parent
DATA_DIR = ROOT_DIR / "data"
PROBLEMS_DIR = ROOT_DIR / "problems"

DAYS = ["dilluns", "dimarts", "dimecres", "dijous", "divendres"]
DUMMY_DAY = "DummyD"   # a partir de l’ext2
DUMMY_TIPUS = "DummyT"  # a partir de l’ext2


# ---------------------------------------------------------------------------
# Utilitats bàsiques
# ---------------------------------------------------------------------------

def load_json(fname: str) -> Dict:
    with open(DATA_DIR / fname, encoding="utf-8") as fh:
        return json.load(fh)


def flatten_dishes(cat_dict: Dict[str, Dict[str, Dict]]) -> Dict[str, Dict]:
    """Retorna dish → {type, calories, preu}."""
    flat: Dict[str, Dict] = {}
    for t, dishes in cat_dict.items():
        for name, attrs in dishes.items():
            flat[name] = {"type": t, **attrs}
    return flat


def build_incompat_pairs(
    primers: Dict[str, Dict],
    segons: Dict[str, Dict],
    incompat_by_type: Dict[str, List[str]],
) -> List[Tuple[str, str]]:
    pairs: List[Tuple[str, str]] = []
    for p_name, p_data in primers.items():
        bad_types = incompat_by_type.get(p_data["type"], [])
        for s_name, s_data in segons.items():
            if s_data["type"] in bad_types:
                pairs.append((p_name, s_name))
    return pairs


def choose_subset(items: List[str], k: int) -> List[str]:
    """Torna *k* ítems aleatoris (o tots si len ≤ k)."""
    return random.sample(items, min(k, len(items)))


# ---------------------------------------------------------------------------
# Renderitzadors de problema per extensió
# ---------------------------------------------------------------------------

def render_basic_problem(case: int,
                         primers: List[str],
                         segons: List[str],
                         incompat: List[Tuple[str, str]]) -> str:
    tpl = textwrap.dedent(f"""
        (define (problem menubasicb-tc{case})
          (:domain menubasicb)

          (:objects
            {' '.join(DAYS)} - dia
            {' '.join(primers)} - primer
            {' '.join(segons)}  - segon
          )

          (:init
            {{INCOMPAT}}
          )

          (:goal
            (forall (?d - dia)
              (diaAmbMenuAsignat ?d))
          )
        )
    """).strip()

    inc_lines = "\n            ".join(
        f"(incompatible {p} {s})" for p, s in incompat
    )
    return tpl.replace("{INCOMPAT}", inc_lines)


def render_ext1_problem(case: int,
                        primers: List[str],
                        segons: List[str],
                        incompat: List[Tuple[str, str]]) -> str:
    tpl = textwrap.dedent(f"""
        (define (problem menuext1b-tc{case})
          (:domain menuext1b)

          (:objects
            {' '.join(DAYS)} - dia
            {' '.join(primers)} - primer
            {' '.join(segons)}  - segon
          )

          (:init
            {{INCOMPAT}}
          )

          (:goal
            (forall (?d - dia)
              (and (primerAsignat ?d) (segonAsignat ?d)))
          )
        )
    """).strip()

    inc_lines = "\n            ".join(
        f"(incompatible {p} {s})" for p, s in incompat
    )
    return tpl.replace("{INCOMPAT}", inc_lines)


def render_ext2plus_problem(ext: int,
                            case: int,
                            primers: List[str],
                            segons: List[str],
                            tipus_set: Set[str],
                            incompat: List[Tuple[str, str]],
                            plat_tipus: Dict[str, str],
                            required: List[Tuple[str, str]],
                            fluents: Dict | None,
                            metric: bool) -> str:
    domain_name = f"menuext{ext}b"
    problem_name = f"menuext{ext}b-tc{case}"

    objs_block = textwrap.dedent(f"""
        {' '.join(DAYS + [DUMMY_DAY])} - dia
        {' '.join(primers)} - primer
        {' '.join(segons)} - segon
        {' '.join(sorted(tipus_set | {DUMMY_TIPUS}))} - tipus
    """).strip()

    inc_lines = "\n    ".join(f"(incompatible {p} {s})" for p, s in incompat)
    plat_tipus_lines = "\n    ".join(f"(platTipus {d} {t})" for d, t in plat_tipus.items())
    dia_seq_lines = "\n    ".join(
        [f"(diaAnt {DUMMY_DAY} {DAYS[0]})"] +
        [f"(diaAnt {DAYS[i]} {DAYS[i+1]})" for i in range(len(DAYS)-1)]
    )
    dummy_init = textwrap.dedent(f"""
        (primerAsignat {DUMMY_DAY})
        (segonAsignat  {DUMMY_DAY})
        (diaPrimerTipus {DUMMY_DAY} {DUMMY_TIPUS})
        (diaSegonTipus  {DUMMY_DAY} {DUMMY_TIPUS})
    """).strip()
    required_lines = "\n    ".join(f"(platObligatori {d} {day})" for d, day in required)

    # Fluents (ext4/5)
    minmax, cals, prices, cost_init, metric_line = "", "", "", "", ""
    if fluents:
        minmax = f"(= (minCalories) {fluents['cal_min']})\n    (= (maxCalories) {fluents['cal_max']})"
        cals = "\n    ".join(f"(= (calories {d}) {dt['calories']})" for d, dt in fluents["dishes"].items())
        if ext == 5:
            prices = "\n    ".join(f"(= (preu {d}) {dt['preu']})" for d, dt in fluents["dishes"].items())
            cost_init = "(= (costDiari) 0)\n    (= (costTotal) 0)"
            metric_line = "\n  (:metric minimize (costTotal))"

    init_parts = "\n    ".join(filter(None, [
        inc_lines, plat_tipus_lines, dia_seq_lines, dummy_init,
        required_lines, minmax, cals, prices, cost_init
    ]))

    return textwrap.dedent(f"""
        (define (problem {problem_name})
          (:domain {domain_name})

          (:objects
            {objs_block}
          )

          (:init
            {init_parts}
          )

          (:goal
            (forall (?d - dia)
              (and (primerAsignat ?d) (segonAsignat ?d)))
          ){metric_line}
        )
    """).strip()


# ---------------------------------------------------------------------------
# Generador per extensió
# ---------------------------------------------------------------------------

def generate_for_extension(ext: int, n_cases: int, rnd: random.Random):
    """Genera *n_cases* problemes per a l’extensió *ext* (0 = basic, 1..5)."""

    # --- carrega de dades --------------------------------------------------
    primers_raw = load_json("primers_plats.json")
    segons_raw = load_json("segons_plats.json")
    tipus_map = load_json("tipus.json")["incompatibilitats"]
    ext_conf = load_json("extensions.json")

    primers = flatten_dishes(primers_raw)
    segons = flatten_dishes(segons_raw)
    all_tipus = {d["type"] for d in primers.values()} | {d["type"] for d in segons.values()}
    incompat_all = build_incompat_pairs(primers, segons, tipus_map)

    # --- carpetes de sortida ----------------------------------------------
    ext_dir = PROBLEMS_DIR / ("basicb" if ext == 0 else f"ext{ext}b")
    tc_dir = ext_dir / "test-cases"
    tc_dir.mkdir(parents=True, exist_ok=True)

    domain_path = ext_dir / "domain.pddl"   # NO es copia, simplement s'usa

    # --- bucle de generació ------------------------------------------------
    for case in range(1, n_cases + 1):
        rnd.seed(rnd.random() * _dt.datetime.now().timestamp())

        primers_sub = choose_subset(list(primers.keys()), 10)
        segons_sub = choose_subset(list(segons.keys()), 10)

        incompat_sub = choose_subset(
            [p for p in incompat_all if p[0] in primers_sub and p[1] in segons_sub],
            8
        )

        required: List[Tuple[str, str]] = []
        if ext >= 3:
            picks = choose_subset(primers_sub + segons_sub, 2)
            required = list(zip(picks, rnd.sample(DAYS, len(picks))))

        fluents = None
        if ext >= 4:
            fluents = {
                "cal_min": ext_conf["ext4"]["calories_min"],
                "cal_max": ext_conf["ext4"]["calories_max"],
                "dishes": {**{d: primers[d] for d in primers_sub},
                           **{d: segons[d] for d in segons_sub}},
            }

        plat_tipus_map = {**{d: primers[d]["type"] for d in primers_sub},
                          **{d: segons[d]["type"] for d in segons_sub}}

        # --- renderitzat ---------------------------------------------------
        if ext == 0:
            problem_txt = render_basic_problem(case, primers_sub, segons_sub, incompat_sub)
            fname = f"menu-basicb-tc{case}.pddl"
        elif ext == 1:
            problem_txt = render_ext1_problem(case, primers_sub, segons_sub, incompat_sub)
            fname = f"menu-ext1b-tc{case}.pddl"
        else:
            problem_txt = render_ext2plus_problem(
                ext, case, primers_sub, segons_sub, all_tipus,
                incompat_sub, plat_tipus_map, required, fluents, metric=(ext == 5)
            )
            fname = f"menu-ext{ext}b-tc{case}.pddl"

        out_path = tc_dir / fname
        out_path.write_text(problem_txt, encoding="utf-8")

        print(f"✅  Ext {ext} – cas {case} → {out_path.relative_to(ROOT_DIR)}")

        # consell d'execució FF
        bin_name = "metric-ff" if ext >= 4 else "ff"
        opt_flag = "-O " if ext == 5 else ""
        print("   ▶ run:",
              f"binaries/linux/{bin_name} {opt_flag}-o {domain_path} -f {out_path}")


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------

def parse_args():
    p = argparse.ArgumentParser(description="Genera casos de prova PDDL aleatoris.")
    g = p.add_mutually_exclusive_group(required=True)
    g.add_argument("--all", action="store_true",
                   help="totes les extensions (0…5)")
    g.add_argument("--ext", nargs="*", type=int, choices=range(0, 6),
                   metavar="N", help="extensions específiques")
    p.add_argument("--cases", type=int, default=1,
                   help="casos per extensió (def. 1)")
    p.add_argument("--seed", type=int, help="llavor aleatòria")
    return p.parse_args()


def main():
    args = parse_args()
    rnd = random.Random(args.seed)

    targets = list(range(6)) if args.all else args.ext
    for ext in targets:
        generate_for_extension(ext, args.cases, rnd)


if __name__ == "__main__":
    main()
