#!/bin/bash -i
#SBATCH --job-name=tRNAmarE
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=10
#SBATCH --mem=100gb
#SBATCH --time=150:00:00
#SBATCH --output=/nfs/home/atomarovsky/tRNAmarE.log
#SBATCH --error=/nfs/home/atomarovsky/tRNAmarE.err       
squeue; hostname; date;
conda activate mybase;
#mmar
cd /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/annotation/tRNAscan/; pwd;
~/miniconda3/envs/mybase/bin/tRNAscan-SE -E ../../assemblies/hic/mmar.min_150.pseudohap2.1_HiC.fasta -o mmar.min_150.pseudohap2.1_HiC_E.out
echo 'lol! mmar.min_150.pseudohap2.1_HiC_E.out is done'
echo 'finish!';
date;
