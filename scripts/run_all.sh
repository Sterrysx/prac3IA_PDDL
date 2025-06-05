#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# run_all.sh — ejecuta todos los test-cases usando rutas convertidas con wslpath
#              para que los ejecutables Windows (ff.exe / metricff.exe) funcionen.
#   • El log se guarda en scripts/run_all.log
#   • Cada bloque de prueba queda claramente identificado en el log.
# ---------------------------------------------------------------------------

set -euo pipefail

# Ajusta esta ruta si tu proyecto está en otro sitio
ROOT_DIR="/mnt/c/Users/sterr/Desktop/prac3IA_PDDL"
FF_WIN="$ROOT_DIR/binaries/ff.exe"
METRIC_FF_WIN="$ROOT_DIR/binaries/metricff.exe"
GLOBAL_LOG="$ROOT_DIR/scripts/run_all.log"

# Inicializa el log global
printf '===== run_all — %s =====\n' "$(date -Iseconds)" > "$GLOBAL_LOG"
# Duplica la salida del script a pantalla y log
exec > >(tee -a "$GLOBAL_LOG") 2>&1

total=0
passed=0
EXTS=(ext1b ext2b ext3b ext4b ext5b)

echo
for ext in "${EXTS[@]}"; do
  CASE_DIR="$ROOT_DIR/problems/$ext/test-case"
  [[ ! -d "$CASE_DIR" ]] && continue
  echo "=== Procesando extensión: $ext ==="

  for unix_pddl in "$CASE_DIR"/menu-auto-"$ext"-*.pddl; do
    [[ ! -e "$unix_pddl" ]] && continue

    (( total++ ))
    NAME=$(basename "$unix_pddl")

    # Encabezado por caso
    echo -e "\n===== $ext / $NAME ====="

    # Ruta Unix al dominio y al problema 
    unix_domain="$ROOT_DIR/problems/$ext/domain.pddl"
    # El propio unix_pddl ya es /mnt/c/.../menu-auto-...
    # Convertimos ambos a Windows con wslpath:
    win_domain=$(wslpath -w "$unix_domain")
    win_pddl=$(wslpath -w "$unix_pddl")

    if [[ "$ext" == "ext4b" || "$ext" == "ext5b" ]]; then
      "$METRIC_FF_WIN" -O -o "$win_domain" -f "$win_pddl"
      CODE=$?
    else
      "$FF_WIN" -o "$win_domain" -f "$win_pddl"
      CODE=$?
    fi

    if [[ $CODE -eq 0 ]]; then
      (( passed++ ))
      echo "[OK]  $NAME"
    else
      echo "[FAIL] $NAME  (exit code: $CODE)"
    fi
  done

  echo
done

echo "—————————————————————————————"
echo "Total tests: $total"
echo "Tests pasados: $passed"
if [[ $total -gt 0 ]]; then
  pct=$(( passed * 100 / total ))
  echo "Porcentaje de éxito: $pct %"
fi
