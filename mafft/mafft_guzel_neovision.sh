#!/bin/bash
#SBATCH --job-name=mafft
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=12
#SBATCH --mem=110gb
#SBATCH --time=150:00:00
#SBATCH --output=/mnt/tank/scratch/atomarovsky/mafft_guzel.log
#SBATCH --error=/mnt/tank/scratch/atomarovsky/mafft_guzel.err       
squeue; hostname; date;
export TOOLS=/mnt/tank/scratch/atomarovsky/tools/ ;

cat /mnt/tank/scratch/atotikov/GUZEL/Neovison_vison/Neovison_vison_GCA_900108605.1.fna /mnt/tank/scratch/atotikov/GUZEL/Neovison_vison/Neovison_vison_18s_rRNA.fasta  /mnt/tank/scratch/atotikov/GUZEL/Neovison_vison/Neovison_vison_FNWR01000024.1_5.8s_rRNA.fasta  /mnt/tank/scratch/atotikov/GUZEL/Neovison_vison/Neovison_vison_FNWR01000491.1_28s_rRNA_partial.fasta  >> /mnt/tank/scratch/atomarovsky/guzel/Neovison_vison_common.fasta ;

$TOOLS/mafft-7.487-with-extensions/bin/mafft --thread 12 /mnt/tank/scratch/atomarovsky/guzel/Neovison_vison_common.fasta > /mnt/tank/scratch/atomarovsky/guzel/Neovison_vison_common.aln

echo 'finish!';
date;
