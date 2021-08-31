from fasta_reader import FASTAReader
import sys

#import files
target = sys.argv[1] #target
query = sys.argv[2] #query
#define k as in kmers
k = int(sys.argv[3])

#read target file
target_file = FASTAReader(open(target))

#build kmer dictionary
kmer_dic = {}
for seq_id, sequence in target_file: #iterate through sequence
    assert len(sequence) > 0, "Empty sequences"
    for i in range(0,len(sequence) - k): #iterate through each kmers
        kmer = sequence[i: i + k]
        if kmer not in kmer_dic.keys():
            kmer_dic.setdefault(kmer,[])
        kmer_dic[kmer].append((seq_id, i))

#read query file
query_file = FASTAReader(open(query))

#build a dictionary that store the position of the kmer and kmer sequences from the query
q_kmer_pos = {}
#grab kmers from the query
for id_sequence in query_file: #iterate through query file
    q_sequence = id_sequence[1]
    assert len(q_sequence) > 0, "Empty sequences"
    
    for i in range (0, len(q_sequence) - k): #iterate through every kmers in the query file
        q_kmer = sequence[i: i + k]
        if q_kmer in kmer_dic.keys():
            q_kmer_pos[(q_kmer, i)] = kmer_dic[q_kmer]


print(list(q_kmer_pos.items())[:1000])
            


