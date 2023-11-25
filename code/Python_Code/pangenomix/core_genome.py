import numpy as np
import pandas as pd
from Bio import SeqIO
import ast
from pangenomix.allele_identification import filter_sequences, find_allele_names,find_highest_expression,identify_gene_allele_rows,count_allele_occurence



def create_core_genes_fasta(allele_npz_file, allele_npz_label_file, gene_npz_file, gene_npz_label_file, input_faa,genomes_num, output_faa):

    # This function runs the whole pipeline that allows the user to obtain a list
    # of the most highly expressed alleles of each gene in the pangenome

    allele_occurence_count = count_allele_occurence(allele_npz_file)

    genes_alleles_pairs = identify_gene_allele_rows(gene_npz_label_file, allele_npz_label_file)

    gene_occurrence_count = count_gene_occurence(gene_npz_file)

    highest_gene_expression_rows = find_core_genes(gene_occurrence_count, genomes_num)
   
    highest_allele_expression_rows = subset_genes_alleles_pairs(genes_alleles_pairs, highest_gene_expression_rows)

    highest_expression_rows = find_highest_expression(allele_occurence_count, highest_allele_expression_rows)

    highest_expression_names = find_allele_names(highest_expression_rows, allele_npz_label_file)

    filter_sequences(input_faa, highest_expression_names, output_faa)




def subset_genes_alleles_pairs(allele_occurence_count, highest_gene_expression_rows):
    # Extract unique gene_index values from df2
    target_genes = highest_gene_expression_rows['gene_index'].unique()

    # Subset df1 based on the target_genes
    subset_allele_occurence_count = allele_occurence_count[allele_occurence_count['gene'].isin(target_genes)].copy()

    return subset_allele_occurence_count


def find_core_genes(gene_occurrence_count, genomes_num):
    # Initialize an empty list to store the results
    output_data = []

    # Iterate over rows in gene_occurrence_count
    for index, row in gene_occurrence_count.iterrows():
        gene = row['gene_index']
        count = row['count']
    
        # Append the result to the output data list only if highest_rows is greater than 50
        if count >= genomes_num:
            output_data.append({'gene_index': gene, 'highest_expression': count})

    # Create a DataFrame from the output data list
    output_df = pd.DataFrame(output_data)

    return output_df



def count_gene_occurence(gene_npz_file):
    # Counts the occurence of each gene in all genomes

    # Load the data
    with np.load(gene_npz_file) as data:
        row_indices = data['row']
        col_indices = data['col']

    # Create a DataFrame to count occurrences of each row index
    df = pd.DataFrame({'gene_index': row_indices, 'col': col_indices})

    # Add a column 'count' representing the number of occurrences for each row index
    df['count'] = df.groupby('gene_index')['col'].transform('size')

    # Drop duplicate rows to keep unique row indices
    df_unique = df.drop_duplicates(subset=['gene_index', 'count'])

    # Remove the 'col' column
    df_unique = df_unique.drop(columns=['col'])

    # Order the DataFrame by the 'row' column
    df_unique = df_unique.sort_values(by='gene_index')

    # Reset the index to ensure consistency
    df_unique = df_unique.reset_index(drop=True)

    print("\nCounted gene occurence")

    return df_unique

