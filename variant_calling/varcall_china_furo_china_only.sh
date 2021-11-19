#!/bin/bash -l
#SBATCH --job-name=vcchinafuro
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=32
#SBATCH --mem=256gb
#SBATCH --time=150:00:00
#SBATCH --output=/mnt/tank/scratch/atomarovsky/vcchinafuro.log
#SBATCH --error=/mnt/tank/scratch/atomarovsky/vcchinafuro.err       

squeue; hostname; date;
export PATH=/mnt/tank/scratch/atomarovsky/tools/parallel-20210622/bin:/mnt/tank/scratch/atomarovsky/tools/bcftools-1.12/bin:${PATH}

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/variant_call/china_furo/china_only/; pwd;

mkdir -p split/ split//mpileup/ split//bcf/;

python3 $TOOLS/MAVR/scripts/sequence/prepare_region_list.py -r /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/assemblies/china/chr_assembly/furo_assembly/mzib_china_furo.fasta.fai -s -m 1500000 -n 100 -g samtools -x 1000 2>/dev/null | parallel -j 20 'bcftools mpileup -d 250 -q 30 -Q 30 --adjust-MQ 50 -a AD,INFO/AD,ADF,INFO/ADF,ADR,INFO/ADR,DP,SP,SCR,INFO/SCR -O u -f /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/assemblies/china/chr_assembly/furo_assembly/mzib_china_furo.fasta -r {} /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/aligment/china_furo/bwa_aligment/china/china.china_furo.bam | tee split//mpileup//tmp.{#}.mpileup.bcf | bcftools call -m -O u  -v -f GQ,GP > split//bcf//tmp.{#}.bcf' ;
bcftools concat -O u --threads 6 `ls split//bcf//tmp.*.bcf | sort -V` | bcftools view -O z -o china.vcf.gz - ;
bcftools concat -O u --threads 6 `ls split//mpileup//tmp.*.mpileup.bcf | sort -V` | bcftools view -O z -o china.mpileup.vcf.gz - ;

echo 'finish!';
date;
