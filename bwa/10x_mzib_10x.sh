#!/bin/bash
#SBATCH --job-name=10xmzibaln
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=32
#SBATCH --mem=256gb
#SBATCH --time=150:00:00
#SBATCH --output=/nfs/home/atomarovsky/10xmzibaln.log
#SBATCH --error=/nfs/home/atomarovsky/10xmzibaln.err       
squeue;
hostname; date;

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/aligment/hic1/bwa_aligment/10x/; pwd;

bwa mem -t 10 /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/assembles/hic1/index/bwa_index/mzib.min_150.pseudohap2.1_HiC.fasta /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/reads/filtered/mzib_ema.final_1.fastq.gz /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/reads/filtered/mzib_ema.final_2.fastq.gz -R '@RG\tID:10xmzib\tPU:x\tSM:10xmzib\tPL:Illumina\tLB:x' | samtools fixmate -@ 6 -m - - | samtools sort -@ 10 -m 12G | samtools markdup -@ 6 - /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/aligment/hic1/bwa_aligment/10x/10x_mzib.hic1.bam

echo 'finish!'
date
