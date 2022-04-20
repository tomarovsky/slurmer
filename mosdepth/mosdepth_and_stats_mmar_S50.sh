#!/bin/bash
#SBATCH --job-name=mmS50
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=6
#SBATCH --mem=30gb
#SBATCH --time=150:00:00
#SBATCH --output=/mnt/tank/scratch/atomarovsky/logs/mmS50.log
#SBATCH --error=/mnt/tank/scratch/atomarovsky/logs/mmS50.err 
squeue; hostname; date;

sample="S50"

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/alignment/hic/bwa_aligment/${sample}/; pwd;
for i in ${sample}; do
	$TOOLS/mosdepth/mosdepth --threads 6 ${i}.hic ${i}.hic.bam;
	$TOOLS/Biocrutch/scripts/Coverage/coverage_statistics.py -i ${i}.hic.per-base.bed.gz -g -o ${i};
	$TOOLS/Biocrutch/scripts/Coverage/coverage_statistics.py -i ${i}.hic.per-base.bed.gz -s -o ${i};
	$TOOLS/Biocrutch/scripts/Coverage/coverage_statistics.py -i ${i}.hic.per-base.bed.gz -n -f 1000000 -o ${i};
	$TOOLS/Biocrutch/scripts/Coverage/coverage_statistics.py -i ${i}.hic.per-base.bed.gz -n -f 100000 -o ${i};
	echo '${i} stats is done';
done
echo 'finish!';
date;
