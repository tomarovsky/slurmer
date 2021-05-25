#!/bin/bash
#SBATCH --job-name=starimz
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=20
#SBATCH --mem=256gb
#SBATCH --time=150:00:00
#SBATCH --output=/nfs/home/atomarovsky/starimz.log
#SBATCH --error=/nfs/home/atomarovsky/starimz.err       
squeue; hostname; date;
export TOOLS=/mnt/tank/scratch/atomarovsky/tools/;

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/assemblies/hic1/;

$TOOLS/STAR-2.7.8a/bin/Linux_x86_64/STAR --runThreadN 20 --limitGenomeGenerateRAM 31725016672 --runMode genomeGenerate --genomeDir index/STAR/ --genomeFastaFiles mzib.min_150.pseudohap2.1_HiC.fasta;

echo 'finish!';
date;
