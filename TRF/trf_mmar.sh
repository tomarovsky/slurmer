#!/bin/bash
#SBATCH --job-name=mmtrf
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=4
#SBATCH --mem=25gb
#SBATCH --time=48:00:00
#SBATCH --output=/nfs/home/atomarovsky/mmtrf.log
#SBATCH --error=/nfs/home/atomarovsky/mmtrf.err       
squeue; hostname; date;

export TOOLS=/mnt/tank/scratch/atomarovsky/tools/

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/annotation/repeats/; pwd;
$TOOLS/TRF-4.09.1/trf mmar.min_150.pseudohap2.1_HiC.fasta 2 7 7 80 10 50 500 -d -h;

mkdir TRF/;
mv *.dat TRF/;

echo 'finish!';
date;
