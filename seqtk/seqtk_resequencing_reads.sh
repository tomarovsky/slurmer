#!/bin/bash
#SBATCH --job-name=subsampres           # Job name
#SBATCH --mail-type=END            # Mail events
#SBATCH --mail-user=andrey.tomarovsky@gmail.com        # Where to send mail
#SBATCH --cpus-per-task=10            # Number of CPU cores per task (max 32)
#SBATCH --mem=50gb              # Job memory request (max 256gb)
#SBATCH --time=150:00:00            # Time limit hrs:min:sec
#SBATCH --output=/nfs/home/atomarovsky/subsampres.log
#SBATCH --error=/nfs/home/atomarovsky/subsampres.err
hostname; date

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/resequencing/kidas/filtered_fastq/; pwd;

for i in T24  T76  T77  T78  T79  T81  T82  T83  T84  T85  T86  T87; do
	echo ${i};
	cd ${i};
	mkdir subsampling;
	cd subsampling/;
	$TOOLS/seqtk/seqtk sample -s100 ../${i}.final_1.fastq.gz 15000000 > ${i}.subsampling_1_15kk.fastq;
	$TOOLS/seqtk/seqtk sample -s100 ../${i}.final_2.fastq.gz 15000000 > ${i}.subsampling_2_15kk.fastq;
	gzip *.fastq;
	echo 'done';
	cd ../../;
done


cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/resequencing/sable/reads/filtered_fastq/S26/; pwd;

mkdir subsampling;
cd subsampling;
$TOOLS/seqtk/seqtk sample -s100 ../S26.final_1.fastq.gz 15000000 > S26.subsampling_1_15kk.fastq;
$TOOLS/seqtk/seqtk sample -s100 ../S26.final_2.fastq.gz 15000000 > S26.subsampling_2_15kk.fastq;
gzip *.fastq;
echo 'done'; date;
