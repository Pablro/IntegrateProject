import pangenomix.allele_identification
from pangenomix.allele_identification import create_alleles_fasta
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
    #Path to your name_nr.faa file result from CD-HIT
    input_faa = mypath +"/pangenome-data/NesseSmall1/CDS/nesse1pangenome50_nr.faa"
    #Path to your name_strain_by_gene.npz.labels.txt result from CD-HIT
    gene_npz_label_file = mypath+"/pangenome-data/NesseSmall1/CDS/nesse1pangenome50_strain_by_gene.npz.labels.txt"
    #Path to your name_strain_by_allele.npz.labels.txt result from CD-HIT
    allele_npz_label_file = mypath+ "/pangenome-data/NesseSmall1/CDS/nesse1pangenome50_strain_by_allele.npz.labels.txt"
    #Path to your name_strain_by_allele.npz result from CD-HIT
    allele_npz_file=mypath+"/pangenome-data/NesseSmall1/CDS/nesse1pangenome50_strain_by_allele.npz"
    #Path + filename.faa(type it) for generating the output file in the given directory
    output_faa=mypath+"/highly-express/NesseSmall1/highlyexpressed50nesse1.faa"
    create_alleles_fasta(allele_npz_file, gene_npz_label_file, allele_npz_label_file, input_faa, output_faa)
    ## Run EggNog and follow Github instructions.

    #Neisseria 2 sample 400
    #Path to your name_nr.faa file result from CD-HIT
    input_faa = mypath +"/pangenome-data/NesseLarge1/CDS/nesse1pangenome400_nr.faa"
    #Path to your name_strain_by_gene.npz.labels.txt result from CD-HIT
    gene_npz_label_file = mypath+"/pangenome-data/NesseLarge1/CDS/nesse1pangenome400_strain_by_gene.npz.labels.txt"
    #Path to your name_strain_by_allele.npz.labels.txt result from CD-HIT
    allele_npz_label_file = mypath+ "/pangenome-data/NesseLarge1/CDS/nesse1pangenome400_strain_by_allele.npz.labels.txt"
    #Path to your name_strain_by_allele.npz result from CD-HIT
    allele_npz_file=mypath+"/pangenome-data/NesseLarge1/CDS/nesse1pangenome400_strain_by_allele.npz"
    #Path + filename.faa(type it) for generating the output file in the given directory
    output_faa=mypath+"/highly-express/NesseLarge1/highlyexpressed400nesse1.faa"
    create_alleles_fasta(allele_npz_file, gene_npz_label_file, allele_npz_label_file, input_faa, output_faa)
    ## Run EggNog and follow Github instructions.
    
    #Neisseria 2

    #Bacteroides 1

    #Bacteroides 2
    







