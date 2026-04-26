# Задание 5: FastQC, MultiQC, тримминг (fastp)

**Студент:** Василенко Вадим (репозиторий [bioinformatics_mipt_1sem](https://github.com/vasvadim/bioinformatics_mipt_1sem))  
**Проект SRA:** PRJEB84057, выбраны 4 run (single-end `*.fastq.gz` в корне `STUD_DIR`).

## Структура

| Каталог / файл | Назначение |
|----------------|------------|
| [OTCHET.md](OTCHET.md) | Единый отчёт (части 1–3) |
| [slurm/](slurm/) | `env.sh`, сценарии `01`…`05`, `submit_all.sh` |
| [results/fastqc_raw/](results/fastqc_raw/) | FastQC по сырым ридам |
| [results/multiqc_before/](results/multiqc_before/) | `multiqc_report.html` (до) |
| [results/trimmed/](results/trimmed/) | `*_trimmed.fastq.gz` + отчёты fastp (json/html) |
| [results/fastqc_trim/](results/fastqc_trim/) | FastQC по очищенным |
| [results/multiqc_after/](results/multiqc_after/) | `multiqc_report.html` (после) |
| [results/multiqc_both/](results/multiqc_both/) | один MultiQC по raw+trim (сравнение) |

## Окружение (кластер / сервер)

- **FastQC:** запуск через `perl` из Anaconda (см. `env.sh` — в системе Perl без `FindBin` ломает обёртку).  
- **MultiQC:** `python3 -m multiqc` (модуль в Anaconda).  
- **fastp:** conda-окружение `studfbmf02_03/.conda_envs/bio_hw5` (bioconda). Создание:  
  `conda create -y -p "$STUD_DIR/.conda_envs/bio_hw5" -c bioconda -c conda-forge fastp`

## Запуск (SLURM)

```bash
export STUD_DIR=/home/STUDY/FBMF/studfbmf02_03   # свой путь
cd "$STUD_DIR/task_5/slurm"
# при необходимости: #SBATCH -p … в файлах
sbatch 01_fastqc_raw.slurm
# … или: bash submit_all.sh
```

Сырые файлы ожидаются по путям из [slurm/env.sh](slurm/env.sh) (`ERR14230593_…` и т.д. в `STUD_DIR`).

## Просмотр MultiQC в браузере

Скачайте `results/multiqc_before/multiqc_report.html` (и `multiqc_after`) или откройте локально после `git clone`.
