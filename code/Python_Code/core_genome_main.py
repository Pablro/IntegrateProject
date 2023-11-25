import pangenomix.core_genome
from pangenomix.core_genome import create_core_genes_fasta
import os
import re
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
    
    small_genome_num_values={"100%":50,"98%":49,"96%":48,"94%":47,"16%":8}
    print("Starting Small")
    for key, value in small_genome_num_values.items():
        #This line is basically you gen n(number of genome_num values) fasta files. 
        #  mypath+"/core-genomes/NesseSmall1/"-first part of the path
        #  str(value) sample- identify your filename for the respective "genome_num" run
        # "nesse1_core.faa"- name of the file
        output_faa=mypath+"/core-genomes/NesseSmall1/"+str(value)+"nesse1_core.faa"
        try:
            create_core_genes_fasta(allele_npz_file, allele_npz_label_file, gene_npz_file, gene_npz_label_file, input_faa, value, output_faa)
        except:
            print("No core genomes at a genomes_num of: "+value)
        print("----------------")
        print("The process is finished for genome_num="+str(value)+"="+key)
        print("----------------")

    #Neisseria 1 sample 400
    #Change the file and directories names respectively
    gene_npz_label_file = mypath+"/pangenome-data/NesseLarge1/CDS/nesse1pangenome400_strain_by_gene.npz.labels.txt"
    input_faa = mypath+"/pangenome-data/NesseLarge1/CDS/nesse1pangenome400_nr.faa"
    allele_npz_label_file = mypath+ "/pangenome-data/NesseLarge1/CDS/nesse1pangenome400_strain_by_allele.npz.labels.txt"
    allele_npz_file=mypath+"/pangenome-data/NesseLarge1/CDS/nesse1pangenome400_strain_by_allele.npz" 
    gene_npz_file= mypath+"/pangenome-data/NesseLarge1/CDS/nesse1pangenome400_strain_by_gene.npz"
    
    small_genome_num_values={"100%":400,"99%":396,"98%":392,"96%":384,"95%":380,"94%":376,"16%":64,"15%":60}
    print("Starting Large")
    for key, value in small_genome_num_values.items():
        #This line is basically you gen n(number of genome_num values) fasta files. 
        #  mypath+"/core-genomes/NesseSmall1/"-first part of the path
        #  str(value) sample- identify your filename for the respective "genome_num" run
        # "nesse1_core.faa"- name of the file    
        output_faa=mypath+"/core-genomes/NesseLarge1/"+str(value)+"nesse1_core.faa"
        try:
            create_core_genes_fasta(allele_npz_file, allele_npz_label_file, gene_npz_file, gene_npz_label_file, input_faa, value, output_faa)
        except:
            print("No core genomes at a genomes_num of: "+value)
        print("----------------")
        print("The process is finished for genome_num="+str(value)+"="+key)
        print("----------------")


#Neisseria Sample 2

#Bacteroides sample 1
#Bacteroides sample 2


