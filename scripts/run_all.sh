#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# run_all.sh : executa tots els test-cases de basicb + ext1b…ext5b
#              i mostra un resum d’èxit.
# ---------------------------------------------------------------------------

set -u
set -o pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BIN_DIR="$ROOT_DIR/binaries/linux"
LOG_FILE="$ROOT_DIR/scripts/run_all.log"

printf '===== run_all %s =====\n' "$(date -Iseconds)" > "$LOG_FILE"
exec  > >(tee -a "$LOG_FILE") 2>&1
echo

exts=(basicb ext1b ext2b ext3b ext4b ext5b)

total=0
passed=0

for ext in "${exts[@]}"; do
  case_dir="$ROOT_DIR/problems/$ext/test-cases"
  domain="$ROOT_DIR/problems/$ext/domain.pddl"
  [[ ! -d "$case_dir" ]] && { echo "⚠️  No existeix $case_dir"; continue; }

  echo "=== Extension $ext ==="

  # Tria planner i flags
  if   [[ "$ext" == "ext5b" ]]; then
    planner="$BIN_DIR/metric-ff"; extra="-O"
  elif [[ "$ext" == "ext4b" ]]; then
    planner="$BIN_DIR/metric-ff"; extra=""
  else
    planner="$BIN_DIR/ff";        extra=""
  fi

  for pddl in "$case_dir"/*.pddl; do
    [[ -e "$pddl" ]] || continue
    (( total++ ))
    name=$(basename "$pddl")
    echo "→ $name"

    if "$planner" $extra -o "$domain" -f "$pddl" >/dev/null; then
      (( passed++ ))
      echo "   ✔ OK"
    else
      echo "   ✘ FAIL (exit $?)"
    fi
  done
  echo
done

echo "────────────── RESULTATS ──────────────"
echo "Total tests   : $total"
echo "Passats       : $passed"
if (( total > 0 )); then
  pct=$(( 100 * passed / total ))
  echo "Percentatge   : $pct %"
fi
