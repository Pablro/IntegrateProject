'''
This script build the pangenome without running in python terminal
The procedure in the code is the one discuss by Anna.
You can rename files and directories to your local conventions.
'''
import os
from pangenomix.pangenome import build_cds_pangenome
from pangenomix.pangenome import list_faa_files
import re
from pangenomix.pangenome import find_matching_genome_files, build_noncoding_pangenome
from pangenomix.manage_extensions import change_url_extensions, rename_files_with_extension
'''
IMPORTANT note: check directory and file names when implementing for your samples.
Here it is only implemented Neisseria 1  samples.
restore your lmod environment which has cd-hit(or ensure cd-hit is active).
The script assumes you have a directory in the repo called "fasta-files" which inside the data directory. Here
there should be all fasta files.
'''
if __name__ == '__main__':
    #STEP 2: type "cd" command to the repository name to update "pwd" or "os.getcwd()". Which is the current directory
    #the path  should be inside the repo
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
