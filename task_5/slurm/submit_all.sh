#!/bin/bash
# Цепочка: FastQC сырых → MultiQC → fastp → FastQC trimmed → MultiQC
set -euo pipefail
D="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$D"
# shellcheck source=env.sh
# shellcheck disable=SC1090
source "${D}/env.sh"
J1=$(sbatch --parsable 01_fastqc_raw.slurm)
J2=$(sbatch --parsable --dependency=afterok:"$J1" 02_multiqc_before.slurm)
J3=$(sbatch --parsable --dependency=afterok:"$J2" 03_fastp_trim.slurm)
J4=$(sbatch --parsable --dependency=afterok:"$J3" 04_fastqc_trim.slurm)
J5=$(sbatch --parsable --dependency=afterok:"$J4" 05_multiqc_after.slurm)
echo "Jobs: 01=$J1 02=$J2 03=$J3 04=$J4 05=$J5"
echo "Совмещённый отчёт (опционально, после ручного прогона):"
echo "  ${PYTHON_M} -m multiqc ${OUT_FQC_RAW} ${OUT_FQC_TRIM} -o ${TASK5}/results/multiqc_both -f -n multiqc_report"
