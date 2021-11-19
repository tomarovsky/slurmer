#!/bin/bash
#SBATCH --job-name=mmdeptrans
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=5
#SBATCH --mem=20gb
#SBATCH --time=150:00:00
#SBATCH --output=/nfs/home/atomarovsky/mmdeptrans.log
#SBATCH --error=/nfs/home/atomarovsky/mmdeptrans.err 
squeue; hostname; date;
export TOOLS=/mnt/tank/scratch/atomarovsky/tools/

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/aligment/hic/bwa_aligment/transcriptome/; pwd;
for i in 15-1b 23-1b; do
	cd $i;
	$TOOLS/mosdepth --threads 4 ${i}.hic1 ${i}.hic1.bam;
	$TOOLS/Biocrutch/scripts/Coverage/coverage_statistics.py -i ${i}.hic1.per-base.bed.gz -g -o ${i};
	$TOOLS/Biocrutch/scripts/Coverage/coverage_statistics.py -i ${i}.hic1.per-base.bed.gz -s -o ${i};
	$TOOLS/Biocrutch/scripts/Coverage/coverage_statistics.py -i ${i}.hic1.per-base.bed.gz -n -f 1000000 -o ${i};
	$TOOLS/Biocrutch/scripts/Coverage/coverage_statistics.py -i ${i}.hic1.per-base.bed.gz -n -f 100000 -o ${i};
	$TOOLS/Biocrutch/scripts/Coverage/coverage_statistics.py -i ${i}.hic1.per-base.bed.gz -n -f 10000 -o ${i};
	echo 'lol! ${i} stats is done';
	cd ..;
done
echo 'finish!';
date;
