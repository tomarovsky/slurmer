#!/bin/bash -l
#SBATCH --job-name=trimmon
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=20
#SBATCH --mem=100gb
#SBATCH --time=150:00:00
#SBATCH --output=/mnt/tank/scratch/atomarovsky/trimmon.log
#SBATCH --error=/mnt/tank/scratch/atomarovsky/trimmon.err
squeue; hostname; date;
export TOOLS=/mnt/tank/scratch/atomarovsky/tools/
conda activate mybase

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/reads/manakhov/; pwd;

for i in SRR13213812; do
	mkdir filtered/${i}/;
	trimmomatic PE -threads 20 -phred33 raw/${i}/${i}_1.fastq raw/${i}/${i}_2.fastq filtered/${i}/${i}_1.filt.fastq filtered/${i}/${i}_1.filt.se.fastq filtered/${i}/${i}_2.filt.fastq filtered/${i}/${i}_2.filt.se.fastq ILLUMINACLIP:TruSeq2-PE.fa:2:30:10:1 SLIDINGWINDOW:8:20 MINLEN:50 > filtered/${i}/trim.log 2>&1;
done

echo 'finish!';
date;
