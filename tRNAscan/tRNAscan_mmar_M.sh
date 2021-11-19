#!/bin/bash -i
#SBATCH --job-name=tRNAmarM
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=10
#SBATCH --mem=100gb
#SBATCH --time=150:00:00
#SBATCH --output=/nfs/home/atomarovsky/tRNAmarM.log
#SBATCH --error=/nfs/home/atomarovsky/tRNAmarM.err       
squeue; hostname; date;
conda activate mybase;
#mmar
~/miniconda3/envs/mybase/bin/tRNAscan-SE -M mammal ../../assemblies/hic/mmar.min_150.pseudohap2.1_HiC.fasta -o mmar.min_150.pseudohap2.1_HiC_M.out
echo 'lol! mmar.min_150.pseudohap2.1_HiC_M.out is done'
echo 'finish!';
date;
