#!/bin/bash
#SBATCH -J hw4_spades_careful
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err
#SBATCH --time=12:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
# #SBATCH -p <partition>
# #SBATCH -A <account>

set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${HERE}/env.sh"
cd "${HERE}"

# Часть 3: «улучшенный» SPAdes — базовая коррекция ридов и снижение ошибок в графе
OUT="${OUTDIR}/spades/careful"
mkdir -p "$OUT"
rm -rf "${OUT}"/*

"$SPADES" -1 "$R1" -2 "$R2" -o "$OUT" -t "$THREADS" -m 64 --careful
echo "Готово: ${OUT}/contigs.fasta"
