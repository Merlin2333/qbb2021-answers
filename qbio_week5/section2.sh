#!/bin/bash

###Motif discovery
##Sort and get the 100 strongest peaks
#In order to get the top peaks, we'll need to sort by the p-values (eigth column) in
#reverse order (largest first since the scores are -log transformed) in the narrowPeak file.
#sort at the eigth column (-k 8,8), reverse order (-nr)

#ER4
# sort -k8,8nr /Users/cmdb/qbb2021-answers/qbio_week5/ER4_peaks/ER4_peaks.narrowPeak > /Users/cmdb/qbb2021-answers/qbio_week5/ER4_peaks/ER4_sorted.narrowPeak
# head -n 100 /Users/cmdb/qbb2021-answers/qbio_week5/ER4_peaks/ER4_sorted.narrowPeak > ER4_top100.narrowPeak

#G1E
# sort -k8,8nr /Users/cmdb/qbb2021-answers/qbio_week5/G1E_peaks/G1E_peaks.narrowPeak > /Users/cmdb/qbb2021-answers/qbio_week5/G1E_peaks/G1E_sorted.narrowPeak
# head -n 100 /Users/cmdb/qbb2021-answers/qbio_week5/G1E_peaks/G1E_sorted.narrowPeak > G1E_top100.narrowPeak

##Extract the Sequence using bedtools getfasta <https://bedtools.readthedocs.io/en/latest/content/tools/getfasta.html>
#ER4
# bedtools getfasta -fi /Users/cmdb/qbb2021-answers/qbio_week5/mm10.fa -bed ER4_top100.narrowPeak > ER4_top100.fa

#G1E
# bedtools getfasta -fi /Users/cmdb/qbb2021-answers/qbio_week5/mm10.fa -bed G1E_top100.narrowPeak > G1E_top100.fa

##Motif finding for ER4
# meme-chip -meme-maxw 20 /Users/cmdb/qbb2021-answers/qbio_week5/ER4_top100.fa

##Scan these motifs against the (JASPAR CORE 2018)
# tomtom /Users/cmdb/qbb2021-answers/qbio_week5/memechip_out/meme_out/meme.txt /Users/cmdb/qbb2021-answers/qbio_week5/JASPAR2018_CORE_non-redundant_pfms_meme/MA* -o /Users/cmdb/qbb2021-answers/qbio_week5/tomtom_result
