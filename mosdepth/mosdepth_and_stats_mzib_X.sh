#!/bin/bash -l
#SBATCH --job-name=mzdepstat
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=5
#SBATCH --mem=20gb
#SBATCH --time=150:00:00
#SBATCH --output=/nfs/home/atomarovsky/mzdepstat.log
#SBATCH --error=/nfs/home/atomarovsky/mzdepstat.err 
squeue; hostname; date;
cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/aligment/hic1/bwa_aligment/; pwd;
for i in T83 T84 T86 T87; do
	cd $i;
	$TOOLS/Biocrutch/scripts/Coverage/coverage_statistics.py -i ${i}.hic1.per-base.bed.gz -n -f 10000 -o ${i};
	echo 'lol! ${i} stats is done';
	cd ..;
done
echo 'finish!';
date;
