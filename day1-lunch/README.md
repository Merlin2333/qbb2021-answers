# qbb2021-answers Day 1 Lunch
## Question 1d answer
cp qbb2021/data/*.bed qbb2021-answers/day1-lunch <br/>
cp qbb2021/data/*.sizes qbb2021-answers/day1-lunch

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
There are 5708 unique genes on chromosome 2L <br/>
There are 5411 unique genes on chromosome X

## Question 4
### Question 4b
bedtools summary -i fbgenes.bed -g dm6.chrom.sizes | column -t | head -10 > fbgenes.summary10

### Question 4c
The total number of bps of features on chromosome 2L is 54504363, and the minimum number of features on the chromosome is 210. <br/><br/>
The average bps of the features on chromosome X is 13144.761
