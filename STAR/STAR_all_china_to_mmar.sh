#!/bin/bash
#SBATCH --job-name=chinastarmm
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=32
#SBATCH --mem=256gb
#SBATCH --time=150:00:00
#SBATCH --output=/nfs/home/atomarovsky/chinastarmm.log
#SBATCH --error=/nfs/home/atomarovsky/chinastarmm.err       
squeue; hostname; date;
export TOOLS=/mnt/tank/scratch/atomarovsky/tools/
cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina_china/genome/aligment/hic/STAR_aligment/mmar/; pwd;
filt='/mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina_china/transcriptome/filtered/'

for i in SRR8074161  SRR8074163  SRR8074165  SRR8074168  SRR8074169; do
	$TOOLS/STAR-2.7.8a/bin/Linux_x86_64/STAR --runThreadN 32 --genomeDir /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/assemblies/hic/index/STAR --readFilesCommand zcat --readFilesIn ${filt}${i}/${i}_1.filt.fastq.gz ${filt}${i}/${i}_2.filt.fastq.gz --outSAMtype BAM Unsorted --outFileNamePrefix /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina_china/genome/aligment/hic/mmar/${i}/ --twopassMode Basic ;

	cd ${i};
	samtools index Aligned.out.bam;
	samtools sort -@ 10 Aligned.out.bam -o ${i}.bam;
	samtools index ${i}.bam;
	cd ..;
done
echo 'finish!';
date;
