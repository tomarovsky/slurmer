#!/bin/bash
#SBATCH --job-name=mmwm
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=8
#SBATCH --mem=40gb
#SBATCH --time=48:00:00
#SBATCH --output=/nfs/home/atomarovsky/mmwm.log
#SBATCH --error=/nfs/home/atomarovsky/mmwm.err       
squeue; hostname; date;

export TOOLS=/mnt/tank/scratch/atomarovsky/tools/

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/annotation/repeats/; pwd;
$TOOLS/windowmasker -in mmar.min_150.pseudohap2.1_HiC.fasta -infmt fasta -mk_counts -parse_seqids -out mmar.min_150.pseudohap2.1_HiC.counts;
$TOOLS/windowmasker -in mmar.min_150.pseudohap2.1_HiC.fasta -infmt fasta -ustat mmar.min_150.pseudohap2.1_HiC.counts -outfmt interval -parse_seqids -out mmar.min_150.pseudohap2.1_HiC.intervals;

mkdir WindowMasker/;
mv *.counts WindowMasker/;
mv *.intervals WindowMasker/;

echo 'finish!';
date;
