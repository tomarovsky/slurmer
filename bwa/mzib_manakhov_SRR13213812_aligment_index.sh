#!/bin/bash
#SBATCH --job-name=mzmon12
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=32
#SBATCH --mem=256gb
#SBATCH --time=150:00:00
#SBATCH --output=/mnt/tank/scratch/atomarovsky/mzmon12.log
#SBATCH --error=/mnt/tank/scratch/atomarovsky/mzmon12.err       
squeue;
hostname; date;

bwadir="/mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/aligment/hic/bwa_aligment/"
fasta="/mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/assemblies/hic/index/bwa_index/mzib.min_150.pseudohap2.1_HiC.fasta"
sampledir="/mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/reads/filtered/manakhov/"
sample="SRR13213812"

cd $bwadir; pwd;

mkdir $sample;
cd $sample;


bwa mem -t 10 ${fasta} ${sampledir}/${sample}/${sample}_1.filt.fastq.gz ${sampledir}/${sample}/${sample}_2.filt.fastq.gz -R '@RG\tID:SRR13213812\tPU:x\tSM:SRR13213812\tPL:Illumina\tLB:x' | samtools fixmate -@ 6 -m - - | samtools sort -@ 10 -m 12G | samtools markdup -@ 6 - ${sample}.hic.aln.bam ;

samtools index ${sample}.hic.aln.bam;

samtools view -b -@ 10 -q 20 -F 1024 -o ${sample}.hic.bam ${sample}.hic.aln.bam;

samtools index ${sample}.hic.bam;

echo 'finish!'
date
