#!/bin/bash -i
#SBATCH --job-name=mitomz
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=10
#SBATCH --mem=256gb
#SBATCH --time=150:00:00
#SBATCH --output=/nfs/home/atomarovsky/mitomz.log
#SBATCH --error=/nfs/home/atomarovsky/mitomz.err       
squeue; hostname; date;
export TOOLS=/mnt/tank/scratch/atomarovsky/tools/
conda activate mitozEnv

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/annotation/hic1/mitoZ/; 

python3 $TOOLS/release_MitoZ_v2.3/MitoZ.py all2 --genetic_code 2 --clade Chordata --outprefix 10x_mzib --thread_number 10 --fastq1 /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/reads/filtered/subsampling/mzib_ema.subsampling_1_20kk.fastq.gz  --fastq2 /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/reads/filtered/subsampling/mzib_ema.subsampling_2_20kk.fastq.gz  --fastq_read_length 150 --insert_size 350 --run_mode 2 --filter_taxa_method 1 --requiring_taxa 'Mammalia'

echo 'finish!';
date;
