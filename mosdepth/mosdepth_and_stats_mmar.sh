#!/bin/bash
#SBATCH --job-name=mmdepstat
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=5
#SBATCH --mem=20gb
#SBATCH --time=150:00:00
#SBATCH --output=/nfs/home/atomarovsky/mmdepstat.log
#SBATCH --error=/nfs/home/atomarovsky/mmdepstat.err 
squeue; hostname; date;
cd /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/aligment/hic/bwa_aligment/; pwd;
for i in 10x_mmar 10x_mzib S26 T24 T76 T77 T78 T79 T81 T82 T83 T84 T85 T86 T87; do
	cd $i;
	~/tools/mosdepth --threads 4 ${i}.hic ${i}.hic.bam;
	~/tools/Biocrutch/scripts/Coverage/coverage_statistics.py -i ${i}.hic.per-base.bed.gz -g -o ${i};
	~/tools/Biocrutch/scripts/Coverage/coverage_statistics.py -i ${i}.hic.per-base.bed.gz -s -o ${i};
	~/tools/Biocrutch/scripts/Coverage/coverage_statistics.py -i ${i}.hic.per-base.bed.gz -n -f 1000000 -o ${i};
	~/tools/Biocrutch/scripts/Coverage/coverage_statistics.py -i ${i}.hic.per-base.bed.gz -n -f 100000 -o ${i};
	~/tools/Biocrutch/scripts/Coverage/coverage_statistics.py -i ${i}.hic.per-base.bed.gz -n -f 10000 -o ${i};
	echo 'lol! ${i} stats is done';
	cd ..;
done
echo 'finish!';
date;
