import sys
import pandas as pd
from pandas import DataFrame

#Take the first system arguments as input. Should be a mapping file
mapping = sys.argv[1]

#Take the 2nd sys arg as a c_tab file
c_tab = sys.argv[2]

##Take the 3rd sys arg as custom protein
#protein = sys.argv[3]

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
        if len(sys.argv) == 3:
            field[8] = 'Missing'
        else:
            field[8] = sys.argv[3]
    #print(field)
    out_put.append(field)

out_put[0][8] = "protein id"

#Close the f_fly file
f_fly.close()

#write into a csv file using pandas
df = DataFrame(out_put[1:], columns = out_put[0])
df.to_csv(r'/Users/cmdb/qbb2021-answers/day2-lunch/day2_lunch_output.csv', index=False)


