#!/bin/bash
#SBATCH --job-name=S26mm10x
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=32
#SBATCH --mem=256gb
#SBATCH --time=150:00:00
#SBATCH --output=/nfs/home/atomarovsky/S26mm10x.log
#SBATCH --error=/nfs/home/atomarovsky/S26mm10x.err       
squeue;
hostname; date;

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/aligment/hic/bwa_aligment/; pwd;

mkdir S26/;
cd S26/;


bwa mem -t 10 /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/assemblies/hic/index/bwa_index/mmar.min_150.pseudohap2.1_HiC.fasta /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/resequencing/sable/reads/filtred_fastq/S26/S26.final_1.fastq.gz /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/resequencing/sable/reads/filtred_fastq/S26/S26.final_2.fastq.gz -R '@RG\tID:S26\tPU:x\tSM:S26\tPL:Illumina\tLB:x' | samtools fixmate -@ 6 -m - - | samtools sort -@ 10 -m 12G | samtools markdup -@ 6 - S26.hic.aln.bam ;

samtools index S26.hic.aln.bam;

samtools view -b -@ 10 -q 20 -F 1024 -o S26.hic.bam S26.hic.aln.bam;

samtools index S26.hic.bam;

echo 'finish!'
date
