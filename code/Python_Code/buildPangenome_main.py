'''
This script build the pangenome without running in python terminal
Some points need to be run manually or once. This are specified below.
The procedure in the code is the one discuss by Anna.
Hopefully you can add your samples to complete the code.
'''
import os
from pangenomix.pangenome import build_cds_pangenome
from pangenomix.pangenome import list_faa_files
import re
from pangenomix.pangenome import find_matching_genome_files, build_noncoding_pangenome
from pangenomix.manage_extensions import change_url_extensions, rename_files_with_extension
'''
IMPORTANT note: check directory and file names when implementing for your samples.
Here it is only implemented Neisseria 1  samples. Unzip all fasta files before starting.
restore your lmod environment which has cd-hit.
'''
if __name__ == '__main__':
    #STEP 1: unzip fasta files
    #STEP 2: type "cd" command to the repository name to update "pwd" or "os.getcwd()". Which is the current directory
    #it should be inside the repo
    #you can also adjust my path manually as you prefer.

    #STEP 3: Define the default directory to run almost automatically.
    mypath=str(re.match(r"^(.*?)/IntegrateProject",os.getcwd()).group())
    print(mypath)
    #Step 4: CDS pagenome construction.
    #Add the code for your samples and check for your files and directories names.
   #Neisseria sample 1
    #Pangenome workflow 1:CDS  analsysis
    #sample of 50
    faa_files_50=list_faa_files(mypath+"/data/fasta-files/NesseSmall1faa")
    #sample of 400
    faa_files_400=list_faa_files(mypath+"/data/fasta-files/NesseLarge1faa")
    #Building pangenome
    #cd-hit settings according to discussed in documentation by Yanlin
    #cds pangenome for 50
    build_cds_pangenome(genome_faa_paths=faa_files_50, output_dir=mypath+"/data/pangenome-data/NesseSmall1/CDS", name="nesse1pangenome50",cdhit_args={'-M':0,'-n':5,'-c':0.8,'-aL':0.8})
    #cds pangenome for 400
    build_cds_pangenome(genome_faa_paths=faa_files_400, output_dir=mypath+"/data/pangenome-data/NesseLarge1/CDS", name="nesse1pangenome400",cdhit_args={'-M':0,'-n':5,'-c':0.8,'-aL':0.8})
    
    #STEP 5: ncRNA pangenome construction.
    #Add the code for your samples and check for your files and directories names.

    #Pangenome workflow 2:non coding pangenome Analysis
    #50 sample
    change_url_extensions(mypath+"/data/bash-input-data/50neisseria1_faa.txt","50neisseria1_gff.txt",".faa",".gff")
    #400 sample
    change_url_extensions(mypath+"/data/bash-input-data/400neisseria1_faa.txt","400neisseria1_gff.txt",".faa",".gff")

# MANUAL STEP: download the gff files before proceeding with wget. Follow Anna procedure.
#Run once the following coment two lines script: Rename the .PATRIC.gff to .gff
#rename_files_with_extension(mypath+"/data/fasta-files/NesseLarge1gff",".PATRIC.gff",".gff")
#rename_files_with_extension(mypath+"/data/fasta-files/NesseSmall1gff",".PATRIC.gff",".gff")

#matching files
#50 sample
nesse50matching_files=find_matching_genome_files(mypath+"/data/fasta-files/NesseSmall1gff",mypath+"/data/fasta-files/NesseSmall1fna")
#400 sample
nesse400matching_files=find_matching_genome_files(mypath+"/data/fasta-files/NesseLarge1gff",mypath+"/data/fasta-files/NesseLarge1fna")

#Building pangenome
#cd-hit settings according to discussed in documentation by Yanlin
#50 sample
build_noncoding_pangenome(genome_data=nesse50matching_files, output_dir=mypath+"/data/pangenome-data/NesseSmall1/ncRNA",name="nesse1ncRNApangenome50",cdhit_args={'-M':0,'-n':5,'-c':0.8,'-aL':0.8})
#400 sample
build_noncoding_pangenome(genome_data=nesse400matching_files, output_dir=mypath+"/data/pangenome-data/NesseLarge1/ncRNA",name="nesse1ncRNApangenome400",cdhit_args={'-M':0,'-n':5,'-c':0.8,'-aL':0.8})

#Neisseria sample 2

#Bacteroides sample 1


#Bacteroides sample 2
