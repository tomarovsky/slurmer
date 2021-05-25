#!/bin/bash
#SBATCH --job-name=lastalmm
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=15
#SBATCH --mem=256gb
#SBATCH --time=150:00:00
#SBATCH --output=/nfs/home/atomarovsky/lastalmm.log
#SBATCH --error=/nfs/home/atomarovsky/lastalmm.err       
squeue; hostname; date;
export TOOLS=/mnt/tank/scratch/atomarovsky/tools/
export PATH=$PATH:/mnt/tank/scratch/atomarovsky/tools/last-1179/bin

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/aligment/hic/lastal_aligment/; pwd;

$TOOLS/last-1179/bin/lastal -P 15 -R11 -f MAF -i 4G /mnt/tank/scratch/skliver/common/mustelidae/martes_foina/genome/index/lastal/martes_foina.YASS.R11.soft /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/annotation/hic1/repeats/mzib.min_150.pseudohap2.1_HiC.repeatmasker.trf.windowmasker.fasta.gz | tee martes_zibellina.to.martes_foina.R11.maf | maf-convert tab > martes_zibellina.to.martes_foina.R11.tab ;

echo 'finish!';
date;
