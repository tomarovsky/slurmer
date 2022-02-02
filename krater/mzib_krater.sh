#!/bin/bash -l
#SBATCH --job-name=krater.mzib
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=32
#SBATCH --mem=256gb
#SBATCH --time=150:00:00
#SBATCH --output=/mnt/tank/scratch/atomarovsky/krater.mzib.log
#SBATCH --error=/mnt/tank/scratch/atomarovsky/krater.mzib.err       
squeue; hostname; date;
export TOOLS=/mnt/tank/scratch/atomarovsky/tools/

conda activate jf

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/reads/resequencing/raw/;

for i in `ls */*`; do
	if [ -d "../../../kmer/resequencing/${i%%/*}" ]; then
		continue
	fi;
	mkdir ../../../kmer/resequencing/${i%%/*};
	python3 $TOOLS/KrATER/scripts/jf/draw_kmer_distribution_from_fastq.py -i ${i%%.*}.1.fastq.gz,${i%%.*}.2.fastq.gz -o ../../../kmer/resequencing/${i%%/*}/${i%%/*} -m 23 -s 40G -t 32 -b;
done

echo 'finish!';
date;
