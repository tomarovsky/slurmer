#!/bin/bash -l
#SBATCH --job-name=sorarabus
#SBATCH --mail-type=END
#SBATCH --cpus-per-task=16
#SBATCH --mem=128gb
#SBATCH --time=150:00:00
#SBATCH --output=/mnt/tank/scratch/atomarovsky/logs/galemys_pyrenaicus.log
#SBATCH --error=/mnt/tank/scratch/atomarovsky/logs/galemys_pyrenaicus.err
squeue; hostname; date;
export PATH=/mnt/tank/scratch/atomarovsky/tools/augustus-3.2.1/bin:/mnt/tank/scratch/atomarovsky/tools/augustus-3.2.1/scripts:$PATH;
export AUGUSTUS_CONFIG_PATH=/mnt/tank/scratch/atomarovsky/tools/augustus-3.2.1/config/;

OUTDIR=/mnt/tank/scratch/atomarovsky/BUSCOs/insectivora/ragtag.raw/
#SP=condylura_cristata
#SP=erinaceus_europaeus
SP=galemys_pyrenaicus
#SP=scalopus_aquaticus
#SP=solenodon_paradoxus
#SP=sorex_araneus
#SP=uropsilus_gracilis
FASTA=/mnt/tank/scratch/skliver/insectivora/$SP/genome/denovo/assemblies/ragtag/raw.fasta

cd $OUTDIR; pwd;
mkdir $SP; cd $SP;
python3 /mnt/tank/scratch/atomarovsky/tools/busco/scripts/run_BUSCO.py -i $FASTA -c 16 -o $SP -l /mnt/tank/scratch/atomarovsky/tools/busco/datasets/mammalia_odb9/ -m genome -sp human

echo 'the end';
date;
