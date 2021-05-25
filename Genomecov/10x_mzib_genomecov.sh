#!/bin/bash
#SBATCH --job-name=10xgcov
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=22
#SBATCH --mem=150gb
#SBATCH --time=50:00:00
#SBATCH --output=/nfs/home/atomarovsky/10xgcov.log
#SBATCH --error=/nfs/home/atomarovsky/10xgcov.err       
squeue; hostname; date;

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/aligment/hic1/bwa_aligment/10x/; pwd;

bedtools genomecov -ibam 10x.hic1.bam -d | gzip > genomecov_10x.hic1.tab.gz;

echo 'finish!';
date;
