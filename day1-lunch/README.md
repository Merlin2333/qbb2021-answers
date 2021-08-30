# qbb2021-answers Day 1 Lunch
## Question 1d answer
cp qbb2021/data/ *.bed qbb2021-answers/day1-lunch <br/>
cp qbb2021/data/ *.sizes qbb2021-answers/day1-lunch

## Question 2
### Question 2b
wc -l *.bed > feature_count.txt

### Question 2c
There are 7516 features annotated for K27me3 <br/>
There are 4909 featuers annotated for K4me3

## Question 3
### Question 3b
cut -f 1 fbgenes.bed | sort | uniq -c > fbgenes.info

### Question 3c
Chromosome Y has a much smaller number of genes compared to chromosome X <br/>
Chromosome 3R has the most number of genes

## Question 4
### Question 4c
~/qbb2021-answers/day1-lunch/$bedtools intersect -a fbgenes.bed -b K9me3.bed -u | cut -f 1 | uniq -c  >chr-with-fbgenes-k9.txt

### Question 4d
Chromosome Y has the lowest modifications; <br/>
Chromosome X has the largest number of modifications. 

## Question Adv 1
### Question Adv 1b
bedtools summary -i fbgenes.bed -g dm6.chrom.sizes | column -t | head -10 > fbgenes.summary10

### Question Adv 1c
The total number of bps of features on chromosome 2L is 54504363, and the minimum number of features on the chromosome is 210. <br/><br/>
The average bps of the features on chromosome X is 13144.761 <br/>
