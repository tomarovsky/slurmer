#!/bin/bash -l
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=16
#SBATCH --mem=110gb
#SBATCH --time=150:00:00
#SBATCH --array=24,76-79,81-87
#SBATCH --output=/mnt/tank/scratch/atomarovsky/purged.alignments/mzib_T%a.log
#SBATCH --error=/mnt/tank/scratch/atomarovsky/purged.alignments/mzib_T%a.err
squeue; hostname; date;

assembly="/mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/assemblies/hic.purged/index/bwa/mzib.min_150.pseudohap2.1_HiC.purged.fasta"
sample="T${SLURM_ARRAY_TASK_ID}"
samplepath="/mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/resequencing/filtered/kidas/"
fastq1="T${SLURM_ARRAY_TASK_ID}.22x_1.fastq.gz"
fastq2="T${SLURM_ARRAY_TASK_ID}.22x_2.fastq.gz"

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/alignment/hic.purged/bwa_alignment/; pwd;

mkdir ${sample}/; cd ${sample}/;

bwa mem -t 8 ${assembly} ${samplepath}/${sample}/${fastq1} ${samplepath}/${sample}/${fastq2} -R "@RG\tID:${sample}\tPU:x\tSM:${sample}\tPL:Illumina\tLB:x" | samtools fixmate -@ 2 -m - - | samtools sort -@ 4 -m 12G | samtools markdup -@ 2 - ${sample}.hic.purged.bam ;

samtools index ${sample}.hic.purged.bam;

echo 'finish!'
date



