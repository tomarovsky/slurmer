#!/bin/bash
#SBATCH --job-name=S50mm
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=32
#SBATCH --mem=256gb
#SBATCH --time=150:00:00
#SBATCH --output=/mnt/tank/scratch/atomarovsky/logs/S50mm.log
#SBATCH --error=/mnt/tank/scratch/atomarovsky/logs/S50mm.err
squeue;
hostname; date;

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/alignment/hic/bwa_aligment/; pwd;

sample_dir="/mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/resequencing/filtered/"
sample="S50" #T149  T151
assembly="/mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/assemblies/hic/index/bwa_index/mmar.min_150.pseudohap2.1_HiC.fasta"

mkdir ${sample}/; cd ${sample}/;

bwa mem -t 10 ${assembly} ${sample_dir}/${sample}/${sample}.final_1.fastq.gz ${sample_dir}/${sample}/${sample}.final_2.fastq.gz -R '@RG\tID:S50\tPU:x\tSM:S50\tPL:Illumina\tLB:x' | samtools fixmate -@ 6 -m - - | samtools sort -@ 10 -m 12G | samtools markdup -@ 6 - ${sample}.hic.aln.bam ;

samtools index ${sample}.hic.aln.bam;

samtools view -b -@ 10 -q 20 -F 1024 -o ${sample}.hic.bam ${sample}.hic.aln.bam;
rm ${sample}.hic.aln.ba*
samtools index ${sample}.hic.bam;

echo 'finish!'
date
