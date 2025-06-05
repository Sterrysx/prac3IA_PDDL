#!/usr/bin/env python3
"""generator.py — auto‑generate random PDDL problem files for the weekly‑menu
planning practise (basicb + extensions 1–5).

Drop the script inside *scripts/* and run:

    python scripts/generator.py --cases 3 --seed 2025

It will create a *test‑case/* folder in every problems/<extension> directory
and populate it with the requested number of randomised PDDL problem files.
"""
from __future__ import annotations
import argparse, json, random, textwrap
from pathlib import Path
from typing import Dict, List

# --------------------------------------------------------------------------- #
# Configuration
# --------------------------------------------------------------------------- #
ROOT          = Path(__file__).resolve().parent.parent   # project root
DATA_DIR      = ROOT / "data"
PROBLEMS_DIR  = ROOT / "problems"

DAYS          = ["dilluns", "dimarts", "dimecres", "dijous", "divendres"]
DUMMY_DAY     = "DummyD"
DUMMY_TIPUS   = "DummyT"

DEFAULT_FIRST  = 10   # dishes per category put into each generated problem
DEFAULT_SECOND = 10

# name -> feature flags: (needsTypeInfo, needsOblig, needsCalories, needsPrice)
ext_flags = {
    "basicb": (False, False, False, False),
    "ext1b":  (False, False, False, False),
    "ext2b":  (True , False, False, False),
    "ext3b":  (True , True , False, False),
    "ext4b":  (True , True , True , False),
    "ext5b":  (True , True , True , True ),
}

# --------------------------------------------------------------------------- #
# Helpers
# --------------------------------------------------------------------------- #

class Dish(dict):
    __getattr__ = dict.__getitem__
    def __repr__(self): return f"{self['name']}<{self['type']}>"


def flatten(src: Dict[str, Dict[str, Dict]], cat: str) -> List[Dish]:
    out=[]
    for tipus, dishes in src.items():
        for n, attrs in dishes.items():
            out.append(Dish(dict(name=n, type=tipus, cat=cat, **attrs)))
    return out


def load_data():
    primers_json = json.loads((DATA_DIR / "primers_plats.json").read_text(encoding="utf-8"))
    segons_json  = json.loads((DATA_DIR / "segons_plats.json").read_text(encoding="utf-8"))
    tipus_json   = json.loads((DATA_DIR / "tipus.json").read_text(encoding="utf-8"))["incompatibilitats"]
    ext_cfg      = json.loads((DATA_DIR / "extensions.json").read_text(encoding="utf-8"))
    primers = flatten(primers_json, "primer")
    segons  = flatten(segons_json , "segon")
    return primers, segons, tipus_json, ext_cfg


def indent(block: str, n: int=4) -> str:
    pad=" "*n
    return "\n".join(pad+ln if ln.strip() else ln for ln in block.splitlines())


def build_objects(first, second, tipus_needed):
    first_objs  = " ".join(d.name for d in first)
    second_objs = " ".join(d.name for d in second)
    lines=["(:objects",
           f"  {' '.join(DAYS)} - dia" + (f" {DUMMY_DAY} - dia" if tipus_needed else ""),
           f"  {first_objs} - primer",
           f"  {second_objs} - segon"]
    if tipus_needed:
        tipus_set = sorted({d.type for d in first+second})
        tipus_set.append(DUMMY_TIPUS)
        lines.append(f"  {' '.join(tipus_set)} - tipus")
    lines.append(")")
    return "\n".join(lines)


def build_incompat(first, second, tipus_incomp):
    return "\n".join(
        f"    (incompatible {p.name} {s.name})"
        for p in first for s in second
        if s.type in tipus_incomp.get(p.type, [])
    )


def build_plat_tipus(dishes):
    return "\n".join(f"    (platTipus {d.name} {d.type})" for d in dishes)


def build_calories(dishes):
    return "\n".join(f"    (= (calories {d.name}) {d.calories})" for d in dishes)


def build_prices(dishes):
    return "\n".join(f"    (= (preu {d.name}) {d.preu})" for d in dishes)


def build_dia_ant():
    chain=[DUMMY_DAY]+DAYS
    return "\n".join(f"    (diaAnt {prev} {nxt})" for prev,nxt in zip(chain,chain[1:]))


def build_dummy_init():
    return textwrap.dedent(f"""\
        (primerAsignat {DUMMY_DAY})
        (segonAsignat {DUMMY_DAY})
        (diaPrimerTipus {DUMMY_DAY} {DUMMY_TIPUS})
        (diaSegonTipus {DUMMY_DAY} {DUMMY_TIPUS})""")

# --------------------------------------------------------------------------- #


def make_problem(ext, idx, primers, segons, tipus_incomp, ext_cfg, opts):
    needsType, needsOblig, needsCal, needsPrice = ext_flags[ext]

    first  = random.sample(primers, opts.num_first)
    second = random.sample(segons , opts.num_second)
    dishes = first + second

    objects   = build_objects(first, second, needsType)
    incompat  = build_incompat(first, second, tipus_incomp)

    init_parts = [incompat]
    if needsType:
        init_parts += [build_plat_tipus(dishes), build_dia_ant(), build_dummy_init()]
    if needsCal:
        init_parts += [build_calories(dishes),
                       f"    (= (minCalories) {ext_cfg['ext4']['calories_min']})",
                       f"    (= (maxCalories) {ext_cfg['ext4']['calories_max']})"]
    if needsPrice:
        init_parts += [build_prices(dishes),
                       "    (= (costDiari) 0)",
                       "    (= (costTotal) 0)"]
    if needsOblig:
        chosen = random.sample(dishes, 2)
        days   = random.sample(DAYS, 2)
        init_parts += ["\n".join(
            f"    (platObligatori {d.name} {day})" for d, day in zip(chosen, days)
        )]

    init_block = "\n".join(init_parts)

    if ext == "basicb":
        goal = "(:goal\n    (forall (?d - dia) (diaAmbMenuAsignat ?d))\n)"
    else:
        goal = textwrap.dedent("""\
            (:goal (and
              (forall (?d - dia)
                (and (primerAsignat ?d) (segonAsignat ?d))
              )))""")

    metric = "(:metric minimize (costTotal))" if needsPrice else ""

    problem = textwrap.dedent(f"""\
        (define (problem menu-{ext}-{idx})
          (:domain menu{ext})

          {indent(objects, 2)}

          (:init
{indent(init_block,4)}
          )

          {indent(goal,2)}
          {metric}
        )""")

    dest = PROBLEMS_DIR / ext / "test-case"
    dest.mkdir(parents=True, exist_ok=True)
    path = dest / f"menu-auto-{ext}-{idx}.pddl"
    path.write_text(problem)
    print("      ↳", path.relative_to(ROOT))


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
