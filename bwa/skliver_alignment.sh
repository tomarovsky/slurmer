#!/usr/bin/env bash
#SBATCH --time=150:00:00
#SBATCH --cpus-per-task=26
#SBATCH --mem=150000

#SBATCH --output=alignment1.log
#SBATCH --error=alignment1.err

ASSEMBLY="/mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/assemblies/hic.purged/index/bwa/mmar.min_150.pseudohap2.1_HiC.purged.fasta"

READ_DIR=/mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/resequencing/filtered

for SAMPLE in 10xmmar S44 S46 S49 T149 T151;
	do
	mkdir -p ${SAMPLE}
	bwa mem -R "@RG\tID:${SAMPLE}\tPU:x\tSM:${SAMPLE}\tPL:Illumina\tLB:x" -t 18 ${ASSEMBLY} <(zcat ${READ_DIR}/${SAMPLE}/${SAMPLE}.22x_1.fastq.gz) <(zcat ${READ_DIR}/${SAMPLE}/${SAMPLE}.22x_2.fastq.gz)  | samtools fixmate -@ 2 -m - - | samtools sort -@ 4 -m 12G | samtools markdup -@ 2 - ${SAMPLE}/${SAMPLE}.mmar.hic.purged.mkdup.bam 

	samtools index ${SAMPLE}/${SAMPLE}.mmar.hic.purged.mkdup.bam
       	mosdepth -t 4 ${SAMPLE}/${SAMPLE}.mmar.hic.purged.mkdup ${SAMPLE}/${SAMPLE}.mmar.hic.purged.mkdup.bam
	done


