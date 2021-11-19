#!/bin/bash -l
#SBATCH --job-name=vcallmmar
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=32
#SBATCH --mem=256gb
#SBATCH --time=150:00:00
#SBATCH --output=/mnt/tank/scratch/atomarovsky/vcallmmar.log
#SBATCH --error=/mnt/tank/scratch/atomarovsky/vcallmmar.err       

squeue; hostname; date;
# conda activate varcall;
export PATH=/mnt/tank/scratch/atomarovsky/tools/parallel-20210622/bin:/mnt/tank/scratch/atomarovsky/tools/bcftools-1.12/bin:${PATH}

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/variant_call/hic/all_samples/; pwd;
mkdir -p split/ split//mpileup/ split//bcf/;

python3 $TOOLS/MAVR/scripts/sequence/prepare_region_list.py -r /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/assemblies/hic/mmar.min_150.pseudohap2.1_HiC.fasta.fai -s -m 1500000 -n 100 -g samtools -x 1000 2>/dev/null | parallel -j 20 'bcftools mpileup -d 250 -q 30 -Q 30 --adjust-MQ 50 -a AD,INFO/AD,ADF,INFO/ADF,ADR,INFO/ADR,DP,SP,SCR,INFO/SCR -O u -f /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/assemblies/hic/mmar.min_150.pseudohap2.1_HiC.fasta -r {} /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/aligment/hic/bwa_aligment/S26/S26.hic.bam /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/aligment/hic/bwa_aligment/T24/T24.hic.bam /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/aligment/hic/bwa_aligment/T76/T76.hic.bam /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/aligment/hic/bwa_aligment/T77/T77.hic.bam /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/aligment/hic/bwa_aligment/T78/T78.hic.bam /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/aligment/hic/bwa_aligment/T79/T79.hic.bam /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/aligment/hic/bwa_aligment/T81/T81.hic.bam /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/aligment/hic/bwa_aligment/T82/T82.hic.bam /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/aligment/hic/bwa_aligment/T83/T83.hic.bam /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/aligment/hic/bwa_aligment/T84/T84.hic.bam /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/aligment/hic/bwa_aligment/T85/T85.hic.bam /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/aligment/hic/bwa_aligment/T86/T86.hic.bam /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/aligment/hic/bwa_aligment/T87/T87.hic.bam /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/aligment/hic/bwa_aligment/10xmmar/10xmmar.hic.bam /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/aligment/hic/bwa_aligment/10xmzib/10xmzib.hic.bam  /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/aligment/hic/bwa_aligment/SRR13213810/SRR13213810.hic.bam /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/aligment/hic/bwa_aligment/SRR13213811/SRR13213811.hic.bam /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/aligment/hic/bwa_aligment/SRR13213812/SRR13213812.hic.bam /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/aligment/hic/bwa_aligment/china/china.hic.bam | tee split//mpileup//tmp.{#}.mpileup.bcf | bcftools call --ploidy-file /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/variant_call/hic/all_samples/ploidy.file --samples-file /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/variant_call/hic/all_samples/samples.file -m -O u  -v -f GQ,GP > split//bcf//tmp.{#}.bcf' ;

bcftools concat -O u --threads 6 `ls split//bcf//tmp.*.bcf | sort -V` | bcftools view -O z -o allsamples.vcf.gz - ;
bcftools concat -O u --threads 6 `ls split//mpileup//tmp.*.mpileup.bcf | sort -V` | bcftools view -O z -o allsamples.mpileup.vcf.gz - ;

echo 'finish!';
date;
