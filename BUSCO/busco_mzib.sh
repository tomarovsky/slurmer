#!/bin/bash -i
#SBATCH --job-name=mzbus
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=16
#SBATCH --mem=100gb
#SBATCH --time=150:00:00
#SBATCH --output=/nfs/home/atomarovsky/mzbus.log
#SBATCH --error=/nfs/home/atomarovsky/mzbus.err       
squeue; hostname; date;
conda activate busco3;
export PATH="/mnt/tank/scratch/atomarovsky/miniconda3/envs/busco5/bin/:$PATH";
export PATH="/mnt/tank/scratch/atomarovsky/miniconda3/envs/busco5/bin/:$PATH";
export AUGUSTUS_CONFIG_PATH="/mnt/tank/scratch/atomarovsky/miniconda3/envs/busco5/config/";
cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/annotation/hic1/busco/; pwd;

/mnt/tank/scratch/atomarovsky/miniconda3/envs/busco3/bin/run_BUSCO.py -i mzib.min_150.pseudohap2.1_HiC.fasta -c 15 -o mzib.min_150.pseudohap2.1_HiC.busco -l /mnt/tank/scratch/atomarovsky/tools/busco/datasets/mammalia_odb9/ -m genome

echo 'finish!';
date;
