#!/bin/bash
#SBATCH -J hw4_quast2
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err
#SBATCH --time=01:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
# #SBATCH -p <partition>

set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${HERE}/env.sh"
cd "${HERE}"

# Часть 2: сравнение Velvet (k=31 как «типичный») и SPAdes (базовая сборка)
# Можно добавить другие k, перечислив -l / -o повторно
VCONT="${OUTDIR}/velvet/k31/contigs.fa"
SCONT="${OUTDIR}/spades/default/contigs.fasta"
QOUT="${OUTDIR}/quast_part2"

mkdir -p "$QOUT"
# -m: Velvet даёт много коротких фрагментов; 500 (дефолт) отбрасывает весь Velvet.
MINC="${QUAST_MIN_CONTIG:-200}"
"$QUAST" -t "$THREADS" -m "$MINC" -o "$QOUT" \
  -l "Velvet_k31,SPAdes_default" \
  "$VCONT" "$SCONT"

echo "Откройте в браузере: ${QOUT}/report.html (положить в репозиторий для задания)"
