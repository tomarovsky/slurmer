#!/bin/bash
#SBATCH --job-name=furochina
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=32
#SBATCH --mem=256gb
#SBATCH --time=150:00:00
#SBATCH --output=/mnt/tank/scratch/atomarovsky/furochina.log
#SBATCH --error=/mnt/tank/scratch/atomarovsky/furochina.err       
squeue;
hostname; date;

bwadir="/mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/aligment/china_furo/bwa_aligment/"
fasta="/mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/assemblies/china/chr_assembly/furo_assembly/index/bwa_index/mzib_china_furo.fasta"
sampledir="/mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/reads/filtered/china/"
sample="m_zibellina"

cd $bwadir; pwd;

mkdir china;
cd china;


bwa mem -t 10 ${fasta} ${sampledir}/${sample}_1.fq.gz ${sampledir}/${sample}_2.fq.gz -R '@RG\tID:china\tPU:x\tSM:china\tPL:Illumina\tLB:x' | samtools fixmate -@ 6 -m - - | samtools sort -@ 10 -m 12G | samtools markdup -@ 6 - china.china_furo.aln.bam ;

samtools index china.china_furo.aln.bam;

samtools view -b -@ 10 -q 20 -F 1024 -o china.china_furo.bam china.china_furo.aln.bam;

samtools index china.china_furo.bam;

echo 'finish!'
date
