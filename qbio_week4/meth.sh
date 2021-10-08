#!/bin/bash

#Step 1: index the reference genome
# bismark_genome_preparation /Users/cmdb/qbb2021-answers/qbio_week4/index/ --parallel 7

#Step2: map two experiments separately to the genome
#STEM-seq E4.0ICM
# bismark --genome /Users/cmdb/qbb2021-answers/qbio_week4/index -1 /Users/cmdb/qbb2021-answers/qbio_week4/STEM-seq_E4.0ICM/STEM-seq_E4.0ICM_ep1_1.chr6.fastq -2 /Users/cmdb/qbb2021-answers/qbio_week4/STEM-seq_E4.0ICM/STEM-seq_E4.0ICM_rep1_2.chr6.fastq -B E4.0ICM

#STEM-seq E5.5Epi
# bismark --genome /Users/cmdb/qbb2021-answers/qbio_week4/index -1 /Users/cmdb/qbb2021-answers/qbio_week4/STEM-seq_E5.5Epi/STEM-seq_E5.5Epi_rep1_1.chr6.fastq -2 /Users/cmdb/qbb2021-answers/qbio_week4/STEM-seq_E5.5Epi/STEM-seq_E5.5Epi_rep1_2.chr6.fastq -B E5.5Epi

#Step3: Remove duplicate reads
# deduplicate_bismark --bam /Users/cmdb/qbb2021-answers/qbio_week4/STEM-seq_E4.0ICM/E4.0ICM_pe.bam

# deduplicate_bismark --bam /Users/cmdb/qbb2021-answers/qbio_week4/STEM-seq_E5.5Epi/E5.5Epi_pe.bam

#Step4: sort and index the BAM file separately
# samtools sort /Users/cmdb/qbb2021-answers/qbio_week4/STEM-seq_E4.0ICM/E4.0ICM_pe.deduplicated.bam -o E4.01CM_sort.bam
# samtools index E4.01CM_sort.bam

# samtools sort /Users/cmdb/qbb2021-answers/qbio_week4/STEM-seq_E5.5Epi/E5.5Epi_pe.deduplicated.bam -o E5.5Epi_sort.bam
# samtools index E5.5Epi_sort.bam

#Step5 Visualize IGV to visualize bam files with methylation databasey
# bismark_methylation_extractor --bedgraph --comprehensive /Users/cmdb/qbb2021-answers/qbio_week4/STEM-seq_E5.5Epi/E5.5Epi_pe.deduplicated.bam
# bismark_methylation_extractor --bedgraph --comprehensive /Users/cmdb/qbb2021-answers/qbio_week4/STEM-seq_E4.0ICM/E4.0ICM_pe.deduplicated.bam

#Step 6: Extract the promoter:
# awk 'BEGIN{OFS="\t"}{if ($4 == "+") print $3,$5 - 2000,$5,$13,$12,$4; else print $3,$6,$6 + 2000,$13,$12,$4;}' mm10_refseq_genes_chr6_50M_60M.bed | grep -v Rik | uniq -f 3 | sort -k2,2n > promoters.bed

#Step 7: map the methylation siganls from both cells to the promoter region
# bedtools map -c 4 -a /Users/cmdb/qbb2021-answers/qbio_week4/promoters.bed -b /Users/cmdb/qbb2021-answers/qbio_week4/STEM-seq_E4.0ICM/methylation/E4.0ICM_pe.deduplicated.bedGraph > E4_promoter_meth.txt
# bedtools map -c 4 -a /Users/cmdb/qbb2021-answers/qbio_week4/promoters.bed -b /Users/cmdb/qbb2021-answers/qbio_week4/STEM-seq_E5.5Epi/methylation/E5.5Epi_pe.deduplicated.bedGraph > E5.5_promoter_meth.txt

#T-test
#t test between Hox and other genes in E4
#Ttest_indResult(statistic=1.3120847753050175, pvalue=0.192352780310549)

#t test between Hox and other genes in E5.5
#Ttest_indResult(statistic=-2.8618380769825458, pvalue=0.0050844215499579294)
