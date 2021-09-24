#!/bin/bash

##Insert the command to download the files
#Sequence reads
wget "https://github.com/bxlab/qbb2021/raw/main/week2/BYxRM_subset.tar.xv"
tar -xvzf BYxRM_subset.tar.xv

#Reference genome
wget "http://hgdownload.soe.ucsc.edu/goldenPath/sacCer3/bigZips/chromFa.tar.gz"
tar -xvzf chromFa.tar.gz
cat chr*.fa > sacCer3.fa
rm chr*.fa

#Step 1: Index the sacCer3 genome
bwa index sacCer3.fa

#Step 2: Alignment with bwa mem
bwa mem -R "@RG\tID:A01_09.fastq\tSM:A01_09.fastq " sacCer3.fa A01_09.fastq > A01_09_aln.sam

bwa mem -R "@RG\tID:A01_11.fastq\tSM:A01_11.fastq " sacCer3.fa A01_11.fastq > A01_11_aln.sam

bwa mem -R "@RG\tID:A01_23.fastq\tSM:A01_23.fastq " sacCer3.fa A01_23.fastq > A01_23_aln.sam

bwa mem -R "@RG\tID:A01_24.fastq\tSM:A01_24.fastq " sacCer3.fa A01_24.fastq > A01_24_aln.sam

bwa mem -R "@RG\tID:A01_27.fastq\tSM:A01_27.fastq " sacCer3.fa A01_27.fastq > A01_27_aln.sam

bwa mem -R "@RG\tID:A01_31.fastq\tSM:A01_31.fastq " sacCer3.fa A01_31.fastq > A01_31_aln.sam

bwa mem -R "@RG\tID:A01_35.fastq\tSM:A01_35.fastq " sacCer3.fa A01_35.fastq > A01_35_aln.sam

bwa mem -R "@RG\tID:A01_39.fastq\tSM:A01_39.fastq " sacCer3.fa A01_39.fastq > A01_39_aln.sam

bwa mem -R "@RG\tID:A01_62.fastq\tSM:A01_62.fastq " sacCer3.fa A01_62.fastq > A01_62_aln.sam

bwa mem -R "@RG\tID:A01_63.fastq\tSM:A01_63.fastq " sacCer3.fa A01_63.fastq > A01_63_aln.sam

#Step 3: Create a sorted bam file with samtools, for input to variant callers

samtools merge finalBamFile.bam *.sam
samtools index finalBamFile.bam


#Step 4: Step 4: Variant calling with freebayes
freebayes -f sacCer3.fa finalBamFile.bam > yeast_variants.vcf

#Step 5: Filter variants based on genotype quality using vcffilter
#The Q_sequencing = -10log_10P, P as the probability of error. We are interested in
#the the error rate less than 0.01 (probability of being polymorphic is greater than 0.99)
#Thus, we are interested in the Q values (QUAL) greater than 20.

vcffilter -f "QUAL > 20" yeast_variants.vcf > yeast_variants_filted.vcf


#Step 6: Decompose complex haplotypes
vcfallelicprimitives -kg yeast_variants_filted.vcf > yeast_variants_haplo.vcf

#Step 7 Variant effect prediction
#Fetch the appropriate yeast reference database
snpeff download R64-1-1.99
snpeff ann R64-1-1.99 yeast_variants_haplo.vcf > variant_effect.vcf

#Step 8
# Read depth: DP
# Quality: QUAL
# Allele frequency: AF
