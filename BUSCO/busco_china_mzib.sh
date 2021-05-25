#!/bin/bash -i
#SBATCH --job-name=mzcbus
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=16
#SBATCH --mem=100gb
#SBATCH --time=150:00:00
#SBATCH --output=/nfs/home/atomarovsky/mzcbus.log
#SBATCH --error=/nfs/home/atomarovsky/mzcbus.err       
squeue; hostname; date;
conda activate busco5;
cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina_china/genome/; pwd;

busco -i GCA_012583365.1_ASM1258336v1_genomic.fna -c 15 -o GCA_012583365.1_ASM1258336v1_genomic.busco -l /mnt/tank/scratch/atomarovsky/tools/busco/datasets/mammalia_odb10/ -m genome

echo 'finish!';
date;
