#!/bin/bash -i
#SBATCH --job-name=trimcmz
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=20
#SBATCH --mem=100gb
#SBATCH --time=150:00:00
#SBATCH --output=/nfs/home/atomarovsky/trimcmz.log
#SBATCH --error=/nfs/home/atomarovsky/trimcmz.err
squeue; hostname; date;
export TOOLS=/mnt/tank/scratch/atomarovsky/tools/
conda activate mybase

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina_china/transcriptome/; pwd;

for i in SRR8074161 SRR8074163 SRR8074165 SRR8074168 SRR8074169; do
	trimmomatic PE -threads 20 -phred33 raw/${i}/${i}_1.fastq raw/${i}/${i}_2.fastq filtered/${i}/${i}_1.filt.fastq filtered/${i}/${i}_1.filt.se.fastq filtered/${i}/${i}_2.filt.fastq filtered/${i}/${i}_2.filt.se.fastq ILLUMINACLIP:TruSeq2-PE.fa:2:30:10:1 SLIDINGWINDOW:8:20 MINLEN:50 > filtered/${i}/trim.log 2>&1;
done

echo 'finish!';
date;
