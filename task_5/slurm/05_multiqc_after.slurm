#!/bin/bash
#SBATCH -J hw5_mqc2
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err
#SBATCH --time=00:30:00
#SBATCH --cpus-per-task=2
#SBATCH --mem=4G
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${HERE}/env.sh"
mkdir -p "$OUT_MQC_AFTER"
"$PYTHON_M" -m multiqc "$OUT_FQC_TRIM" -o "$OUT_MQC_AFTER" -f -n multiqc_report
