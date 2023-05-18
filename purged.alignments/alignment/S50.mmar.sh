#!/usr/bin/env bash
#SBATCH --time=150:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem=110000
#SBATCH --output=/mnt/tank/scratch/atomarovsky/purged.alignments/mmar_S50.log
#SBATCH --error=/mnt/tank/scratch/atomarovsky/purged.alignments/mmar_S50.err

ASSEMBLY="/mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/assemblies/hic.purged/index/bwa/mmar.min_150.pseudohap2.1_HiC.purged.fasta"

READ_DIR=/mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/resequencing/filtered

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/alignment/hic.purged/bwa_alignment/; pwd;

mkdir S50;

for SAMPLE in S50;
	do
	cd ${SAMPLE}
	bwa mem -R "@RG\tID:${SAMPLE}\tPU:x\tSM:${SAMPLE}\tPL:Illumina\tLB:x" -t 8 ${ASSEMBLY} <(zcat ${READ_DIR}/${SAMPLE}/${SAMPLE}.22x_1.fastq.gz) <(zcat ${READ_DIR}/${SAMPLE}/${SAMPLE}.22x_2.fastq.gz)  | samtools fixmate -@ 2 -m - - | samtools sort -@ 4 -m 12G | samtools markdup -@ 2 - ${SAMPLE}.mmar.hic.purged.mkdup.bam 

	samtools index ${SAMPLE}.mmar.hic.purged.mkdup.bam
       	mosdepth -t 4 ${SAMPLE}.mmar.hic.purged.mkdup ${SAMPLE}.mmar.hic.purged.mkdup.bam
	done


