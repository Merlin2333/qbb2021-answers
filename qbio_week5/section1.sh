#!/bin/bash

#Get the dataset for histone modification and transcription factor assays
# wget https://bx.bio.jhu.edu/data/msauria/cmdb-lab/g1e.tar.xz
# tar xzf g1e.tar.xz


#Align the sequence reads (unpaired) to the reference genome
#TF and histone modification sites
# bowtie2 -x /Users/cmdb/data/indexes/bowtie2/mm10/mm10 -U /Users/cmdb/qbb2021-answers/qbio_week5/seq_reads/CTCF_ER4.fastq > CTCF_ER4_aln.sam
# bowtie2 -x /Users/cmdb/data/indexes/bowtie2/mm10/mm10 -U /Users/cmdb/qbb2021-answers/qbio_week5/seq_reads/CTCF_G1E.fastq > CTCF_G1E_aln.sam

#Reference sequence sites aligned to the reference genome
# bowtie2 -x /Users/cmdb/data/indexes/bowtie2/mm10/mm10 -U /Users/cmdb/qbb2021-answers/qbio_week5/seq_reads/input_ER4.fastq > input_ER4_aln.sam
# bowtie2 -x /Users/cmdb/data/indexes/bowtie2/mm10/mm10 -U /Users/cmdb/qbb2021-answers/qbio_week5/seq_reads/input_G1E.fastq > input_G1E_aln.sam

#Calling peaks
# macs2 callpeak -t CTCF_ER4_aln.sam -c input_ER4_aln.sam --name=ER4 --gsize=mm --outdir /Users/cmdb/qbb2021-answers/qbio_week5/ER4_peaks --bdg
# macs2 callpeak -t CTCF_G1E_aln.sam -c input_G1E_aln.sam --name=G1E --gsize=mm --outdir /Users/cmdb/qbb2021-answers/qbio_week5/G1E_peaks --bdg

#Differential binding
#Gain of CTCF binding E-G
bedtools subtract -A -a /Users/cmdb/qbb2021-answers/qbio_week5/ER4_peaks/ER4_peaks.narrowPeak -b /Users/cmdb/qbb2021-answers/qbio_week5/G1E_peaks/G1E_peaks.narrowPeak > gain_CTCF_binding.bed
#Loss of CTCF binding G-E
bedtools subtract -A -a /Users/cmdb/qbb2021-answers/qbio_week5/G1E_peaks/G1E_peaks.narrowPeak -b /Users/cmdb/qbb2021-answers/qbio_week5/ER4_peaks/ER4_peaks.narrowPeak > loss_CTCF_binding.bed

#Feature overlapping
#E4 features overlap
#bedtools intersect allows one to screen for overlaps between two sets of genomic features.
# bedtools intersect -a /Users/cmdb/qbb2021-answers/qbio_week5/Mus_musculus.GRCm38.94_features.bed -b /Users/cmdb/qbb2021-answers/qbio_week5/ER4_peaks/ER4_peaks.narrowPeak -wo > ER4_feature.bed
#G1E features overlap
# bedtools intersect -a /Users/cmdb/qbb2021-answers/qbio_week5/Mus_musculus.GRCm38.94_features.bed -b /Users/cmdb/qbb2021-answers/qbio_week5/G1E_peaks/G1E_peaks.narrowPeak -wo > G1E_feature.bed
