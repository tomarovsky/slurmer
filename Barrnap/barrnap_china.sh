#!/bin/bash -l
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=10
#SBATCH --mem=50gb
#SBATCH --time=12:00:00
#SBATCH --output=/nfs/home/atomarovsky/barnchin.log
#SBATCH --error=/nfs/home/atomarovsky/barnchin.err       
squeue; hostname; date;
conda activate mybase;
cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina_china/genome/annotation/barrnap/; pwd;
# barrnap -k mito -o GCA_012583365.1_ASM1258336v1_genomic_rRNA_mito.fa < /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina_china/genome/assemblie/GCA_012583365.1_ASM1258336v1_genomic.fna > GCA_012583365.1_ASM1258336v1_genomic_rRNA_mito.gff
# echo 'mzib finish!';

barrnap -k euk -o GCA_012583365.1_ASM1258336v1_genomic_rRNA_euk.fa < /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina_china/genome/assemblie/GCA_012583365.1_ASM1258336v1_genomic.fna > GCA_012583365.1_ASM1258336v1_genomic_rRNA_euk.gff;
echo 'mzib finish!';
date;
