Домашка 4 (Velvet, SPAdes, QUAST) — запуск на SLURM
==================================================

Перед submit:
1) Клон/копия репозитория на кластер. Задайте корень, где лежат data/ и hw4_assembly/:
   export STUD_DIR=/путь/к/вашей/копии
2) Распакуйте риды:
   mkdir -p "$STUD_DIR/data" && unzip -d "$STUD_DIR/data" genome_de_novo.zip
   (должны появиться $STUD_DIR/data/genome_de_novo/*.fastq)
3) Проверьте пути к Velvet, SPAdes, QUAST в env.sh (или задайте переменные VELVETH, SPADES, QUAST).
4) Раскомментируйте #SBATCH -p / -A в скриптах, если на кластере требуется.

Один скрипт на часть 1 (3 k-mer 11,21,31): 01_velvet_kmers.slurm
(Velvet в /bioinformatics/soft/velvet собран с k≤31; k=41/51 невозможны без пересборки.)
Базовый SPAdes (часть 2/3):        02_spades_default.slurm
QUAST Velvet k31 vs SPAdes:       03_quast_part2.slurm
Улучш. SPAdes:                    04_spades_careful.slurm
Улучш. Velvet:                    05_velvet_improved.slurm
QUAST 4 сборки:                    06_quast_part3.slurm

Автоматическая цепочка (зависимости sbatch):
  cd "$STUD_DIR/hw4_assembly/slurm" && bash submit_all.sh

Или вручную по порядку: 01 и 02 параллельно → 03; параллельно 04 и 05 (после 01) → 06
(06 ждёт 01+02+04+05).

Скриншот к отчёту (часть 1), на login-узле/после задачи:
  ls -la --time=ctime "$STUD_DIR/hw4_assembly/velvet"

Отчёты QUAST: hw4_assembly/quast_part2/report.html, hw4_assembly/quast_part3/report.html
 — положить в git, в отчёт вставить скриншоты таблиц.
QUAST: по умолчанию игнор контигов <500 bp. Для сравнения с сильно фрагментированным
Velvet в скриптах 03/06 стоит -m 200 (переменная QUAST_MIN_CONTIG).

Параметры улучш. Velvet (при необходимости):
  export IMPROVE_INSERT=110
  export EXP_COV=90
  export COV_CUTOFF=5
  (подгони по stats.txt после «сырого» velvetg)
