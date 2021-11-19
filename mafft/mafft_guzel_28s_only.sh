#!/bin/bash
#SBATCH --job-name=mafft
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=14
#SBATCH --mem=80gb
#SBATCH --time=150:00:00
#SBATCH --output=/mnt/tank/scratch/atomarovsky/mafft_guzel_28s.log
#SBATCH --error=/mnt/tank/scratch/atomarovsky/mafft_guzel_28s.err       
squeue; hostname; date;
export TOOLS=/mnt/tank/scratch/atomarovsky/tools/ ;

cat /mnt/tank/scratch/atotikov/Mermin_18Chr.fasta /mnt/tank/scratch/atotikov/Mermin_5.8s.fasta /mnt/tank/scratch/atomarovsky/guzel/Mus_musculus_28S.fasta >> /mnt/tank/scratch/atomarovsky/guzel/Mermin_5.8s_28s.fasta ;

$TOOLS/mafft-7.487-with-extensions/bin/mafft --thread 8 /mnt/tank/scratch/atomarovsky/guzel/Mermin_5.8s_28s.fasta > /mnt/tank/scratch/atomarovsky/guzel/Mermin_5.8s_28s.aln

echo 'finish!';
date;
