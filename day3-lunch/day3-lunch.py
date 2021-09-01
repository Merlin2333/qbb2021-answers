import sys

def main():
    #parse the input file
    gtf_file = sys.argv[1]
    mut_chrom = sys.argv[2]
    mut_pos = int(sys.argv[3])
    f = open(gtf_file)

    genes = []
    for line in f:
        if line.startswith("#"):
            continue
        fields = line.strip("\r\n").split("\t")
        start = int(fields[3])
        end = int(fields[4])
        if (fields[0] == mut_chrom) and (fields[2] == "gene") and ('gene_biotype "protein_coding"' in line):
            subfields = fields[-1].split(';')
            for field in subfields:
                if "gene_name" in field:
                    gene_name = field.split()[1]
            genes.append((gene_name, start, end))


    #Set initial high and indexes and current index for binary search
    high = len(genes)
    low = 0
    current_index = (low + high) // 2 #only keep the int values for indexing

    #count the iteration
    counter = 0

    #function to perform a binary search using while loop:
    while True:
        current_gene = genes[current_index][0] #the current gene name from the genes list
        current_position = genes[current_index][1] #gene position associated with the gene gene_name

        counter += 1

        if current_position < mut_pos:
            if current_index == low: #check if the current index is already the low index.
                if abs(current_position - mut_pos) > abs(genes[current_index + 1][1] - mut_pos):
                    #check the relative distance between neigboring genes
                    current_index = current_index + 1
                    current_gene = genes[current_index][0]
                else:
                    pass

                print("The closest gene to the position 3R:21,378,950 is", current_gene)

                break
            low = current_index
            current_index = (low + high) // 2

        elif current_position > mut_pos:
            if current_index == high: #check if the current index is already the high index.
                if abs(current_position - mut_pos) > abs(genes[current_index - 1][1] - mut_pos):
                    current_index = current_index - 1
                    current_gene = genes[current_index][0]
                else:
                    pass

                print("The closest gene to the position 3R:21,378,950 is", current_gene) #if so, print the current gene, break the while loop

                break

            high = current_index
            current_index = (low + high) // 2

        else: #if the current position is the same as the input, print gene name, break the while loop
            print("The closest gene to the position 3R:21,378,950 is", current_gene)
            break

    print(current_gene, "'s linear genomic distance from 3R:21,378,950 is", distance(mut_pos, genes[current_index][1]))
    print("There are", counter, "iterations.")

def distance(mut_pos, current_gene_position):
    return(abs(mut_pos - current_gene_position))



if __name__ == "__main__":
    main()
