#!/bin/bash
#SBATCH -J hw5_fastp
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err
#SBATCH --time=02:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${HERE}/env.sh"
mkdir -p "$OUT_TRIM"
# SE: -a не задан → в fastp для read1 делается auto-detect адаптера; окно 5:20 = cut_right; min 36 п.о.
for F in "$FQ1" "$FQ2" "$FQ3" "$FQ4"; do
  B=$(basename "$F" .fastq.gz)
  OUT="${OUT_TRIM}/${B}_trimmed.fastq.gz"
  J="${OUT_TRIM}/${B}.fastp.json"
  H="${OUT_TRIM}/${B}.fastp.html"
  "$FASTP" -i "$F" -o "$OUT" -w "$THREADS" -z 6 \
    -r --cut_right_window_size 5 --cut_right_mean_quality 20 \
    -l 36 -j "$J" -h "$H"
done
ls -la --time=ctime "$OUT_TRIM" || true
