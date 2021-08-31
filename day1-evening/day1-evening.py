#!/usr/bin/env python
# coding: utf-8

# In[4]:


#oepn the .sam file
f = open("/Users/cmdb/qbb2021-answers/day1-evening/SRR072893.sam")


# In[13]:


#Count number of alignments
align = []

count = 0
for line in f:
    field = line.strip().split('\t')
    if not line.startswith('@'): 
        count += 1
        align.append(field)

print('Question 1:')
print('There are',count, 'alignments')


# In[6]:


# Question #2

# Count the perfect match sequences
perfect_match = 0

for seq in align: 
    if seq[5].startswith('40M'):
        perfect_match +=1
    
print('Question 2:')
print('There are', perfect_match, 'perfect match sequences')  


# In[7]:


# Question #3

## create a list that store the MAPQ score for each alignment
MAPQ = []

for seq in align:
    MAPQ.append(int(seq[4]))
                    
print('Question 3:')
print('The average MAPQ score across all reads is', sum(MAPQ)/len(MAPQ))


# In[9]:


# Question #4
## Count number of reads that start their alignment on chromosome 2L between base 10000 and 20000

reads_count = 0
for seq in align:
    if seq[2].startswith('2L') and int(seq[3]) >= 10000 and int(seq[3]) <= 20000:
        reads_count += 1

print('Question 4:')
print('The number of reads that start their alignment on chromosome 2L between base 10000 and 20000 is', reads_count)


# In[10]:


# Question #5
## Count how many potential PCR duplicates are present.

unique_count = 0
for i in range(1, len(align)):
    if align[i][3] != align[i - 1][3]:
        unique_count += 1

duplicate = count - unique_count

print('Question 5:')
print('The number of potential PCR duplicaters is', duplicate)

