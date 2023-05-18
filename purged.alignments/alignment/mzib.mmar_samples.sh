#!/usr/bin/env bash
#SBATCH --time=150:00:00
#SBATCH --cpus-per-task=26
#SBATCH --mem=150000
#SBATCH --output=/mnt/tank/scratch/atomarovsky/purged.alignments/mzib.mmar_alignments.log
#SBATCH --error=/mnt/tank/scratch/atomarovsky/purged.alignments/mzib.mmar_alignments.err

ASSEMBLY="/mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/assemblies/hic.purged/index/bwa/mzib.min_150.pseudohap2.1_HiC.purged.fasta"
READ_DIR=/mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/resequencing/filtered

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/alignment/hic.purged/bwa_alignment/; pwd;

for SAMPLE in 10xmmar S44 S46 S49 S50 T149 T151;
	do
	mkdir ${SAMPLE}
	cd ${SAMPLE}
	bwa mem -R "@RG\tID:${SAMPLE}\tPU:x\tSM:${SAMPLE}\tPL:Illumina\tLB:x" -t 22 ${ASSEMBLY} <(zcat ${READ_DIR}/${SAMPLE}/${SAMPLE}.22x_1.fastq.gz) <(zcat ${READ_DIR}/${SAMPLE}/${SAMPLE}.22x_2.fastq.gz)  | samtools fixmate -@ 2 -m - - | samtools sort -@ 4 -m 12G | samtools markdup -@ 2 - ${SAMPLE}.mzib.hic.purged.mkdup.bam 

	samtools index ${SAMPLE}.mzib.hic.purged.mkdup.bam
       	mosdepth -t 4 ${SAMPLE}.mzib.hic.purged.mkdup ${SAMPLE}.mzib.hic.purged.mkdup.bam
	cd ..
	done


