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
for i in T24 T77 T81 T83 T84 T86 T87; do
	cd $i;
	$TOOLS/Biocrutch/scripts/Coverage/coverage_statistics.py -i ${i}.hic.per-base.bed.gz -n -f 5000 -o ${i};
	echo 'lol! ${i} stats is done';
	cd ..;
done
echo 'finish!';
date;
