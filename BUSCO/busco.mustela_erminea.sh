#!/bin/bash -l
#SBATCH --job-name=mustela_erminea
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=16
#SBATCH --mem=128gb
#SBATCH --time=150:00:00
#SBATCH --output=/mnt/tank/scratch/atomarovsky/logs/busco.mustela_erminea.log
#SBATCH --error=/mnt/tank/scratch/atomarovsky/logs/busco.mustela_erminea.err
squeue; hostname; date;
export PATH=/mnt/tank/scratch/atomarovsky/tools/augustus-3.2.1/bin:/mnt/tank/scratch/atomarovsky/tools/augustus-3.2.1/scripts:$PATH;
export AUGUSTUS_CONFIG_PATH=/mnt/tank/scratch/atomarovsky/tools/augustus-3.2.1/config/;

OUTDIR=/mnt/tank/scratch/atomarovsky/BuscoPhylo/results/busco/
SP=mustela_erminea
FASTA=/mnt/tank/scratch/atomarovsky/BuscoPhylo/genomes/$SP.fasta

cd $OUTDIR; pwd;
mkdir $SP; cd $SP;
python3 /mnt/tank/scratch/atomarovsky/tools/busco/scripts/run_BUSCO.py -i $FASTA -c 16 -o $SP -l /mnt/tank/scratch/atomarovsky/tools/busco/datasets/mammalia_odb9/ -m genome -sp human

echo 'the end';
date;
