#!/bin/bash
#SBATCH -J hw4_velvet
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err
#SBATCH --time=04:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem=32G
# При необходимости раскомментируйте и укажите свою партию/аккаунт:
# #SBATCH -p <partition>
# #SBATCH -A <account>

set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${HERE}/env.sh"
cd "${HERE}"

# Часть 1: 3 k-mer с шагом ~10. Стандартный Velvet собирают с MAXKMER=31: k=41/51
# в этой установке невозможны (нужен перекомпил Velvet с большим k). Используем 11,21,31.
# Пример с семинара: ins_length 300.
READ_INSERT="${READ_INSERT:-300}"

for K in 11 21 31; do
  OUT="${OUTDIR}/velvet/k${K}"
  mkdir -p "$OUT"
  echo "=== velveth + velvetg k=${K} -> ${OUT}"
  "$VELVETH" "$OUT" "$K" -fastq -shortPaired "$R1" "$R2"
  "$VELVETG" "$OUT" -ins_length "$READ_INSERT"
  echo "=== done k=${K} contigs: ${OUT}/contigs.fa"
done

echo "Список каталогов (для скриншота в отчёт):"
ls -la --time=ctime "${OUTDIR}/velvet" || true
