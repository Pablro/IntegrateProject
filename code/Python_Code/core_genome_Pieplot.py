import pangenomix.core_genome
from pangenomix.core_genome import create_core_genes
import os
import re
import numpy as np
import pandas as pd
import io
import sys
from matplotlib import pyplot as plt


#this just return the counts. function is equivalent to the counting in the fasta files.
def CountingCoreGenes(filtered_sequences):
    number_core_genes=len(filtered_sequences)
    return number_core_genes
#This function assigns each counting in a given probability a tag. So:
#98% n counts will be soft core gene
#therefore 1 genome .... N you get a probability for detecting those genes in 1,...,N genomes base on core_genome.py workflow
def assigningGeneType(genomeGenecounts):
    #greater than 99 % core Genes
    if genomeGenecounts['percentage']>=99:
        tag="core_genes"
    else:
        if genomeGenecounts['percentage']<99 and genomeGenecounts['percentage']>=95:
            tag="soft_core_genes"
        else:
            if genomeGenecounts['percentage']<95 and genomeGenecounts['percentage']>=15:
                tag="shell_genes"
            else:
                tag="cloud_genes"
    return tag
###Generate the pie plot
def Pieplot_geneType(allele_npz_file, allele_npz_label_file, gene_npz_file, gene_npz_label_file, input_faa,out_plot,sample):
    print("Starting process...")
    genome_num_values=list(range(sample))
    genome_num_values=(np.array(genome_num_values)+1).tolist()
    #this list basically contain the number of counts in a given num-genome.
    all_number_genes=[]
    #this list are the probabilities. Observed the gene 1/N or 2 /50 or N/N[core genes]
    all_freq=[]
    for num_genomes in genome_num_values:
        #Supress intermidiate prints from create_core_genes
        text_trap = io.StringIO()
        sys.stdout = text_trap
        filtered_sequences=create_core_genes(allele_npz_file, allele_npz_label_file, gene_npz_file, gene_npz_label_file, input_faa,num_genomes,None,True)
        #Restore for printing
        sys.stdout = sys.__stdout__
        #Counting core genes
        number_genes=CountingCoreGenes(filtered_sequences)
        all_number_genes.append(number_genes)
        freq=float(num_genomes/len(genome_num_values)*100)
        all_freq.append(freq)
        if freq is not 100:
            print("Counting gene types. "+str(freq)+"% of progress. Please wait ... ")
        else:
            print(str(freq)+"% of progress. Finished counting gene types.")
    dataFrame_array=[]
    dataFrame_array.append(genome_num_values)
    dataFrame_array.append(all_number_genes)
    dataFrame_array.append(all_freq)
    dataFrame_array=np.asarray_chkfinite(dataFrame_array)
    dataFrame_array=np.transpose(dataFrame_array)
    #this set a pandas dataframe in order to see the tables of counts and percentage, aditionally adds the flag to identify it as
    # core gene, etc. 
    genomeGenecounts=pd.DataFrame(dataFrame_array,columns=['num_genomes','counts','percentage'])
    genomeGenecounts=genomeGenecounts.assign(gene_type=genomeGenecounts.apply(assigningGeneType,axis=1))
    #The data frame is further summarise into another dataframe to sum all counts according to its tag. So then you have the counts per 
    #pangenome part. This is used in the pie plot.
    gene_types_counts=genomeGenecounts.groupby(['gene_type'])['counts'].sum().reset_index()
    
    print("finished. Proceeding to Plot...")
    #This plot command are adapted on the based matplotlib examples of pie charts
    fig,ax = plt.subplots(figsize=(6, 3), subplot_kw=dict(aspect="equal"))
    wedges, texts, autotexts = ax.pie(gene_types_counts['counts'], autopct=autopct_format(gene_types_counts['counts']),textprops=dict(color="w"))
    ax.legend(wedges, gene_types_counts['gene_type'],title="pangenome parts",loc="center left",bbox_to_anchor=(1, 0, 0.5, 1))
    plt.setp(autotexts, size=8, weight="bold")
    ax.set_title("Pangenome analysis")
    fig.savefig(out_plot + "/"+str(sample)+"core_genes_pieplot.png")
    print("The plot is finished")

#This function just found the relative percentage of the counts from the pie chart.
def autopct_format(values):
    def my_format(pct):
        total = sum(values)
        val = int(round(pct*total/100.0))
        return '{:.1f}%\n({v:d})'.format(pct, v=val)
    return my_format  






