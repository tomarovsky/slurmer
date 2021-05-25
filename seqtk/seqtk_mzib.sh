#!/bin/bash
#SBATCH --job-name=mzib10Xs           # Job name
#SBATCH --mail-type=END            # Mail events
#SBATCH --mail-user=andrey.tomarovsky@gmail.com        # Where to send mail
#SBATCH --cpus-per-task=10            # Number of CPU cores per task (max 32)
#SBATCH --mem=100gb              # Job memory request (max 256gb)
#SBATCH --time=150:00:00            # Time limit hrs:min:sec
#SBATCH --output=/nfs/home/atomarovsky/mzib10Xs.log
#SBATCH --error=/nfs/home/atomarovsky/mzib10Xs.err
hostname; date

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/reads/filtered/subsampling/; pwd;

/mnt/tank/scratch/atomarovsky/tools/seqtk/seqtk sample -s100 ../mzib_ema.final_1.fastq.gz 20000000 > mzib_ema.subsampling_1_20kk.fastq
gzip mzib_ema.subsampling_1_20kk.fastq
echo 'done'

/mnt/tank/scratch/atomarovsky/tools/seqtk/seqtk sample -s100 ../mzib_ema.final_2.fastq.gz 20000000 > mzib_ema.subsampling_2_20kk.fastq
gzip mzib_ema.subsampling_2_20kk.fastq
echo 'done'
date;
