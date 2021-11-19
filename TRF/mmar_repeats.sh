#!/bin/bash
#SBATCH --job-name=mmrep
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=8
#SBATCH --mem=25gb
#SBATCH --time=50:00:00
#SBATCH --output=/nfs/home/atomarovsky/mmrep.log
#SBATCH --error=/nfs/home/atomarovsky/mmrep.err       
squeue; hostname; date;

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/annotation/repeats/; pwd;

mkdir TRF
cd TRF/; pwd;
~/tools/TRF-4.09.1/build/src/trf ../mmar.min_150.pseudohap2.1_HiC.fasta 2 7 7 80 10 50 500 -d -h;
cd ..;

mkdir WindowMasker
cd WindowMasker/; pwd;
windowmasker -in ../mmar.min_150.pseudohap2.1_HiC.fasta -infmt fasta -mk_counts -parse_seqids -out mmar.min_150.pseudohap2.1_HiC.counts;
windowmasker -in ../mmar.min_150.pseudohap2.1_HiC.fasta -infmt fasta -ustat mmar.min_150.pseudohap2.1_HiC.counts -outfmt interval -parse_seqids -out mmar.min_150.pseudohap2.1_HiC.interval;
cd ..;

echo 'finish!';
date;
