#!/bin/bash -l
#SBATCH --job-name=mmbus
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=16
#SBATCH --mem=100gb
#SBATCH --time=150:00:00
#SBATCH --output=/nfs/home/atomarovsky/mmbus.log
#SBATCH --error=/nfs/home/atomarovsky/mmbus.err       
squeue; hostname; date;
# conda activate busco3;
export PATH=/mnt/tank/scratch/atomarovsky/tools/augustus-3.2.1/bin:/mnt/tank/scratch/atomarovsky/tools/augustus-3.2.1/scripts:$PATH;
export AUGUSTUS_CONFIG_PATH=/mnt/tank/scratch/atomarovsky/tools/augustus-3.2.1/config/;

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/annotation/busco/; pwd;

/mnt/tank/scratch/atomarovsky/tools/busco/scripts/run_BUSCO.py -i mmar.min_150.pseudohap2.1_HiC.fasta -c 16 -o mmar.min_150.pseudohap2.1_HiC.busco -l /mnt/tank/scratch/atomarovsky/tools/busco/datasets/mammalia_odb9/ -m genome -sp human

echo 'finish!';
date;
