#!/bin/bash
#SBATCH --job-name=lastalmc
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=15
#SBATCH --mem=256gb
#SBATCH --time=150:00:00
#SBATCH --output=/mnt/tank/scratch/atomarovsky/lastalmc.log
#SBATCH --error=/mnt/tank/scratch/atomarovsky/lastalmc.err       
squeue; hostname; date;
export TOOLS=/mnt/tank/scratch/atomarovsky/tools/
export PATH=$PATH:/mnt/tank/scratch/atomarovsky/tools/last-1179/bin

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/aligment/hic/lastal_aligment/; pwd;

$TOOLS/last-1179/bin/lastal -P 15 -R11 -f MAF -i 4G /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/assemblies/hic/index/last_index/mmar.min_150.pseudohap2.1_HiC.YASS.R11.soft /mnt/tank/scratch/skliver/masked_genomes/felis_catus.fasta.gz | tee felis_catus.to.martes_martes.R11.maf | maf-convert tab > felis_catus.to.martes_martes.R11.tab ;
# $TOOLS/last-1179/bin/lastal -P 15 -R11 -f MAF -i 4G /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/assemblies/hic/index/last_index/mmar.min_150.pseudohap2.1_HiC.YASS.R11.soft /mnt/tank/scratch/skliver/masked_genomes/canis_familiaris.fasta.gz | tee canis_familiaris.to.martes_martes.R11.maf | maf-convert tab > canis_familiaris.to.martes_martes.R11.tab ;
# $TOOLS/last-1179/bin/lastal -P 15 -R11 -f MAF -i 4G /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/assemblies/hic/index/last_index/mmar.min_150.pseudohap2.1_HiC.YASS.R11.soft /mnt/tank/scratch/skliver/masked_genomes/martes_flavigula.fasta.gz | tee martes_flavigula.to.martes_martes.R11.maf | maf-convert tab > martes_flavigula.to.martes_martes.R11.tab ;
# $TOOLS/last-1179/bin/lastal -P 15 -R11 -f MAF -i 4G /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/assemblies/hic/index/last_index/mmar.min_150.pseudohap2.1_HiC.YASS.R11.soft /mnt/tank/scratch/skliver/masked_genomes/homo_sapiens.fasta.gz | tee homo_sapiens.to.martes_martes.R11.maf | maf-convert tab > homo_sapiens.to.martes_martes.R11.tab ;

echo 'finish!';
date;
