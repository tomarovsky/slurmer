#!/bin/bash
#SBATCH --job-name=maskmz
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=2
#SBATCH --mem=20gb
#SBATCH --time=150:00:00
#SBATCH --output=/nfs/home/atomarovsky/maskmz.log
#SBATCH --error=/nfs/home/atomarovsky/maskmz.err       
squeue; hostname; date;
export TOOLS=/mnt/tank/scratch/atomarovsky/tools/

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/aligment/hic1/bwa_aligment/; pwd;

for i in 10x_mmar  10x_mzib  S26  T24  T76  T77  T78  T79  T81  T82  T83  T84  T85  T86  T87; do cd $i; ~/bashare/coverage_masking.sh -i ${i}.hic1.per-base.bed.gz; cd ..; done

echo 'finish!';
date;
