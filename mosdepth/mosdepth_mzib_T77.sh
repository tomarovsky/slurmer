#!/bin/bash
#SBATCH --job-name=mzstatT77
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=2
#SBATCH --mem=20gb
#SBATCH --time=50:00:00
squeue; hostname; date;
cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/aligment/hic1/bwa_aligment/; pwd;
for i in  T77; do
	cd $i;
	$TOOLS/Biocrutch/scripts/Coverage/coverage_statistics.py -i ${i}.hic1.per-base.bed.gz -n -f 10000 -o ${i};
	echo "lol! ${i} stats is done";
	cd ..;
done
echo 'finish!';
date;
