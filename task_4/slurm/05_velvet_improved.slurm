#!/bin/bash
#SBATCH -J hw4_velvet_tuned
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err
#SBATCH --time=04:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem=32G
# #SBATCH -p <partition>

set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${HERE}/env.sh"
cd "${HERE}"

# Улучшенный Velvet: insert ~ оценка из лога SPAdes (у мелкогеномных часто 100–150),
# + отсечение слабых узлов + ожидаемое покрытие (подправьте после первого прогона по stats)
K="${IMPROVE_K:-31}"
READ_INSERT="${IMPROVE_INSERT:-110}"
EXP_COV="${EXP_COV:-90}"
COV_CUTOFF="${COV_CUTOFF:-5}"

OUT="${OUTDIR}/velvet/k${K}_tuned"
mkdir -p "$OUT"
rm -rf "${OUT}"/*

echo "k=$K ins_length=$READ_INSERT exp_cov=$EXP_COV cov_cutoff=$COV_CUTOFF -> $OUT"

"$VELVETH" "$OUT" "$K" -fastq -shortPaired "$R1" "$R2"
"$VELVETG" "$OUT" \
  -ins_length "$READ_INSERT" \
  -exp_cov "$EXP_COV" \
  -cov_cutoff "$COV_CUTOFF" \
  -scaffolding yes

echo "Готово: ${OUT}/contigs.fa (сравните N50/ошибки с k${K} без exp_cov/cov в QUAST)"
