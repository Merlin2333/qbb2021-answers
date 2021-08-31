import sys
import pandas as pd
from pandas import DataFrame

#Take the first system arguments as input. Should be a mapping file
#print("Input a mapping file:\n")
mapping = sys.argv[1]

#Take the 2nd sys arg as a c_tab file
#print("Input a c_tab file:\n")
c_tab = sys.argv[2]

#The 3rd sys arg as standard for replacing missing gene-protein pair from the mapping file
#my_protein = sys.argv[3]


#Store the gene_id and protein_id pairs from the mapping file
gene_protein_map = {}
#Open the mapping file
f_mapping = open(mapping)

# for loop to go through each line of the mapping file
for line in f_mapping:
    field = line.strip('\n').split('\t')
    gene_protein_map[field[0]] = field[1]

#Close the mapping file
f_mapping.close()

#Open the c_tab file that contains the flybase ID
f_fly = open(c_tab)

#Output list
out_put = []
#Match the gene_id with its corresponding protein_id
for line in f_fly.readlines():
    field = line.strip().split('\t')
    #If the gene is in the gene_protein_map dict, then replace that gene with respective protein_id
    if field[8] in gene_protein_map.keys():
        field[8] = gene_protein_map[field[8]]
    else:
        field[8] = 'Missing'
    #print(field)
    out_put.append(field)

out_put[0][8] = "protein id"

#Close the f_fly file
f_fly.close()

#write into a csv file using pandas
df = DataFrame(out_put[1:], columns = out_put[0])
df.to_csv(r'/Users/cmdb/qbb2021-answers/day2-lunch/day2_lunch_output.csv', index=False)


