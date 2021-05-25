#!/bin/bash
#SBATCH --job-name=10xmartozib
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=30
#SBATCH --mem=200gb
#SBATCH --time=70:00:00
#SBATCH --output=/nfs/home/atomarovsky/10xmartozib.log
#SBATCH --error=/nfs/home/atomarovsky/10xmartozib.err       
squeue;
hostname; date;

# last aligment for mzib - 10xmmar
cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/aligment/hic1/bwa_aligment/10x_mmar/; pwd;
bwa mem -t 10 /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/assembles/hic1/index/bwa_index/mzib.min_150.pseudohap2.1_HiC.fasta /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/reads/filtered/10x/10xmmar.final_1.fastq.gz /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/reads/filtered/10x/10xmmar.final_2.fastq.gz -R '@RG\tID:10xmmar\tPU:x\tSM:10xmmar\tPL:Illumina\tLB:x' | samtools fixmate -@ 6 -m - - | samtools sort -@ 10 -m 12G | samtools markdup -@ 6 - /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/aligment/hic1/bwa_aligment/10x_mmar/10x_mmar.hic1.bam;
echo 'lol! bwa mem 10x_mmar for mzib is DONE!'

# stats for rendering
cd /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/assemblies/hic/; pwd;
~/bashare/assembly_stats.sh -i mmar.min_150.pseudohap2.1_HiC.fasta -n 19;
echo 'lol! assembly_stats for mmar is DONE'

# bwa index
mkdir -p index/bwa_index/;
cd index/bwa_index/;
ln -s ../../mmar.min_150.pseudohap2.1_HiC.fasta mmar.min_150.pseudohap2.1_HiC.fasta;
bwa index mmar.min_150.pseudohap2.1_HiC.fasta;
echo 'lol! bwa_index for mmar is DONE'

echo 'finish!'
date