#Check that your terminal path is inside the repo before running the code. The reason is because when definining the default directory.
#If you are setting this paths manually then comment the defdir line code to avoid error.
if __name__ == '__main__':
        #The following line fo code assumes your actual path or working directory is inside the repo. 
     #Define the default directory to run almost automatically. If you want set manually ignore this line and modifiy the paths variables
    mypath=str(re.match(r"^(.*?)/IntegrateProject",os.getcwd()).group())+"/data"
    print(mypath)
    #Neisseria 1 sample 50
    #Change the file and directories names respectively
    gene_npz_label_file = mypath+"/pangenome-data/NesseSmall1/CDS/nesse1pangenome50_strain_by_gene.npz.labels.txt"
    input_faa = mypath+"/pangenome-data/NesseSmall1/CDS/nesse1pangenome50_nr.faa"
    allele_npz_label_file = mypath+ "/pangenome-data/NesseSmall1/CDS/nesse1pangenome50_strain_by_allele.npz.labels.txt"
    allele_npz_file=mypath+"/pangenome-data/NesseSmall1/CDS/nesse1pangenome50_strain_by_allele.npz" 
    gene_npz_file= mypath+"/pangenome-data/NesseSmall1/CDS/nesse1pangenome50_strain_by_gene.npz"
    #Fasta part for eggnog analysis in core genes.
    """
    small_genome_num_values={"100%":50,"98%":49,"96%":48,"94%":47,"16%":8}
    print("Starting Small")
    for key, value in small_genome_num_values.items():
        #This line is basically you gen n(number of genome_num values) fasta files. 
        #  mypath+"/core-genomes/NesseSmall1/"-first part of the path
        #  str(value) sample- identify your filename for the respective "genome_num" run
        # "nesse1_core.faa"- name of the file
        output_faa=mypath+"/core-genomes/NesseSmall1/"+str(value)+"nesse1_core.faa"
        try:
            create_core_genes(allele_npz_file, allele_npz_label_file, gene_npz_file, gene_npz_label_file, input_faa, value, output_faa)
        except:
            print("No core genomes at a genomes_num of: "+str(value))
        print("----------------")
        print("The process is finished for genome_num="+str(value)+"="+key)
        print("----------------")
    """
    sample=50
    out_plot=mypath+"/core-genomes/NesseSmall1"
    Pieplot_geneType(allele_npz_file, allele_npz_label_file, gene_npz_file, gene_npz_label_file, input_faa,out_plot,sample)
    #Neisseria 1 sample 400
    #Change the file and directories names respectively
    gene_npz_label_file = mypath+"/pangenome-data/NesseLarge1/CDS/nesse1pangenome400_strain_by_gene.npz.labels.txt"
    input_faa = mypath+"/pangenome-data/NesseLarge1/CDS/nesse1pangenome400_nr.faa"
    allele_npz_label_file = mypath+ "/pangenome-data/NesseLarge1/CDS/nesse1pangenome400_strain_by_allele.npz.labels.txt"
    allele_npz_file=mypath+"/pangenome-data/NesseLarge1/CDS/nesse1pangenome400_strain_by_allele.npz" 
    gene_npz_file= mypath+"/pangenome-data/NesseLarge1/CDS/nesse1pangenome400_strain_by_gene.npz"
    #fasta part for eggnog analysis of core genes
    """
    small_genome_num_values={"100%":400,"99%":396,"98%":392,"96%":384,"95%":380,"94%":376,"16%":64,"15%":60}
    print("Starting Large")
    for key, value in small_genome_num_values.items():
        #This line is basically you gen n(number of genome_num values) fasta files. 
        #  mypath+"/core-genomes/NesseSmall1/"-first part of the path
        #  str(value) sample- identify your filename for the respective "genome_num" run
        # "nesse1_core.faa"- name of the file    
        output_faa=mypath+"/core-genomes/NesseLarge1/"+str(value)+"nesse1_core.faa"
        try:
            create_core_genes(allele_npz_file, allele_npz_label_file, gene_npz_file, gene_npz_label_file, input_faa, value, output_faa)
        except:
            print("No core genomes at a genomes_num of: "+str(value))
        print("----------------")
        print("The process is finished for genome_num="+str(value)+"="+key)
        print("----------------")
    """
    #Pie plot: This plot will likely be interrupt as is too large. RUN it in HPC with SLURM or ONDEMAND. and verify you the 400 analysis can be finished.
    #sample=400
    #out_plot=mypath+"/core-genomes/NesseLarge1"
    #Pieplot_geneType(allele_npz_file, allele_npz_label_file, gene_npz_file, gene_npz_label_file, input_faa,out_plot,sample)

    
#Neisseria Sample 2
gene_npz_label_file = mypath+"/pangenome-data/NesseSmall2/CDS/output50_strain_by_gene.npz.labels.txt"
input_faa = mypath+"/pangenome-data/NesseSmall2/CDS/output50_nr.faa"
allele_npz_label_file = mypath+ "/pangenome-data/NesseSmall2/CDS/output50_strain_by_allele.npz.labels.txt"
allele_npz_file=mypath+"/pangenome-data/NesseSmall2/CDS/output50_strain_by_allele.npz" 
gene_npz_file= mypath+"/pangenome-data/NesseSmall2/CDS/output50_strain_by_gene.npz"
sample=50
out_plot=mypath+"/core-genomes/NesseSmall2"
Pieplot_geneType(allele_npz_file, allele_npz_label_file, gene_npz_file, gene_npz_label_file, input_faa,out_plot,sample)

#Bacteroides sample 1
#Bacteroides sample 2


