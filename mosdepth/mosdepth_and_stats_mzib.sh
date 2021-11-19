#!/bin/bash
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
for i in S26 T24 T76 T77 T78 T79 T81 T82 T83 T84 T85 T86 T87; do
	cd $i;
	~/tools/mosdepth --threads 4 ${i}.hic1 ${i}.hic1.bam;
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
