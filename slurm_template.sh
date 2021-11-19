#!/bin/bash
#SBATCH --job-name=TEST
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=32
#SBATCH --mem=256gb
#SBATCH --time=150:00:00
#SBATCH --output=/nfs/home/atomarovsky/TEST.log
#SBATCH --error=/nfs/home/atomarovsky/TEST.err       
squeue; hostname; date;
export TOOLS=/mnt/tank/scratch/atomarovsky/tools/



echo 'finish!';
date;
