# source из SLURM-скриптов: source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/env.sh"
export STUD_DIR="${STUD_DIR:-/home/STUDY/FBMF/studfbmf02_03}"
export TASK5="${STUD_DIR}/task_5"
# сырые fastq: по умолчанию в корне STUD_DIR (куда вы положили ERR*.fastq.gz)
export RAW_DIR="${RAW_DIR:-$STUD_DIR}"
# четыре файла (PRJEB84057), пути по умолчанию — в корне STUD_DIR
export FQ1="${RAW_DIR}/ERR14230593_Illumina_HiSeq_4000_sequencing.fastq.gz"
export FQ2="${RAW_DIR}/ERR14230594_Illumina_HiSeq_4000_sequencing.fastq.gz"
export FQ3="${RAW_DIR}/ERR14230595_Illumina_HiSeq_4000_sequencing.fastq.gz"
export FQ4="${RAW_DIR}/ERR14230607_Illumina_HiSeq_4000_sequencing.fastq.gz"

export PERL_BIN="${PERL_BIN:-/home/STUDY/FBMF/bioinformatics/anaconda3/bin/perl}"
export FASTQC_PL="${FASTQC_PL:-/home/STUDY/FBMF/bioinformatics/anaconda3/opt/fastqc-0.12.1/fastqc}"
export PYTHON_M="${PYTHON_M:-/home/STUDY/FBMF/bioinformatics/anaconda3/bin/python3}"
export CONDA_ENV_FASTP="${CONDA_ENV_FASTP:-$STUD_DIR/.conda_envs/bio_hw5}"
export FASTP="${FASTP:-$CONDA_ENV_FASTP/bin/fastp}"

export OUT_FQC_RAW="${TASK5}/results/fastqc_raw"
export OUT_MQC_BEFORE="${TASK5}/results/multiqc_before"
export OUT_TRIM="${TASK5}/results/trimmed"
export OUT_FQC_TRIM="${TASK5}/results/fastqc_trim"
export OUT_MQC_AFTER="${TASK5}/results/multiqc_after"
export SLURM_CPUS_PER_TASK="${SLURM_CPUS_PER_TASK:-4}"
export THREADS="${SLURM_CPUS_PER_TASK:-4}"

fastqc_one() { "$PERL_BIN" "$FASTQC_PL" -o "$1" -t "$THREADS" "$2"; }
