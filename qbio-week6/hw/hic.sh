#!/bin/bash

#Convert the bigwig file to a bedgraph file
bigWigToBedGraph K562_hg19_H3K27me3_chr3.bw K562_hg19_H3K27me3_chr3.bg

#Adjust the score to reflect the fact that the intervals are not uniform
awk 'BEGIN{OFS="\t"}{$5=($3-$2)*$4; print $1,$2,$3,$4,$5}' K562_hg19_H3K27me3_chr3.bg > K562_hg19_H3K27me3_chr3_norm.bg

#create an overlap of H3K27me3 score (normalized) with the bed file
bedtools map -a K562_hg19_FPKM_chr3.bed -b K562_hg19_H3K27me3_chr3_norm.bg -c 5 -o sum  > K562_hg19_FPKM_chr3_map.bed

#normalized the expression score by each gene
awk 'BEGIN{OFS="\t"}{$7=$7 / ($3-$2); print $1,$2,$3,$4,$5,$6,$7}' K562_hg19_FPKM_chr3_map.bed > K562_hg19_FPKM_chr3_mapnorm.bed

#map compartment data with the gene expression file
bedtools map -a K562_hg19_FPKM_chr3_mapnorm.bed -b compartment.bed -c 5 -f 0.50 -o distinct > K562_hg19_FPKM_chr3_compartment_map.bed
