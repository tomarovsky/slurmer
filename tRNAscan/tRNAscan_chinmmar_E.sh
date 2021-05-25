#!/bin/bash -i
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=10
#SBATCH --mem=100gb
#SBATCH --time=150:00:00
#SBATCH --output=/nfs/home/atomarovsky/tRNAchinE.log
#SBATCH --error=/nfs/home/atomarovsky/tRNAchinE.err       
squeue; hostname; date;
conda activate mybase;
#mmar
cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina_china/genome/annotation/tRNAscan/; pwd;
/mnt/tank/scratch/atomarovsky/miniconda3/envs/mybase/bin/tRNAscan-SE -E /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina_china/genome/assemblie/GCA_012583365.1_ASM1258336v1_genomic.fna -o GCA_012583365.1_ASM1258336v1_genomic_E.out
echo 'lol! mmar.min_150.pseudohap2.1_HiC_E.out is done'
echo 'finish!';
date;
