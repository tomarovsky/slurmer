#!/bin/bash
#SBATCH --job-name=barnall
#SBATCH --mail-type=END
#SBATCH --mail-user=andrey.tomarovsky@gmail.com
#SBATCH --cpus-per-task=10
#SBATCH --mem=20gb
#SBATCH --time=12:00:00
#SBATCH --output=/nfs/home/atomarovsky/barnall.log
#SBATCH --error=/nfs/home/atomarovsky/barnall.err       
squeue; hostname; date;

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/annotation/hic1/barrnap/; pwd;
~/tools/barrnap-0.9/bin/barrnap -k mito -o mzib.min_150.pseudohap2.1_HiC_rRNA_mito.fa < /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/assembles/hic1/mzib.min_150.pseudohap2.1_HiC.fasta > mzib.min_150.pseudohap2.1_HiC_rRNA_mito.gff
echo 'mzib finish!';

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/annotation/barrnap/; pwd;
~/tools/barrnap-0.9/bin/barrnap -k mito -o mmar.min_150.pseudohap2.1_HiC_rRNA_mito.fa < /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/assemblies/hic/mmar.min_150.pseudohap2.1_HiC.fasta > mmar.min_150.pseudohap2.1_HiC_rRNA_mito.gff;

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/annotation/hic1/barrnap/; pwd;
~/tools/barrnap-0.9/bin/barrnap -k euk -o mzib.min_150.pseudohap2.1_HiC_rRNA_euk.fa < /mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/assembles/hic1/mzib.min_150.pseudohap2.1_HiC.fasta > mzib.min_150.pseudohap2.1_HiC_rRNA_euk.gff;
echo 'mzib finish!';

cd /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/annotation/barrnap/; pwd;
~/tools/barrnap-0.9/bin/barrnap -k euk -o mmar.min_150.pseudohap2.1_HiC_rRNA_euk.fa < /mnt/tank/scratch/skliver/common/mustelidae/martes_martes/genome/assemblies/hic/mmar.min_150.pseudohap2.1_HiC.fasta > mmar.min_150.pseudohap2.1_HiC_rRNA_euk.gff;

echo 'mmar finish!';
date;
