#!/bin/bash
#SBATCH --job-name=starmz1523
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=32
#SBATCH --mem=256gb
#SBATCH --time=150:00:00
#SBATCH --output=/nfs/home/atomarovsky/starmz1523.log
#SBATCH --error=/nfs/home/atomarovsky/starmz1523.err       
squeue; hostname; date;
export TOOLS=/mnt/tank/scratch/atomarovsky/tools/
cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/aligment/hic1/STAR_aligment/; pwd;

# $TOOLS/STAR-2.7.8a/bin/Linux_x86_64/STAR --runThreadN 32 --genomeDir /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/assemblies/hic1/index/STAR --readFilesCommand zcat --readFilesIn /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/transcriptome/altai_farm/filtred_fastq/15-1b/15-1b.final_1.fastq.gz /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/transcriptome/altai_farm/filtred_fastq/15-1b/15-1b.final_2.fastq.gz --outSAMtype BAM Unsorted --outFileNamePrefix /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/aligment/hic1/STAR_aligment/15-1b/ --twopassMode Basic ;
cd 15-1b;
samtools index Aligned.out.bam;
samtools sort -@ 10 Aligned.out.bam -o 15-1b.bam;
samtools index 15-1b.bam;
cd ..;

# $TOOLS/STAR-2.7.8a/bin/Linux_x86_64/STAR --runThreadN 32 --genomeDir /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/assemblies/hic1/index/STAR --readFilesCommand zcat --readFilesIn /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/transcriptome/altai_farm/filtred_fastq/23-1b/23-1b.final_1.fastq.gz /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/transcriptome/altai_farm/filtred_fastq/23-1b/23-1b.final_2.fastq.gz --outSAMtype BAM Unsorted --outFileNamePrefix /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/aligment/hic1/STAR_aligment/23-1b/ --twopassMode Basic ;

cd 23-1b;
samtools index Aligned.out.bam;
samtools sort -@ 10 Aligned.out.bam -o 23-1b.bam;
samtools index 23-1b.bam;
cd ..;

echo 'finish!';
date;
