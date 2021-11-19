#!/bin/bash
#SBATCH --job-name=10x10xmmmzib
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=32
#SBATCH --mem=256gb
#SBATCH --time=150:00:00
#SBATCH --output=/nfs/home/atomarovsky/10xmar10xmmar.log
#SBATCH --error=/nfs/home/atomarovsky/10xmar10xmmar.err       
squeue;
hostname; date;

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/aligment/hic/bwa_aligment/; pwd;

mkdir 10x_mmar/;
cd 10x_mmar/;


bwa mem -t 10 /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/assemblies/hic/index/bwa_index/mmar.min_150.pseudohap2.1_HiC.fasta /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/reads/filtered/10x/10xmmar.final_1.fastq.gz /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/reads/filtered/10x/10xmmar.final_2.fastq.gz -R '@RG\tID:10xmmar\tPU:x\tSM:10xmmar\tPL:Illumina\tLB:x' | samtools fixmate -@ 6 -m - - | samtools sort -@ 10 -m 12G | samtools markdup -@ 6 - 10x_mmar.hic.aln.bam ;

samtools index 10x_mmar.hic.aln.bam;

samtools view -b -@ 10 -q 20 -F 1024 -o 10x_mmar.hic.bam 10x_mmar.hic.aln.bam;

samtools index 10x_mmar.hic.bam;

echo 'finish!'
date
