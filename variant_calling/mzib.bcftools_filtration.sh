#!/bin/bash

BWA_ALIGNMENT="/mnt/tank/scratch/skliver/common/mustelidae/martes_zibellina/genome/alignment/hic.purged/bwa_alignment"
VCF="mzib.allsamples.vcf.gz"
PREFIX=${VCF%.*.*}
export PATH=/mnt/tank/scratch/atomarovsky/tools/bcftools-1.15.1/bin:/mnt/tank/scratch/atomarovsky/tools/bedtools-2.30.0/bin:/mnt/tank/scratch/atomarovsky/tools/vcftools-0.1.16/bin:${PATH}

#---- script ----
mkdir bcftools_filtration/
cd bcftools_filtration/

echo "VCF filtration"
bcftools filter --threads 4 -S . -O v -o ${PREFIX}.filt.vcf --exclude 'QUAL < 20.0 || (FORMAT/SP > 60.0 || FORMAT/DP < 5.0 || FORMAT/GQ < 20.0)' ../${VCF}

echo "Sample separation"
touch samples.tmp
for SAMPLE in `bcftools query -l ${PREFIX}.filt.vcf`; do
	echo "Sample: ${SAMPLE}";
	#vcf-subset --exclude-ref -c ${SAMPLE} ${PREFIX}.filt.vcf > ${SAMPLE}.${PREFIX}.filt.vcf;
	bcftools view --threads 4 --min-ac 1 --with-header -s ${SAMPLE} -O v -o ${SAMPLE}.${PREFIX}.filt.vcf ${PREFIX}.filt.vcf;
	bedtools intersect -header -v -a ${SAMPLE}.${PREFIX}.filt.vcf -b ${BWA_ALIGNMENT}/${SAMPLE}/${SAMPLE}.mzib.hic.purged.mkdup.mapq10.per-base.bed.gz.max250.min33 > ${SAMPLE}.${PREFIX}.filt.masked.vcf
	echo ${SAMPLE}.${PREFIX}.filt.masked.vcf >> samples.tmp;
done

for FILE in $(cat samples.tmp); do
	echo "indel and snp";
	bcftools filter --threads 4 -i  'TYPE="indel"' -O v ${FILE} > ${FILE%.*}.indel.vcf;
	bcftools filter --threads 4 -i  'TYPE="snp"' -O v ${FILE} > ${FILE%.*}.snp.vcf;
	echo "hetero variants"
	bcftools filter --threads 4 -i 'FMT/GT = "het"' -O v ${FILE%.*}.indel.vcf > ${FILE%.*}.indel.hetero.vcf;
	bcftools filter --threads 4 -i 'FMT/GT = "het"' -O v ${FILE%.*}.snp.vcf > ${FILE%.*}.snp.hetero.vcf;
	echo "homo variants"
	bcftools filter --threads 4 -i 'FMT/GT = "hom"' -O v ${FILE%.*}.indel.vcf > ${FILE%.*}.indel.homo.vcf;
	bcftools filter --threads 4 -i 'FMT/GT = "hom"' -O v ${FILE%.*}.snp.vcf > ${FILE%.*}.snp.homo.vcf;
done


