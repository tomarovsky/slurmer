#!/bin/bash -l
#SBATCH --job-name=mmar.stirka.trim
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=32
#SBATCH --mem=256gb
#SBATCH --time=150:00:00
#SBATCH --output=/mnt/tank/scratch/atomarovsky/mmar.stirka.trim.log
#SBATCH --error=/mnt/tank/scratch/atomarovsky/mmar.stirka.trim.err       
squeue; hostname; date;
export TOOLS=/mnt/tank/scratch/atomarovsky/tools/

cd /mnt/tank/scratch/atomarovsky; pwd;

raw="/mnt/tank/scratch/atomarovsky/mmar_resequencing/raw/"
filtered="/mnt/tank/scratch/atomarovsky/mmar_resequencing/filtered/"


python3 $TOOLS/MAVR/scripts/filter/filter_stirka_trimmomatic.py -d ${raw} -x filtering.stats -o ${filtered} -t $SLURM_CPUS_PER_TASK -a $TOOLS/Trimmomatic-0.39/adapters/TruSeq2-PE.fa -k $TOOLS/service_seq/illumina_adapters_with_rev_com_23_mer.kmer -g 8 -j $TOOLS/Trimmomatic-0.39/ -r --stat_off -c $TOOLS/stirka/ -q 20 -l 50 -s S28,S29,S49,S50,T149,T151

echo 'finish!';
date;
