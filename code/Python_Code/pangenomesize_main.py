from pangenomix.pangenome_analysis import estimate_pan_core_size
from pangenomix.pangenome_analysis import fit_heaps_by_iteration
import pangenomix.pangenome_analysis
import pangenomix.sparse_utils
import os
import re
#Check that your terminal path is inside the repo before running the code. The reason is because when definining the default directory.
#If you are setting this paths manually then comment the defdir line code to avoid error.
if __name__ == '__main__':
    #The following line fo code assumes your actual path or working directory is inside the repo. 
     #Define the default directory to run almost automatically. If you want set manually ignore this line and modifiy the paths variables
    defdir=str(re.match(r"^(.*?)/IntegrateProject",os.getcwd()).group())+"/data"
    #Neisseria 1 sample 50
    #path to your npz file to your 50 sample. You can change it manually
    path1=defdir+"/pangenome-data/NesseSmall1/CDS/nesse1pangenome50_strain_by_gene.npz"
    df_genes = pangenomix.sparse_utils.read_lsdf(path1)
    #Calculate pangenome size
    df_pan_core=estimate_pan_core_size(df_genes, 1)
    print("pangenome size result:")
    print(df_pan_core)
    #Applies Heaps Law
    fit_heaps = fit_heaps_by_iteration(df_pan_core)
    print("heaps law result:")
    print(fit_heaps)

        #Neisseria 1 sample 400
    #path to your npz file to your 400 sample. You can change it manually
    path2=defdir+"/pangenome-data/NesseLarge1/CDS/nesse1pangenome400_strain_by_gene.npz"
    df_genes = pangenomix.sparse_utils.read_lsdf(path2)
    #Calculate pangenome size
    df_pan_core=estimate_pan_core_size(df_genes, 1)
    print("pangenome size result:")
    print(df_pan_core)
    #Applies Heaps Law
    fit_heaps = fit_heaps_by_iteration(df_pan_core)
    print("heaps law result:")
    print(fit_heaps)

#Repeat  and adapt code for your filename(this is a must) and path names and directories names(if you are working with manual setting).
#Neisseria sample 2
#Bacteroides sample 1
#Bacteroides sample 2