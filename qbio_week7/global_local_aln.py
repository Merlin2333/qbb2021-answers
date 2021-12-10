#!/usr/bin/env python3
import pandas as pd
import numpy as np
import sys

from pandas.io.sql import PandasSQL

##FASTAreader function
def FASTAReader(file):
    # Get the first line, which should contain the sequence name
    line = file.readline()

    # Let's make sure the file looks like a FASTA file
    assert line.startswith('>'), "Not a FASTA file"
    
    # Get the sequence name
    seq_id = line[1:].rstrip('\r\n')

    # create a list to contain the 
    sequence = []

    # Get the next line
    line = file.readline()

    # Add a list to hold all of the sequences in
    sequences = []

    # Keep reading lines until we run out
    while line:
        # Check if we've reached a new sequence (in a multi-sequence file)
        if line.startswith('>'):
            # Add previous sequence to list
            sequences.append((seq_id, ''.join(sequence)))
            
            # Record new sequence name and reset sequence
            seq_id = line[1:].rstrip('\r\n')
            sequence = []
        else:
            # Add next chunk of sequence
            sequence.append(line.strip())
        
        # Get the next line
        line = file.readline()
    # Add the last sequence to sequences
    sequences.append((seq_id, ''.join(sequence)))

    return sequences
##FASTAreader end def

##system input
#sequence as sys input
seq_string = sys.argv[1]
#import the scoring matrix as an argument
mat_string = sys.argv[2]
#import panelty for gaps
gap_score = float(sys.argv[3])
# #filepath to write alignment
# out_path = sys.argv[4]

##end sys inpu

##sequence extraction
#Read the sequence file using FASTAReader function
sequence = FASTAReader(open(seq_string,"r"))

#seperate each sequence with name and sequences
sequence1_name = sequence[0][0]
sequence1 = sequence[0][1]

sequence2_name = sequence[1][0]
sequence2 = sequence[1][1]
##end seq extraction

#input scoring matrix
score_mat = pd.read_csv(mat_string, delim_whitespace=True)


##Ini F-matrix and traceback matrix
#F-matrix
F_matrix = np.zeros((len(sequence1)+1, len(sequence2)+1))
# Now we need to fill in the values in the first row and
# first column, based on the gap penalty.
sequ1_len = len(sequence1)
sequ2_len = len(sequence2)
#columns
for i in range(sequ1_len+1):
    F_matrix[i,0] = i*gap_score

#rows
for j in range (sequ2_len+1):
    F_matrix[0,j] = j*gap_score

#traceback matrix
trace_mat = np.full([sequ1_len+1,sequ2_len+1], None)
#columns
for i in range(sequ1_len+1):
    trace_mat[i,0] = "v"

#rows
for j in range (sequ2_len+1):
    trace_mat[0,j] = "h"

##Populating the matrices
def match_score(nuc1,nuc2):
    return float(score_mat.loc[nuc1,nuc2])

for i in range(1, sequ1_len+1):
    for j in range(1, sequ2_len+1):
        d = F_matrix[i-1, j-1] + match_score(sequence1[i-1],sequence2[j-1])
        h = F_matrix[i, j-1] +gap_score
        v = F_matrix[i-1,j] + gap_score

        F_matrix[i,j] = max(d,h,v)

        if d == max(d,h,v):
            trace_mat[i,j] = "d"
            continue
        elif h == max(d,h,v):
            trace_mat[i,j] = "h"
            continue
        elif v == max(d,h,v):
            trace_mat[i,j] = "v"

##Sequence alignment 
seq1_len = len(sequence1)
seq2_len = len(sequence2)

seq1_align = sequence1[seq1_len-1]
seq2_align = sequence2[seq2_len-1]


score = F_matrix[seq1_len,seq2_len]

seq1_gap = 0
seq2_gap = 0

while seq1_len > 0 and seq2_len >0 :
    if trace_mat[seq1_len, seq2_len] == "d":
        seq1_len -= 1
        seq2_len -= 1
        seq1_align = sequence1[seq1_len-1] + seq1_align
        seq2_align = sequence2[seq2_len-1] + seq2_align
    elif trace_mat[seq1_len, seq2_len] == "h":
        seq2_len -=1
        seq1_align = '-' + seq1_align
        seq2_align = sequence2[seq2_len-1] + seq2_align
        seq1_gap +=1
    else:
        seq1_len -=1
        seq1_align = sequence1[seq1_len-1] + seq1_align
        seq2_align = '-' + seq2_align
        seq2_gap +=1

##write out the output alignment file
#provide the path for write output file
f1 = open(sys.argv[4], 'w')
same = '' #set an empty string, whether the sequences are same on the position
#set the alignment length for each line to 80 bps
counter = 0 #count how many bps before the end of the sequnce
for i in range(1, len(seq1_align)+1):
    if seq1_align[i-1] == seq2_align[i-1]:
        same = same + '|'
    else:
        same = same + '*'
    if (i % 80 == 0):
        f1.write(seq1_align[i-80: i]+ "  " + str(i)+'\n')

        f1.write(same +'\n')
        f1.write(seq2_align[i-80:i] + '\n\n')
        same = ''
        counter = i
    if i == len(seq1_align):
        f1.write(seq1_align[counter: i]+ "  " + str(i)+'\n')
        f1.write(same +'\n')
        f1.write(seq2_align[counter:i] + '\n\n')
        same = ''

f1.close()

#print information
print("Gaps in sequence 1: {}".format(seq1_gap))
print("Gaps in sequence 2: {}".format(seq2_gap))
print("Score of the alignment: {}".format(score))








