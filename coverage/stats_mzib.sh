#!/bin/bash
#SBATCH --job-name=mz10stat
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=2
#SBATCH --mem=15gb
#SBATCH --time=50:00:00
#SBATCH --output=/nfs/home/atomarovsky/mz10stat.log
#SBATCH --error=/nfs/home/atomarovsky/mz10stat.err

squeue; hostname; date;
cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/aligment/hic1/bwa_aligment/; pwd;
for i in 10x_mmar 10x_mzib; do
	cd $i;
	~/tools/Biocrutch/scripts/Coverage/coverage_statistics.py -i ${i}.hic1.per-base.bed.gz -g -o ${i};
	~/tools/Biocrutch/scripts/Coverage/coverage_statistics.py -i ${i}.hic1.per-base.bed.gz -s -o ${i};
	~/tools/Biocrutch/scripts/Coverage/coverage_statistics.py -i ${i}.hic1.per-base.bed.gz -n -f 1000000 -o ${i};
	~/tools/Biocrutch/scripts/Coverage/coverage_statistics.py -i ${i}.hic1.per-base.bed.gz -n -f 100000 -o ${i};
	~/tools/Biocrutch/scripts/Coverage/coverage_statistics.py -i ${i}.hic1.per-base.bed.gz -n -f 10000 -o ${i};
	echo 'lol! ${i} stats is done';
	cd ..;
done
echo 'finish!';
date;
