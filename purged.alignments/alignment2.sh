#!/usr/bin/env bash
#SBATCH --time=150:00:00
#SBATCH --cpus-per-task=26
#SBATCH --mem=150000

#SBATCH --output=alignment2.log
#SBATCH --error=alignment2.err

ASSEMBLY="/mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/assemblies/hic.purged/index/bwa/mzib.min_150.pseudohap2.1_HiC.purged.fasta"

READ_DIR="/mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/resequencing/filtered/sable/"

for SAMPLE in 10xmzib china S26 T118 T150 T194 T50 T8 T104 T148 T18 T26 T72 T90;
	do
	mkdir -p ${SAMPLE}
	bwa mem -R "@RG\tID:${SAMPLE}\tPU:x\tSM:${SAMPLE}\tPL:Illumina\tLB:x" -t 22 ${ASSEMBLY} <(zcat ${READ_DIR}/${SAMPLE}/${SAMPLE}.22x_1.fastq.gz) <(zcat ${READ_DIR}/${SAMPLE}/${SAMPLE}.22x_2.fastq.gz)  | samtools fixmate -@ 2 -m - - | samtools sort -T ${SAMPLE}/${SAMPLE} -@ 4 -m 12G | samtools markdup -@ 2 - ${SAMPLE}/${SAMPLE}.mzib.hic.purged.mkdup.bam 

	samtools index ${SAMPLE}/${SAMPLE}.mzib.hic.purged.mkdup.bam
       	mosdepth -t 4 ${SAMPLE}/${SAMPLE}.mzib.hic.purged.mkdup ${SAMPLE}/${SAMPLE}.mzib.hic.purged.mkdup.bam
	done


