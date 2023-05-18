#!/bin/bash -l
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=32
#SBATCH --mem=256gb
#SBATCH --time=300:00:00
#SBATCH --output=/mnt/tank/scratch/atomarovsky/purged.alignments/mzib.varcall.log
#SBATCH --error=/mnt/tank/scratch/atomarovsky/purged.alignments/mzib.varcall.err
squeue; hostname; date;

export PATH=/mnt/tank/scratch/atomarovsky/tools/samtools-1.15.1/bin:/mnt/tank/scratch/atomarovsky/tools/bcftools-1.15.1/bin:/mnt/tank/scratch/atomarovsky/tools/parallel-20220522/bin:${PATH}

TOOLS="/mnt/tank/scratch/atomarovsky/tools/"
ASSEMBLY="/mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/assemblies/hic.purged/mzib.min_150.pseudohap2.1_HiC.purged.fasta"
ALIGNMENTS="/mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/alignment/hic.purged/bwa_alignment/"
PLOIDY_FILE="/mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/varcall/hic.purged/bcftools/ploidy.file"
SAMPLES_FILE="/mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/varcall/hic.purged/bcftools/samples.file"

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/varcall/hic.purged/bcftools/; pwd;

mkdir -p split/ split//mpileup/ split//bcf/;

python3 ${TOOLS}/MAVR/scripts/sequence/prepare_region_list.py -r ${ASSEMBLY} -s -m 1500000 -n 100 -g samtools -x 1000 2>/dev/null |  parallel -j 10 "bcftools mpileup -d 250 -q 30 -Q 30 --adjust-MQ 50 -a AD,INFO/AD,ADF,INFO/ADF,ADR,INFO/ADR,DP,SP,SCR,INFO/SCR -O u -f ${ASSEMBLY} -r {} `find ${ALIGNMENTS} -name *.mzib.hic.purged.mkdup.bam -type f | tr "\n" " "` | tee split//mpileup//tmp.{#}.mpileup.bcf | bcftools call --ploidy-file ${PLOIDY_FILE} --samples-file ${SAMPLES_FILE} --group-samples - -m -O u -v -f GQ,GP > split//bcf//tmp.{#}.bcf" ;

bcftools concat -O u --threads 6 `ls split//bcf//tmp.*.bcf | sort -V` | bcftools view -O z -o mzib.allsamples.vcf.gz - ;
bcftools concat -O u --threads 6 `ls split//mpileup//tmp.*.mpileup.bcf | sort -V` | bcftools view -O z -o mzib.allsamples.mpileup.vcf.gz - ;

echo 'finish!';
date;


