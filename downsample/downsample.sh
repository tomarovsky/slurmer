#!/usr/bin/env bash
#SBATCH --time=150:00:00
#SBATCH --cpus-per-task=3
#SBATCH --mem=80000

#SBATCH --output=downsample3.log
#SBATCH --error=downsample3.err


mkdir S44  S46  S49  S50  T149  T151
reformat.sh in1=/mnt/archive/skliver/mustelidae/martes_martes/genome/resequencing/reads/filtered/S44/S44.final_1.fastq.gz in2=/mnt/archive/skliver/mustelidae/martes_martes/genome/resequencing/reads/filtered/S44/S44.final_2.fastq.gz out1=S44/S44.22x_1.fastq.gz out2=S44/S44.22x_2.fastq.gz samplerate=0.59

reformat.sh in1=/mnt/archive/skliver/mustelidae/martes_martes/genome/resequencing/reads/filtered/S46/S46.final_1.fastq.gz in2=/mnt/archive/skliver/mustelidae/martes_martes/genome/resequencing/reads/filtered/S46/S46.final_2.fastq.gz out1=S46/S46.22x_1.fastq.gz out2=S46/S46.22x_2.fastq.gz samplerate=0.53

reformat.sh in1=/mnt/archive/skliver/mustelidae/martes_martes/genome/resequencing/reads/filtered/S49/S49.final_1.fastq.gz in2=/mnt/archive/skliver/mustelidae/martes_martes/genome/resequencing/reads/filtered/S49/S49.final_2.fastq.gz out1=S49/S49.22x_1.fastq.gz out2=S49/S49.22x_2.fastq.gz samplerate=0.76

reformat.sh in1=/mnt/archive/skliver/mustelidae/martes_martes/genome/resequencing/reads/filtered/S50/S50.final_1.fastq.gz in2=/mnt/archive/skliver/mustelidae/martes_martes/genome/resequencing/reads/filtered/S50/S50.final_2.fastq.gz out1=S50/S50.22x_1.fastq.gz out2=S50/S50.22x_2.fastq.gz samplerate=0.9

reformat.sh in1=/mnt/archive/skliver/mustelidae/martes_martes/genome/resequencing/reads/filtered/T149/T149.final_1.fastq.gz in2=/mnt/archive/skliver/mustelidae/martes_martes/genome/resequencing/reads/filtered/T149/T149.final_2.fastq.gz out1=T149/T149.22x_1.fastq.gz out2=T149/T149.22x_2.fastq.gz samplerate=0.63

reformat.sh in1=/mnt/archive/skliver/mustelidae/martes_martes/genome/resequencing/reads/filtered/T151/T151.final_1.fastq.gz in2=/mnt/archive/skliver/mustelidae/martes_martes/genome/resequencing/reads/filtered/T151/T151.final_2.fastq.gz out1=T151/T151.22x_1.fastq.gz out2=T151/T151.22x_2.fastq.gz samplerate=0.59




