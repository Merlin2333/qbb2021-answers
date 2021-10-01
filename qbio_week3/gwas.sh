#!/bin/bash

# chmod a+x gwas.sh

#Step1: Perform PCA to visualize genetic relativeness
# Use plink
plink --vcf genotypes.vcf --pca

#Step2: Allele frequency calculation by PLINKv1
plink --vcf genotypes.vcf --freq
# This method can extract only the allele frequency
awk '{print $5}' /Users/cmdb/qbb2021-answers/week3/plink.frq > freq.txt

#Step3: Using plink, perform quantitative association testing for each phenotype
plink --vcf genotypes.vcf --pheno CB1908_IC50.txt --covar plink.eigenvec --covar-number 1-10 --linear --allow-no-sex --out CB1908

plink --vcf genotypes.vcf --pheno GS451_IC50.txt --covar plink.eigenvec --covar-number 1-10 --linear --allow-no-sex --out GS451
