# Подключается из SLURM-скриптов: source "${SLURM_SUBMIT_DIR}/env.sh"
# При необходимости задайте перед sbatch, например: export STUD_DIR=$HOME/mydna/hw4

export STUD_DIR="${STUD_DIR:-$HOME/studfbmf02_03}"
export DATA_DIR="${STUD_DIR}/data/genome_de_novo"
export OUTDIR="${STUD_DIR}/hw4_assembly"
export R1="${DATA_DIR}/7_S4_L001_R1_001.fastq"
export R2="${DATA_DIR}/7_S4_L001_R2_001.fastq"

# Софт (пути с семинара; при отличиях на кластере поправьте)
export VELVETH="${VELVETH:-/home/STUDY/FBMF/bioinformatics/soft/velvet/velveth}"
export VELVETG="${VELVETG:-/home/STUDY/FBMF/bioinformatics/soft/velvet/velvetg}"
export SPADES="${SPADES:-/home/STUDY/FBMF/bioinformatics/soft/SPAdes-4.2.0-Linux/bin/spades.py}"
export QUAST="${QUAST:-/home/STUDY/FBMF/bioinformatics/soft/bin/quast.py}"

# Риды: распакуйте genome_de_novo.zip в $DATA_DIR (два .fastq)
for f in "$R1" "$R2" "$VELVETH" "$VELVETG" "$SPADES" "$QUAST"; do
  if [[ ! -e "$f" ]]; then
    echo "ERROR: file not found: $f" >&2
    exit 1
  fi
done

export THREADS="${SLURM_CPUS_PER_TASK:-16}"
