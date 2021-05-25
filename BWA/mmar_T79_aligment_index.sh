#!/bin/bash
#SBATCH --job-name=T79mm10x
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=32
#SBATCH --mem=256gb
#SBATCH --time=150:00:00
#SBATCH --output=/nfs/home/atomarovsky/T79mm10x.log
#SBATCH --error=/nfs/home/atomarovsky/T79mm10x.err       
squeue;
hostname; date;

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/aligment/hic/bwa_aligment/; pwd;

mkdir T79/;
cd T79/;


bwa mem -t 10 /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/assemblies/hic/index/bwa_index/mmar.min_150.pseudohap2.1_HiC.fasta /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/resequencing/kidas/filtred_fastq/T79/T79.final_1.fastq.gz /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/resequencing/kidas/filtred_fastq/T79/T79.final_2.fastq.gz -R '@RG\tID:T79\tPU:x\tSM:T79\tPL:Illumina\tLB:x' | samtools fixmate -@ 6 -m - - | samtools sort -@ 10 -m 12G | samtools markdup -@ 6 - T79.hic.aln.bam ;

samtools index T79.hic.aln.bam;

samtools view -b -@ 10 -q 20 -F 1024 -o T79.hic.bam T79.hic.aln.bam;

samtools index T79.hic.bam;

echo 'finish!'
date
