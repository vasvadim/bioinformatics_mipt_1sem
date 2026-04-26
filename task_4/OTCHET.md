# Домашнее задание 4: Velvet, SPAdes, QUAST

**Курс:** биоинформатика, 1 семестр  
**Студент:** Василенко Вадим

---

## Часть 1 — Сборка Velvet (несколько k-mer)

### SLURM

Используется скрипт [slurm/01_velvet_kmers.slurm](slurm/01_velvet_kmers.slurm). Запуск на кластере:

```bash
cd task_4/slurm
sbatch 01_velvet_kmers.slurm
```

(На обучающем сервере те же вызовы `velveth` / `velvetg` выполнялись без Slurm, логика совпадает с этим скриптом.)

**О k-mer.** Установка Velvet в `/home/STUDY/FBMF/bioinformatics/soft/velvet` собрана с **максимальным k = 31**; значения 41 и 51 из примера задания **недоступны** без пересборки с большим `MAXKMER_LENGTH`. Использованы три k-mer с шагом ≈10: **k = 11, 21, 31**. Для `velvetg` задан **`-ins_length 300`**, как в примере с семинара (переменная `READ_INSERT` в скрипте).

### Список каталогов со сборками

Команда: `ls -la --time=ctime <каталог_с_velvet>`

пример фактического вывода (все k + улучш. каталог в части 3):

```text
total 0
drwxr-xr-x. 6 studfbmf02_03 fbmf 4 Apr 26 19:19 .
drwxr-xr-x. 7 studfbmf02_03 fbmf 5 Apr 26 19:20 ..
drwxr-xr-x. 2 studfbmf02_03 fbmf 8 Apr 26 19:18 k11
drwxr-xr-x. 2 studfbmf02_03 fbmf 8 Apr 26 19:18 k21
drwxr-xr-x. 2 studfbmf02_03 fbmf 8 Apr 26 19:18 k31
drwxr-xr-x. 2 studfbmf02_03 fbmf 8 Apr 26 19:19 k31_tuned
```

Каталог `k31_tuned` относится к **части 3** (не к части 1).

---

## Часть 2 — Сравнение Velvet и SPAdes (QUAST)

| Что | Путь / заметка |
|-----|----------------|
| SPAdes (база) | каталог `spades/default` на машине, где гонялась сборка |
| Velvet | k = 31, `contigs.fa` |
| **Интерактивный отчёт QUAST** | [quast_part2/report.html](quast_part2/report.html) |

**Параметр QUAST** **`-m 200`**: при дефолте **`-m 500`** контиги Velvet почти целиком отфильтровываются, поэтому сравнение с SPAdes получается пустым по стороне Velvet. Порог задан в [slurm/03_quast_part2.slurm](slurm/03_quast_part2.slurm) (`QUAST_MIN_CONTIG`).

### Сводка (контиги **≥ 200** bp, по `report.txt`)

| Метрика         | Velvet_k31 | SPAdes_default |
|-----------------|------------|----------------|
| # contigs      | 14         | 27             |
| Total length   | 3492       | 12128          |
| N50            | 243        | 517            |

**Выводы (часть 2).**  
SPAdes даёт **более длинные** контиги (выше N50 и суммарная длина) и **меньшую** фрагментацию, чем Velvet на этих ридах. Это согласуется с **мультик-мерной** схемой и **коррекцией ридов** в SPAdes; у Velvet один k и жёстко заданный `ins_length=300` при **оценочном** insert size ≈**109** bp (из лога SPAdes), что ухудшает использование пары ридов.

**Какая сборка лучше по QUAST** — **SPAdes** (N50, длина, крупные фрагменты).

---

## Часть 3 — Улучшение сборки

1. **SPAdes:** флаг **`--careful`**.  
2. **Velvet:** `ins_length=110`, **`-exp_cov`**, **`-cov_cutoff`**, **`-scaffolding yes`** (см. [slurm/05_velvet_improved.slurm](slurm/05_velvet_improved.slurm)).

**QUAST на четыре сборки:** [quast_part3/report.html](quast_part3/report.html) (тот же **`-m 200`**).

### Сводка (контиги **≥ 200** bp)

| Сборка            | # contigs | Total length | N50  |
|-------------------|----------:|-------------:|-----:|
| Velvet_k31        | 14        | 3492         | 243  |
| Velvet_k31_tuned  | 13        | 4183         | 332  |
| SPAdes_default    | 27        | 12128        | 517  |
| SPAdes_careful    | 27        | 12128        | 517  |

**Выводы (часть 3).**  
**Velvet (tuned)** лучше «сырого» k31: выше N50 и total length.  
**SPAdes careful** на этом наборе **совпал** с default в таблице QUAST.  
Итог: настройка Velvet **имеет смысл**; **лучшая** по метрикам остаётся **SPAdes**.

---

## Общие выводы

1. Набор k-mer (11, 21, 31) и **согласованный** `ins_length` (по оценке вставки из лога/маппинга) сильно влияют на Velvet.  
2. **SPAdes** на этих данных **предпочтительнее** по N50/длине.  
3. В **QUAST** при мелких контигах нужно явно задать **`-m`**, иначе одна из сборок **пропадёт** из отчёта.

---

**Дата прогонов:** 2026-04-26.  
**Среда:** Linux, 4 CPU (те же команды, что в `slurm/` — при необходимости на кластере с `sbatch`).
