#!/bin/bash
#SBATCH --job-name=mmar10Xs           # Job name
#SBATCH --mail-type=END            # Mail events
#SBATCH --mail-user=andrey.tomarovsky@gmail.com        # Where to send mail
#SBATCH --cpus-per-task=10            # Number of CPU cores per task (max 32)
#SBATCH --mem=100gb              # Job memory request (max 256gb)
#SBATCH --time=150:00:00            # Time limit hrs:min:sec
#SBATCH --output=/nfs/home/atomarovsky/mmar10Xs.log
#SBATCH --error=/nfs/home/atomarovsky/mmar10Xs.err
hostname; date

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/reads/filtered/10x/subsampling/; pwd;

/mnt/tank/scratch/atomarovsky/tools/seqtk/seqtk sample -s100 ../10xmmar.final_1.fastq.gz  20000000 > 10xmmar.subsampling_1_20kk.fastq
gzip 10xmmar.subsampling_1_20kk.fastq
echo 'done'

/mnt/tank/scratch/atomarovsky/tools/seqtk/seqtk sample -s100 ../10xmmar.final_2.fastq.gz  20000000 > 10xmmar.subsampling_2_20kk.fastq
gzip 10xmmar.subsampling_2_20kk.fastq
echo 'done'
date;
