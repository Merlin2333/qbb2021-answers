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
There are 5708 unique genes on chromosome 2L
There are 5411 unique genes on chromosome X
