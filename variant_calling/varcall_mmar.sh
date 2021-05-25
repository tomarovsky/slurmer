#!/bin/bash -i
#SBATCH --job-name=vcmmar
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=32
#SBATCH --mem=256gb
#SBATCH --time=150:00:00
#SBATCH --output=/nfs/home/atomarovsky/vcmmar.log
#SBATCH --error=/nfs/home/atomarovsky/vcmmar.err       
squeue; hostname; date;
export TOOLS=/mnt/tank/scratch/atomarovsky/tools/;
conda activate varcall;
cd /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/variant_call/hic/SNPcall_all/; pwd;

mkdir -p split/ split//mpileup/ split//bcf/;

python3 $TOOLS/MAVR/scripts/sequence/prepare_region_list.py -r ../../../assemblies/hic/mmar.min_150.pseudohap2.1_HiC.fasta -s -m 1500000 -n 100 -g samtools -x 1000 2>/dev/null |  parallel -j 10 'bcftools mpileup -d 250 -q 30 -Q 30 --adjust-MQ 50 -a AD,INFO/AD,ADF,INFO/ADF,ADR,INFO/ADR,DP,SP,SCR,INFO/SCR -O u -f ../../../assemblies/hic/mmar.min_150.pseudohap2.1_HiC.fasta -r {} ../../../aligment/hic/bwa_aligment/S26/S26.hic.bam ../../../aligment/hic/bwa_aligment/T24/T24.hic.bam ../../../aligment/hic/bwa_aligment/T76/T76.hic.bam ../../../aligment/hic/bwa_aligment/T77/T77.hic.bam ../../../aligment/hic/bwa_aligment/T78/T78.hic.bam ../../../aligment/hic/bwa_aligment/T79/T79.hic.bam ../../../aligment/hic/bwa_aligment/T81/T81.hic.bam ../../../aligment/hic/bwa_aligment/T82/T82.hic.bam ../../../aligment/hic/bwa_aligment/T83/T83.hic.bam ../../../aligment/hic/bwa_aligment/T84/T84.hic.bam ../../../aligment/hic/bwa_aligment/T85/T85.hic.bam ../../../aligment/hic/bwa_aligment/T86/T86.hic.bam ../../../aligment/hic/bwa_aligment/T87/T87.hic.bam ../../../aligment/hic/bwa_aligment/10x_mmar/10x_mmar.hic.bam ../../../aligment/hic/bwa_aligment/10x_mzib/10x_mzib.hic.bam | tee split//mpileup//tmp.{#}.mpileup.bcf | bcftools call --ploidy-file ploidy.file --samples-file samples.file -m  -O u  -v -f GQ,GP > split//bcf//tmp.{#}.bcf' ;
bcftools concat -O u --threads 6 `ls split//bcf//tmp.*.bcf | sort -V` | bcftools view -O z -o mmar_allsamples.vcf.gz - ;
bcftools concat -O u --threads 6 `ls split//mpileup//tmp.*.mpileup.bcf | sort -V` | bcftools view -O z -o mmar_allsamples.mpileup.vcf.gz - ;

echo 'finish!';
date;
