#!/bin/bash -i
#SBATCH --job-name=mitozchina
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=10
#SBATCH --mem=256gb
#SBATCH --time=150:00:00
#SBATCH --output=/nfs/home/atomarovsky/mitozchina.log
#SBATCH --error=/nfs/home/atomarovsky/mitozchina.err       
squeue; hostname; date;
export TOOLS=/mnt/tank/scratch/atomarovsky/tools/;
conda activate mitozEnv;

fastq1="/mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/reads/china/filtered_reads/subsampling/m_zibellina.subsampling_1_15kk.fastq.gz"
fastq2="/mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/reads/china/filtered_reads/subsampling/m_zibellina.subsampling_2_15kk.fastq.gz"

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/annotation/china/mitoZ/;


python3 $TOOLS/release_MitoZ_v2.3/MitoZ.py all2 --genetic_code 2 --clade Chordata --outprefix mzib.china --thread_number 10 --fastq1 ${fastq1} --fastq2 ${fastq2} --fastq_read_length 150 --insert_size 350 --run_mode 2 --filter_taxa_method 1 --requiring_taxa 'Mammalia'

echo 'finish!';
date;
