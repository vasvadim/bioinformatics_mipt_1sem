#!/bin/bash
#SBATCH -J hw5_fqc_tr
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err
#SBATCH --time=02:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${HERE}/env.sh"
mkdir -p "$OUT_FQC_TRIM"
for F in "$OUT_TRIM"/*_trimmed.fastq.gz; do
  [[ -e "$F" ]] || { echo "No trimmed files" >&2; exit 1; }
  fastqc_one "$OUT_FQC_TRIM" "$F"
done
