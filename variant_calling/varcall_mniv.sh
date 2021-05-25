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
cd /mnt/tank/scratch/skliver/common/mustelidae/mustela_nivalis/genome/variant_call/Mustela_Nivalis_Ragoo/correct_ploidy_psChX/; pwd;
# mkdir -p split/ split//mpileup/ split//bcf/;

python3 $TOOLS/MAVR/scripts/sequence/prepare_region_list.py -w /mnt/tank/scratch/skliver/common/mustelidae/mustela_nivalis/genome/variant_call/Mustela_Nivalis_Ragoo/correct_ploidy_psChX/white_list.txt -r /mnt/tank/scratch/skliver/common/mustelidae/mustela_nivalis/genome/assemblies/Mustela_Nivalis_Ragoo/Mustela_Nivalis_ragoo.fasta.fai -s -m 1500000 -n 100 -g samtools -x 100 2>/dev/null | parallel -j 20 'bcftools mpileup -d 250 -q 30 -Q 30 --adjust-MQ 50 -a AD,INFO/AD,ADF,INFO/ADF,ADR,INFO/ADR,DP,SP,SCR,INFO/SCR -O u -f /mnt/tank/scratch/skliver/common/mustelidae/mustela_nivalis/genome/assemblies/Mustela_Nivalis_Ragoo/Mustela_Nivalis_ragoo.fasta -r {} /mnt/tank/scratch/skliver/common/mustelidae/mustela_nivalis/genome/alignment/Mustela_Nivalis_Ragoo/bwa_alignment/MNIV/MNIV.Mustela_Nivalis_ragoo_view.bam /mnt/tank/scratch/skliver/common/mustelidae/mustela_nivalis/genome/alignment/Mustela_Nivalis_Ragoo/bwa_alignment/T100/T100.Mustela_Nivalis_ragoo_view.bam /mnt/tank/scratch/skliver/common/mustelidae/mustela_nivalis/genome/alignment/Mustela_Nivalis_Ragoo/bwa_alignment/10X/10X.Mustela_Nivalis_ragoo_view.bam | tee split//mpileup//tmp.{#}.mpileup.bcf | bcftools call --ploidy-file /mnt/tank/scratch/skliver/common/mustelidae/mustela_nivalis/genome/variant_call/Mustela_Nivalis_Ragoo/correct_ploidy_psChX/ploidy_file.txt --samples-file /mnt/tank/scratch/skliver/common/mustelidae/mustela_nivalis/genome/variant_call/Mustela_Nivalis_Ragoo/correct_ploidy_psChX/samples_Ragoo.txt -m -O u -v -f GQ,GP > split//bcf//tmp.{#}.bcf'

bcftools concat -O u --threads 6 `ls split//bcf//tmp.*.bcf | sort -V` | bcftools view -O z -o Mustela_Nivalis_Ragoo.ploidy.vcf.gz - ;

bcftools concat -O u --threads 6 `ls split//mpileup//tmp.*.mpileup.bcf | sort -V` | bcftools view -O z -o Mustela_Nivalis_Ragoo.mpileup.ploidy.vcf.gz - ;

echo 'finish!';
date;
