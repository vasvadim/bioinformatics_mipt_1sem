# Домашнее задание 4: *de novo* — Velvet, SPAdes, QUAST

**Студент:** Василенко Вадим

## Содержание

| Файл / папка | Описание |
|-------------|----------|
| [OTCHET.md](OTCHET.md) | Единый отчёт: части 1–3, выводы |
| [slurm/](slurm/) | SLURM-скрипты и `env.sh` для кластера |
| [quast_part2/](quast_part2/) | QUAST: **Velvet k31** vs **SPAdes default** → `report.html` |
| [quast_part3/](quast_part3/) | QUAST: четыре сборки (старые/улучш. Velvet и SPAdes) → `report.html` |

## Просмотр HTML на GitHub

В репозитории HTML открывается как исходный код. Удобнее скачать `report.html` или клонировать репозиторий и открыть файл в браузере с диска.

## Воспроизведение

1. Распаковать риды в `data/genome_de_novo/` (см. [slurm/README_RU.txt](slurm/README_RU.txt)).  
2. Настроить `STUD_DIR` в [slurm/env.sh](slurm/env.sh) и при необходимости `-p` / `-A` в `.slurm` файлах.  
3. `bash slurm/submit_all.sh` или по отдельности `sbatch …`.

Полные выходы Velvet/SPAdes (контиги, графы) в репозиторий **не** включались — большой объём; их дают те же команды.
