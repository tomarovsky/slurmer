#!/bin/bash
#SBATCH --job-name=mzdepstatchina
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=5
#SBATCH --mem=20gb
#SBATCH --time=150:00:00
#SBATCH --output=/mnt/tank/scratch/atomarovsky/mzdepstatchina.log
#SBATCH --error=/mnt/tank/scratch/atomarovsky/mzdepstatchina.err 
squeue; hostname; date;
cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/aligment/hic/bwa_aligment/; pwd;
for i in china; do
	cd $i;
#	$TOOLS/mosdepth --threads 4 ${i}.hic ${i}.hic.bam;
#	$TOOLS/Biocrutch/scripts/Coverage/coverage_statistics.py -i ${i}.hic.per-base.bed.gz -n -f 1000000 -o ${i};
	$TOOLS/Biocrutch/scripts/Coverage/coverage_statistics.py -i ${i}.hic.per-base.bed.gz -g -o ${i};
	echo 'lol! ${i} stats is done';
	cd ..;
done
echo 'finish!';
date;
