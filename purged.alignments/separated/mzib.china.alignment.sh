#!/bin/bash -l
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=32
#SBATCH --mem=256gb
#SBATCH --time=150:00:00
#SBATCH --output=/mnt/tank/scratch/atomarovsky/purged.alignments/china.mzib.log
#SBATCH --error=/mnt/tank/scratch/atomarovsky/purged.alignments/china.mzib.err
squeue; hostname; date;

assembly="/mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/assemblies/hic.purged/index/bwa/mzib.min_150.pseudohap2.1_HiC.purged.fasta"
sample="china"
samplepath="/mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/reads/filtered/china/"
fastq1="mzib.china.subsampling_220kk_1.fastq.gz"
fastq2="mzib.china.subsampling_220kk_2.fastq.gz"

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/alignment/hic.purged/bwa_alignment/; pwd;

mkdir ${sample}/; cd ${sample}/;


bwa mem -t 10 ${assembly} ${samplepath}/${fastq1} ${samplepath}/${fastq2} -R "@RG\tID:${sample}\tPU:x\tSM:${sample}\tPL:Illumina\tLB:x" | samtools fixmate -@ 6 -m - - | samtools sort -@ 10 -m 12G | samtools markdup -@ 6 - ${sample}.hic.purged.aln.bam ;

samtools index ${sample}.hic.purged.aln.bam;
samtools view -b -@ 20 -q 20 -F 1024 -o ${sample}.hic.purged.bam ${sample}.hic.purged.aln.bam;
samtools index ${sample}.hic.purged.bam;
rm ${sample}.hic.purged.aln.ba*

echo 'finish!'
date


