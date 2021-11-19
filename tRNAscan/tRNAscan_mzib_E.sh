#!/bin/bash -i
#SBATCH --job-name=tRNAzibE
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=10
#SBATCH --mem=100gb
#SBATCH --time=150:00:00
#SBATCH --output=/nfs/home/atomarovsky/tRNAzibE.log
#SBATCH --error=/nfs/home/atomarovsky/tRNAzibE.err       
squeue; hostname; date;
conda activate mybase;
#mzib
cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/annotation/hic1/tRNAscan/; pwd;
~/miniconda3/envs/mybase/bin/tRNAscan-SE -E ../../../assembles/hic1/mzib.min_150.pseudohap2.1_HiC.fasta -o mzib.min_150.pseudohap2.1_HiC_E.out;
echo 'lol! mzib.min_150.pseudohap2.1_HiC_E.out is done'
echo 'finish!';
date;
