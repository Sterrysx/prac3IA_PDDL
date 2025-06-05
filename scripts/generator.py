#!/usr/bin/env python3
"""generate_test_cases.py
------------------------
Utility script to create **random** PDDL *problem* instances for every menu‑planning
extension (basic → ext 5).

The generator consumes the authoritative JSON datasets in **./data** and writes a
complete test‑case directory tree under each extension folder, preserving the
original *domain.pddl* while creating new *problem* files (e.g.
`menu-ext2b‑tc1.pddl`).

Each invocation can control how many test cases are produced per extension and
whether *all* extensions or only a subset should be handled.

Examples
~~~~~~~~
```bash
# Build three fresh random test cases for every extension
python scripts/generate_test_cases.py --cases 3 --all

# Build one test for ext2 and ext4 only
python scripts/generate_test_cases.py --cases 1 --ext 2 4
```

Implementation notes
~~~~~~~~~~~~~~~~~~~~
* **Fast‑Forward binaries**: The script does *not* run FF/Metric‑FF itself, but
  it prints a ready‑to‑copy command line for each generated test so you can
  execute the corresponding binary in *binaries/linux*.
* **Reproducibility**: Provide `--seed <int>` if you wish to reproduce exactly
  the same random instances.
* **Output layout** (example for extension 2):
```
problems/
  ext2b/
    test-cases/
      tc1/
        domain.pddl          # copied verbatim from problems/ext2b/domain.pddl
        menu-ext2b-tc1.pddl  # freshly generated problem instance
      tc2/
        ...
```
* **Constraints**:  Each generator routine enforces the *syntactic* requirements
  of its corresponding extension.  Semantic constraints (e.g., "no repeated
  dish in a week" for ext1, calorie bounds for ext4) are guaranteed *by the
  domain* once the planner searches for a solution; the problem instance itself
  just contains the data it needs (objects, predicates, fluents, …).
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
# Constants & helpers
# ---------------------------------------------------------------------------

ROOT_DIR = Path(__file__).resolve().parent.parent
DATA_DIR = ROOT_DIR / "data"
PROBLEMS_DIR = ROOT_DIR / "problems"
DAYS = ["dilluns", "dimarts", "dimecres", "dijous", "divendres"]
DUMMY_DAY = "DummyD"  # used from ext2 upwards
DUMMY_TIPUS = "DummyT"  # used from ext2 upwards

def load_json(filename: str) -> Dict:
    with open(DATA_DIR / filename, "r", encoding="utf-8") as fh:
        return json.load(fh)


def flatten_dishes(cat_dict: Dict[str, Dict[str, Dict]]) -> Dict[str, Dict]:
    """Return dish_name → {type, calories, preu}."""
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
        bad_seg_types = incompat_by_type.get(p_data["type"], [])
        for s_name, s_data in segons.items():
            if s_data["type"] in bad_seg_types:
                pairs.append((p_name, s_name))
    return pairs


def choose_subset(items: List[str], k: int) -> List[str]:
    """Return *k* distinct random items (or all if |items| ≤ k)."""
    return random.sample(items, min(k, len(items)))


# ---------------------------------------------------------------------------
# Per‑extension rendering functions
# ---------------------------------------------------------------------------

def render_basic_problem(
    case_id: int,
    primers: List[str],
    segons: List[str],
    incompat: List[Tuple[str, str]],
) -> str:
    tpl = textwrap.dedent(
        f"""
        (define (problem menubasicb-tc{case_id})
          (:domain menubasicb)

          (:objects
            {' '.join(DAYS)} - dia
            {' '.join(primers)} - primer
            {' '.join(segons)} - segon
          )

          (:init
            {{INCOMPAT}}
          )

          (:goal
            (forall (?d - dia)
              (diaAmbMenuAsignat ?d)
            )
          )
        )
        """
    ).strip()

    incompat_lines = "\n            ".join(
        f"(incompatible {p} {s})" for p, s in incompat
    )
    return tpl.replace("{INCOMPAT}", incompat_lines)


def render_ext1_problem(
    case_id: int,
    primers: List[str],
    segons: List[str],
    incompat: List[Tuple[str, str]],
) -> str:
    tpl = textwrap.dedent(
        f"""
        (define (problem menuext1b-tc{case_id})
          (:domain menuext1b)

          (:objects
            {' '.join(DAYS)} - dia
            {' '.join(primers)} - primer
            {' '.join(segons)} - segon
          )

          (:init
            {{INCOMPAT}}
          )

          (:goal
            (forall (?d - dia)
              (and (primerAsignat ?d) (segonAsignat ?d))
            )
          )
        )
        """
    ).strip()

    incompat_lines = "\n            ".join(
        f"(incompatible {p} {s})" for p, s in incompat
    )
    return tpl.replace("{INCOMPAT}", incompat_lines)


def render_ext2plus_problem(
    ext: int,
    case_id: int,
    primers: List[str],
    segons: List[str],
    tipus_set: Set[str],
    incompat: List[Tuple[str, str]],
    plat_tipus: Dict[str, str],
    required: List[Tuple[str, str]],  # (dish, day)
    fluents: Dict[str, Dict] | None = None,
    metric: bool = False,
) -> str:
    """Generic renderer for extensions 2—5 (they share a lot)."""

    domain_name = f"menuext{ext}b"
    problem_name = f"menuext{ext}b-tc{case_id}"

    objs_lines = textwrap.dedent(
        f"""
        {' '.join(DAYS + [DUMMY_DAY])} - dia
        {' '.join(primers)} - primer
        {' '.join(segons)} - segon
        {' '.join(sorted(tipus_set | {DUMMY_TIPUS}))} - tipus
        """
    ).strip()

    incompat_lines = "\n    ".join(
        f"(incompatible {p} {s})" for p, s in incompat
    )

    plat_tipus_lines = "\n    ".join(
        f"(platTipus {dish} {t})" for dish, t in plat_tipus.items()
    )

    # Day ordering predicates
    dia_ant_lines = "\n    ".join(
        [f"(diaAnt {DUMMY_DAY} {DAYS[0]})"]
        + [f"(diaAnt {DAYS[i]} {DAYS[i+1]})" for i in range(len(DAYS)-1)]
    )

    # Dummy initial predicates
    dummy_init_lines = textwrap.dedent(
        f"""
        (primerAsignat {DUMMY_DAY})
        (segonAsignat {DUMMY_DAY})
        (diaPrimerTipus {DUMMY_DAY} {DUMMY_TIPUS})
        (diaSegonTipus  {DUMMY_DAY} {DUMMY_TIPUS})
        """
    ).strip()

    required_lines = "\n    ".join(
        f"(platObligatori {dish} {day})" for dish, day in required
    ) if required else ""

    # Fluents (calories / price) — only for ext4 & ext5
    minmax_lines = ""
    cal_lines = ""
    price_lines = ""
    cost_init_lines = ""
    metric_line = ""

    if fluents:
        # ext 4 introduces calories; ext 5 adds prices & metric
        minmax_lines = textwrap.dedent(
            f"""
            (= (minCalories) {fluents['cal_min']})
            (= (maxCalories) {fluents['cal_max']})
            """
        ).strip()

        cal_lines = "\n    ".join(
            [f"(= (calories {dish}) {data['calories']})" for dish, data in fluents["dishes"].items()]
        )
        if ext == 5:
            price_lines = "\n    ".join(
                [f"(= (preu {dish}) {data['preu']})" for dish, data in fluents["dishes"].items()]
            )
            cost_init_lines = textwrap.dedent(
                """
                (= (costDiari) 0)
                (= (costTotal) 0)
                """
            ).strip()
            metric_line = "\n  (:metric minimize (costTotal))"

    init_blocks = "\n    ".join(
        x for x in [
            incompat_lines,
            plat_tipus_lines,
            dia_ant_lines,
            dummy_init_lines,
            required_lines,
            minmax_lines,
            cal_lines,
            price_lines,
            cost_init_lines,
        ] if x
    )

    tpl = textwrap.dedent(
        f"""
        (define (problem {problem_name})
          (:domain {domain_name})

          (:objects
            {objs_lines}
          )

          (:init
            {init_blocks}
          )

          (:goal
            (forall (?d - dia)
              (and (primerAsignat ?d) (segonAsignat ?d))
            )
          ){metric_line}
        )
        """
    ).strip()

    return tpl

# ---------------------------------------------------------------------------
# Generator per extension — orchestrates the above renderers
# ---------------------------------------------------------------------------

def generate_for_extension(ext: int, n_cases: int, rand: random.Random):
    """Create *n_cases* problem files for extension *ext* (0 → basic, 1..5)."""

    # ---------- load & preprocess data ----------
    primers_raw = load_json("primers_plats.json")
    segons_raw = load_json("segons_plats.json")
    tipus_map = load_json("tipus.json")["incompatibilitats"]
    ext_conf = load_json("extensions.json")

    primers = flatten_dishes(primers_raw)
    segons = flatten_dishes(segons_raw)

    all_tipus = set(primer["type"] for primer in primers.values()) | set(
        segon["type"] for segon in segons.values()
    )

    incompat_pairs_all = build_incompat_pairs(primers, segons, tipus_map)

    # ---------- prepare output directory ----------
    ext_dir = PROBLEMS_DIR / ("basicb" if ext == 0 else f"ext{ext}b")
    tc_dir = ext_dir / "test-cases"
    tc_dir.mkdir(parents=True, exist_ok=True)

    # Copy domain once (avoid overwriting each time)
    (tc_dir / "domain.pddl").write_text((ext_dir / "domain.pddl").read_text(), encoding="utf-8")

    for i in range(1, n_cases + 1):
        rand.seed(rand.random() * _dt.datetime.now().timestamp())  # re‑seed for variety

        # Random subsets – keep sizes reasonable so action grounding is manageable
        primers_subset = choose_subset(list(primers.keys()), k=10)
        segons_subset = choose_subset(list(segons.keys()), k=10)

        # Use subset to filter compatibles & attributes
        primers_sub = {k: primers[k] for k in primers_subset}
        segons_sub = {k: segons[k] for k in segons_subset}

        incompat_subset = choose_subset(
            [pair for pair in incompat_pairs_all if pair[0] in primers_sub and pair[1] in segons_sub],
            k=8,
        )

        # Required dishes (ext≥3): choose up to 2 random unique dishes & random days
        required: List[Tuple[str, str]] = []
        if ext >= 3:
            picks = choose_subset(primers_subset + segons_subset, k=2)
            rnd_days = rand.sample(DAYS, len(picks))
            required = list(zip(picks, rnd_days))

        # Fluents (ext4 & 5)
        fluents: Dict | None = None
        if ext >= 4:
            fluents = {
                "cal_min": ext_conf["ext4"]["calories_min"],
                "cal_max": ext_conf["ext4"]["calories_max"],
                "dishes": {**primers_sub, **segons_sub},
            }

        metric_flag = ext == 5

        # Render problem text
        if ext == 0:
            problem_text = render_basic_problem(i, primers_subset, segons_subset, incompat_subset)
        elif ext == 1:
            problem_text = render_ext1_problem(i, primers_subset, segons_subset, incompat_subset)
        else:
            problem_text = render_ext2plus_problem(
                ext,
                i,
                primers_subset,
                segons_subset,
                all_tipus,
                incompat_subset,
                {**{d: primers[d]["type"] for d in primers_subset}, **{d: segons[d]["type"] for d in segons_subset}},
                required,
                fluents,
                metric_flag,
            )

        out_path = tc_dir / f"menu-ext{ext if ext else 'basic'}b-tc{i}.pddl"
        out_path.write_text(problem_text, encoding="utf-8")
        print(f"✅  Extension {ext} – test‑case {i} written → {out_path.relative_to(ROOT_DIR)}")
        # Convenience: show suggested FF command
        bin_name = "metric-ff" if ext >= 4 else "ff"
        print("   ▶ run:", f"binaries/linux/{bin_name} -{'O' if ext==5 else ''} -o {out_path.parent/'domain.pddl'} -f {out_path}")


# ---------------------------------------------------------------------------
# CLI entry‑point
# ---------------------------------------------------------------------------

def parse_args():
    ap = argparse.ArgumentParser(description="Generate random PDDL test cases for menu‑planning practice.")
    group = ap.add_mutually_exclusive_group(required=True)
    group.add_argument("--all", action="store_true", help="generate for all extensions (0–5)")
    group.add_argument("--ext", nargs="*", type=int, choices=range(0, 6), metavar="N",
                       help="generate only for the specified extensions (0–5)")
    ap.add_argument("--cases", type=int, default=1, help="number of cases per extension (default 1)")
    ap.add_argument("--seed", type=int, help="random seed for reproducibility")
    return ap.parse_args()


def main():
    args = parse_args()
    rand = random.Random(args.seed)

    targets = list(range(0, 6)) if args.all else args.ext
    for ext in targets:
        generate_for_extension(ext, args.cases, rand)


if __name__ == "__main__":
    main()
