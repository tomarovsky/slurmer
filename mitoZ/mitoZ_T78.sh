#!/bin/bash -i
#SBATCH --job-name=mitozT78
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=10
#SBATCH --mem=256gb
#SBATCH --time=150:00:00
#SBATCH --output=/nfs/home/atomarovsky/mitozT78.log
#SBATCH --error=/nfs/home/atomarovsky/mitozT78.err       
squeue; hostname; date;
export TOOLS=/mnt/tank/scratch/atomarovsky/tools/;
conda activate mitozEnv;

sample="T78"
fastq1="/mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/resequencing/kidas/filtered_fastq/${sample}/subsampling/${sample}.subsampling_1_15kk.fastq.gz"
fastq2="/mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/resequencing/kidas/filtered_fastq/${sample}/subsampling/${sample}.subsampling_2_15kk.fastq.gz"

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/annotation/hic/mitoZ/;
mkdir ${sample}; cd ${sample};

python3 $TOOLS/release_MitoZ_v2.3/MitoZ.py all2 --genetic_code 2 --clade Chordata --outprefix ${sample} --thread_number 10 --fastq1 ${fastq1} --fastq2 ${fastq2} --fastq_read_length 150 --insert_size 350 --run_mode 2 --filter_taxa_method 1 --requiring_taxa 'Mammalia'

echo 'finish!';
date;
