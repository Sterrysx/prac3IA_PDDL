#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# run_all.sh : executa tots els test-cases de totes les extensions
#              i mostra un resum d’èxit.
# ---------------------------------------------------------------------------

set -u          # error si una variable no està definida
set -o pipefail # propaga errors dins pipes

# ─── Rutes bàsiques ───────────────────────────────────────────────────────
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BIN_DIR="$ROOT_DIR/binaries/linux"
LOG_FILE="$ROOT_DIR/scripts/run_all.log"

# ─── Inicia log global ────────────────────────────────────────────────────
printf '===== run_all %s =====\n' "$(date -Iseconds)" > "$LOG_FILE"
exec  > >(tee -a "$LOG_FILE") 2>&1
echo

# ─── Paràmetres de control ────────────────────────────────────────────────
exts=(ext1b ext2b ext3b ext4b ext5b)

total=0
passed=0

# ─── Bucle principal ──────────────────────────────────────────────────────
for ext in "${exts[@]}"; do
  case_dir="$ROOT_DIR/problems/$ext/test-cases"
  domain="$ROOT_DIR/problems/$ext/domain.pddl"

  [[ ! -d "$case_dir" ]] && { echo "⚠️  No existeix $case_dir"; continue; }

  echo "=== Extension $ext ==="

  # Selecciona executable i flags
  if   [[ "$ext" == "ext5b" ]]; then
    planner="$BIN_DIR/metric-ff"; extra="-O"
  elif [[ "$ext" == "ext4b" ]]; then
    planner="$BIN_DIR/metric-ff"; extra=""
  else
    planner="$BIN_DIR/ff";        extra=""
  fi

  for pddl in "$case_dir"/*.pddl; do
    [[ -e "$pddl" ]] || continue   # dir buit?

    ((total++))
    name=$(basename "$pddl")
    echo "→ $name"

    if "$planner" $extra -o "$domain" -f "$pddl" >/dev/null; then
      ((passed++))
      echo "   ✔ OK"
    else
      echo "   ✘ FAIL (exit $?)"
    fi
  done
  echo
done

# ─── Resum ────────────────────────────────────────────────────────────────
echo "────────────── RESULTATS ──────────────"
echo "Total tests   : $total"
echo "Passats       : $passed"
if (( total > 0 )); then
  pct=$(( 100 * passed / total ))
  echo "Percentatge   : $pct %"
fi
