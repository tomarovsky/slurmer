#!/bin/bash -i
#SBATCH --job-name=tRNAzibM
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=10
#SBATCH --mem=100gb
#SBATCH --time=150:00:00
#SBATCH --output=/nfs/home/atomarovsky/tRNAzibM.log
#SBATCH --error=/nfs/home/atomarovsky/tRNAzibM.err       
squeue; hostname; date;
conda activate mybase;
~/miniconda3/envs/mybase/bin/tRNAscan-SE -M mammal ../../../assembles/hic1/mzib.min_150.pseudohap2.1_HiC.fasta -o mzib.min_150.pseudohap2.1_HiC_M.out;
echo 'lol! mzib.min_150.pseudohap2.1_HiC_M.out is done'
echo 'finish!';
date;
