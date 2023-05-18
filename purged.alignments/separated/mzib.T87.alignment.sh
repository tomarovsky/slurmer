#!/bin/bash -l
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=32
#SBATCH --mem=256gb
#SBATCH --time=150:00:00
#SBATCH --output=/mnt/tank/scratch/atomarovsky/purged.alignments/T87.mzib.log
#SBATCH --error=/mnt/tank/scratch/atomarovsky/purged.alignments/T87.mzib.err
squeue; hostname; date;

assembly="/mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/assemblies/hic.purged/index/bwa/mzib.min_150.pseudohap2.1_HiC.purged.fasta"
sample="T87"
samplepath="/mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/resequencing/filtered/kidas/"
fastq1="T87.22x_1.fastq.gz"
fastq2="T87.22x_2.fastq.gz"

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/alignment/hic.purged/bwa_alignment/; pwd;

mkdir ${sample}/; cd ${sample}/;


bwa mem -t 24 ${assembly} ${samplepath}/${sample}/${fastq1} ${samplepath}/${sample}/${fastq2} -R "@RG\tID:${sample}\tPU:x\tSM:${sample}\tPL:Illumina\tLB:x" | samtools fixmate -@ 2 -m - - | samtools sort -@ 4 -m 12G | samtools markdup -@ 2 - ${sample}.hic.purged.aln.bam ;

samtools index ${sample}.hic.purged.aln.bam;
samtools view -b -@ 20 -q 20 -F 1024 -o ${sample}.hic.purged.bam ${sample}.hic.purged.aln.bam;
samtools index ${sample}.hic.purged.bam;
rm ${sample}.hic.purged.aln.ba*

echo 'finish!'
date



