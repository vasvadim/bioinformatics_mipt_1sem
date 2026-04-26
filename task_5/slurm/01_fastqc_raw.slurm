#!/bin/bash
#SBATCH -J hw5_fqc_raw
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err
#SBATCH --time=02:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=env.sh
source "${HERE}/env.sh"
mkdir -p "$OUT_FQC_RAW"
for F in "$FQ1" "$FQ2" "$FQ3" "$FQ4"; do
  fastqc_one "$OUT_FQC_RAW" "$F"
done
