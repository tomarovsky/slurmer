#!/bin/bash
#SBATCH --job-name=mafftaonyx
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=12
#SBATCH --mem=110gb
#SBATCH --time=150:00:00
#SBATCH --output=/mnt/tank/scratch/atomarovsky/logs/mafft_aonyx.log
#SBATCH --error=/mnt/tank/scratch/atomarovsky/logs/mafft_aonyx.err       
squeue; hostname; date;
export TOOLS=/mnt/tank/scratch/atomarovsky/tools/ ;

cat /mnt/tank/scratch/atotikov/GUZEL/Aonyx_cinerea/Aonyx_cinereus_HiC.fasta /mnt/tank/scratch/atotikov/GUZEL/Aonyx_cinerea/Aonyx_cinerea_ITS1_partial_5.8S_rRNA_ITS2_partial.fasta >> /mnt/tank/scratch/atomarovsky/guzel/Aonyx_cinerea_common.fasta ;

$TOOLS/mafft-7.487-with-extensions/bin/mafft --thread 12 /mnt/tank/scratch/atomarovsky/guzel/Aonyx_cinerea_common.fasta > /mnt/tank/scratch/atomarovsky/guzel/Aonyx_cinerea_common.aln

echo 'finish!';
date;
