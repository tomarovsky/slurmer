#!/bin/bash -l
#SBATCH --job-name=augumz
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=32
#SBATCH --mem=256gb
#SBATCH --time=150:00:00
#SBATCH --output=/nfs/home/atomarovsky/augumzr.log
#SBATCH --error=/nfs/home/atomarovsky/augumzr.err       
squeue; hostname; date;
conda activate cufflinks;
export TOOLS=/mnt/tank/scratch/atomarovsky/tools/;
export PATH=${PATH}:/mnt/tank/scratch/skliver/soft/augustus-3.2.1/bin:/mnt/tank/scratch/skliver/soft/augustus-3.2.1/scripts;
pfam="/mnt/tank/scratch/skliver/db/pfam/pfam_33.1/Pfam-A.hmm"
swisprot="/mnt/tank/scratch/skliver/db/swissprot/swissprot"
softmasked_fasta="/mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/annotation/hic1/gene_annotation/masked_fasta/mzib.min_150.pseudohap2.1_HiC.repeatmasker.fasta"
augustus_config_dir="/mnt/tank/scratch/skliver/soft/augustus-3.2.1/config"
extrinsicCfgFile="/mnt/tank/scratch/skliver/soft/augustus-3.2.1/config/extrinsic/extrinsic.RM.EXNT.EXNS.RNASEQ.cfg"
hints_gff="/mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/annotation/hic1/gene_annotation/all_hints/RNAseq_hints.gff"
cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/annotation/hic1/gene_annotation/augustus_only_rnaseq_output/; pwd;

python3 $TOOLS/MAVR/scripts/annotation/parallel_augustus.py -i ${softmasked_fasta} -o mzib -t 30 -x mzib -s human -c ${augustus_config_dir} -p ${pfam} -w ${swisprot} --softmasking --extrinsicCfgFile ${extrinsicCfgFile} --hintsfile ${hints_gff}

echo 'finish!';
date;
