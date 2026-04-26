#!/bin/bash
# Запуск цепочки: распаковать data, выставить STUD_DIR, затем:
#   cd $STUD_DIR/hw4_assembly/slurm && bash submit_all.sh
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

# Опционально: export STUD_DIR=/путь/к/репозиторию
# sbatch 01... — номера задач в очереди; при строгом порядке — используйте зависимости:

J1=$(sbatch --parsable 01_velvet_kmers.slurm)
J2=$(sbatch --parsable 02_spades_default.slurm)
echo "Velvet: $J1, SPAdes default: $J2"
J3=$(sbatch --parsable --dependency=afterok:"${J1},${J2}" 03_quast_part2.slurm)
echo "QUAST part2 (после Velvet+SPAdes default): $J3"

J4=$(sbatch --parsable 04_spades_careful.slurm)
J5=$(sbatch --parsable --dependency=afterok:"${J1}" 05_velvet_improved.slurm)
echo "SPAdes careful: $J4, Velvet tuned: $J5 (после k31 в 01; tuned использует k31_tuned)"
J6=$(sbatch --parsable --dependency=afterok:"${J1},${J2},${J4},${J5}" 06_quast_part3.slurm)
echo "QUAST 4-way: $J6 (после всех четырёх сборок)"

echo "Смотрите *.out / *.err в $DIR, результаты в \${STUD_DIR}/hw4_assembly/"
