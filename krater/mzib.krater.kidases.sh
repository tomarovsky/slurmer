#!/bin/bash -l
#SBATCH --job-name=krater.mzkidases
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=32
#SBATCH --mem=256gb
#SBATCH --time=150:00:00
#SBATCH --output=/mnt/tank/scratch/atomarovsky/logs/krater.mzmzkidases.log
#SBATCH --error=/mnt/tank/scratch/atomarovsky/logs/krater.mzkidases.err
squeue; hostname; date;
export TOOLS=/mnt/tank/scratch/atomarovsky/tools/

conda activate jf

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/resequencing/kidas/;

for i in `ls */*`; do
	if [ -d "../../kmer/kidases/${i%%/*}" ]; then
		continue
	fi;
	mkdir ../../kmer/kidases/${i%%/*};
	python3 $TOOLS/KrATER/scripts/jf/draw_kmer_distribution_from_fastq.py -i ${i%%.*}.final_1.fastq.gz,${i%%.*}.final_2.fastq.gz -o ../../kmer/kidases/${i%%/*}/${i%%/*} -m 23 -s 40G -t 32 -b;
	rm ../../kmer/kidases/${i%%/*}/*.jf;
done

echo 'finish!';
date;
