#!/bin/bash -l
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=10
#SBATCH --mem=50gb
#SBATCH --time=120:00:00
#SBATCH --output=/nfs/home/atomarovsky/logs/barnfuro.log
#SBATCH --error=/nfs/home/atomarovsky/logs/barnfuro.err       
squeue; hostname; date;
conda activate mybase;
cd /mnt/tank/scratch/skliver/common/mustelidae/mustela_putorius_furo/genome/annotation/barrnap/; pwd;

barrnap -k euk -o GCA_000215625.1_MusPutFur1.0_genomic_rRNA_euk.fa < /mnt/tank/scratch/skliver/common/mustelidae/mustela_putorius_furo/genome/assemble/GCA_000215625.1_MusPutFur1.0_genomic.fna > GCA_000215625.1_MusPutFur1.0_genomic_rRNA_euk.gff;
echo 'mzib finish!';
date;
