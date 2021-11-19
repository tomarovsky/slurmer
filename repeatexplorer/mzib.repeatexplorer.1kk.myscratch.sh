#!/bin/bash -l
#SBATCH --job-name=mzib.RE
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=32
#SBATCH --mem=256gb
#SBATCH --time=150:00:00
#SBATCH --output=/mnt/tank/scratch/atomarovsky/mzib_repeatexplorer/mzibRE1.log
#SBATCH --error=/mnt/tank/scratch/atomarovsky/mzib_repeatexplorer/mzibRE1.err

squeue; hostname; date;
conda activate repeatexplorer;
export PATH=/mnt/tank/scratch/atomarovsky/tools/repex_tarean/bin:${PATH}

cd /mnt/tank/scratch/atomarovsky/tools/repex_tarean/ ; pwd;

./seqclust -p -v /mnt/tank/scratch/atomarovsky/mzib_repeatexplorer/ /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/annotation/hic/repeats/RepeatExplorer/both.mzib_ema.subsampling_1kk.renamed.interleaved.fasta

echo 'finish!';
date;
