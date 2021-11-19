#!/bin/bash -i
#SBATCH --job-name=mitomm
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=10
#SBATCH --mem=256gb
#SBATCH --time=150:00:00
#SBATCH --output=/nfs/home/atomarovsky/mitomm.log
#SBATCH --error=/nfs/home/atomarovsky/mitomm.err       
squeue; hostname; date;
export TOOLS=/mnt/tank/scratch/atomarovsky/tools/
conda activate mitozEnv

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/annotation/mitoZ/; 

python3 $TOOLS/release_MitoZ_v2.3/MitoZ.py all2 --genetic_code 2 --clade Chordata --outprefix 10x_mmar --thread_number 10 --fastq1 /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/reads/filtered/10x/subsampling/10xmmar.subsampling_1_20kk.fastq.gz --fastq2 /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/reads/filtered/10x/subsampling/10xmmar.subsampling_2_20kk.fastq.gz  --fastq_read_length 150 --insert_size 350 --run_mode 2 --filter_taxa_method 1 --requiring_taxa 'Mammalia'

echo 'finish!';
date;
