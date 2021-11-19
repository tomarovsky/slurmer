#!/bin/bash -l
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=10
#SBATCH --mem=100gb
#SBATCH --time=150:00:00
#SBATCH --output=/nfs/home/atomarovsky/tRNAchinM.log
#SBATCH --error=/nfs/home/atomarovsky/tRNAchinM.err       
squeue; hostname; date;
conda activate mybase;
#mmar
cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina_china/genome/annotation/tRNAscan/; pwd;
/mnt/tank/scratch/atomarovsky/miniconda3/envs/mybase/bin/tRNAscan-SE -M mammal /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina_china/genome/assemblie/GCA_012583365.1_ASM1258336v1_genomic.fna -o GCA_012583365.1_ASM1258336v1_genomic_M.out
echo 'lol! mmar.min_150.pseudohap2.1_HiC_E.out is done'
echo 'finish!';
date;
