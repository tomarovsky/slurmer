#!/bin/bash
#SBATCH --job-name=mafft
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=8
#SBATCH --mem=56gb
#SBATCH --time=150:00:00
#SBATCH --output=/mnt/tank/scratch/atomarovsky/mafft_guzel.log
#SBATCH --error=/mnt/tank/scratch/atomarovsky/mafft_guzel.err       
squeue; hostname; date;
export TOOLS=/mnt/tank/scratch/atomarovsky/tools/ ;

cat /mnt/tank/scratch/atotikov/Mermin_18Chr.fasta /mnt/tank/scratch/atotikov/Mermin_18s.fasta /mnt/tank/scratch/atotikov/Mermin_5.8s.fasta >> /mnt/tank/scratch/atomarovsky/guzel/Mermin_common.fasta ;

$TOOLS/mafft-7.487-with-extensions/bin/mafft --thread 8 /mnt/tank/scratch/atomarovsky/guzel/Mermin_common.fasta > /mnt/tank/scratch/atomarovsky/guzel/Mermin_common.aln

echo 'finish!';
date;
