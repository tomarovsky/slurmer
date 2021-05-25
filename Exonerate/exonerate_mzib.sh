#!/bin/bash -l
#SBATCH --array=1-209%50
#SBATCH --time=100:00:00          # Run time in hh:mm:ss
#SBATCH --mem-per-cpu=8192       # Minimum memory required per CPU (in megabytes)
#SBATCH --job-name=exomzib
#SBATCH --error=/nfs/home/atomarovsky/logfiles/exomzib.%A_%a.err
#SBATCH --output=/nfs/home/atomarovsky/logfiles/exomzib.%A_%a.log

conda activate mybase

SPLITED_PEP_DIR="/mnt/tank/scratch/skliver/common/mustelidae/lontra_canadensis/protein/splited/"

PEP_FILE="${SPLITED_PEP_DIR}lcan.protein.filtered_${SLURM_ARRAY_TASK_ID}.fasta"
MZIB_GENOME="/mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/assemblies/hic1/mzib.min_150.pseudohap2.1_HiC.fasta"
OUTDIR="/mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/annotation/hic1/exonerate/"
EXONERATE_OUTPUT_FILE="${OUTDIR}exonerate_lcan_to_mzib_${SLURM_ARRAY_TASK_ID}.out"

exonerate  --model protein2genome --showalignment --showquerygff --showtargetgff \
	           -n 10 -q ${PEP_FILE} -t ${MZIB_GENOME} > ${EXONERATE_OUTPUT_FILE}
