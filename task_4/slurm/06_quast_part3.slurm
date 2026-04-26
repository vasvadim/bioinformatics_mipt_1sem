#!/bin/bash
#SBATCH -J hw4_quast4
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

# Часть 3: 4 сборки — старый/новый SPAdes, старый/новый Velvet
V_OLD="${OUTDIR}/velvet/k31/contigs.fa"
V_NEW="${OUTDIR}/velvet/k31_tuned/contigs.fa"
S_OLD="${OUTDIR}/spades/default/contigs.fasta"
S_NEW="${OUTDIR}/spades/careful/contigs.fasta"
QOUT="${OUTDIR}/quast_part3"

for f in "$V_OLD" "$V_NEW" "$S_OLD" "$S_NEW"; do
  if [[ ! -f "$f" ]]; then
    echo "ERROR: сначала запустите соответствующие задачи, нет файла: $f" >&2
    exit 1
  fi
done

mkdir -p "$QOUT"
MINC="${QUAST_MIN_CONTIG:-200}"
"$QUAST" -t "$THREADS" -m "$MINC" -o "$QOUT" \
  -l "Velvet_k31,Velvet_k31_tuned,SPAdes_default,SPAdes_careful" \
  "$V_OLD" "$V_NEW" "$S_OLD" "$S_NEW"

echo "Откройте: ${QOUT}/report.html"
