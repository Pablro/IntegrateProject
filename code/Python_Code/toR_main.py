'''
This class transforms the pangenome matrix to be analyse in R for pangenome/core size.
'''
from pangenomix.sparse_utils import to_dataFrame_Robject
from pangenomix.sparse_utils import read_lsdf
import os
from rpy2 import robjects
import re
'''
Building R objects(dataframes) for further analysis like pangenome size estimation in R
'''
if __name__ == '__main__':
    #Define the default directory to run almost automatically.
    defdir=str(re.match(r"^(.*?)/IntegrateProject",os.getcwd()).group())+"/data"
    #Neisseria sample 1
    #For CDS pangenome
    #Small dataset
    pangenomedata=defdir+"/pangenome-data/NesseSmall1/CDS/nesse1pangenome50_strain_by_gene.npz"
    pangenomeheaders=defdir+"/pangenome-data/NesseSmall1/CDS/nesse1pangenome50_strain_by_gene.npz.labels.txt"
    nessedata=read_lsdf(pangenomedata, label_file=pangenomeheaders)
    nessedata=nessedata.transpose()
    pddata=nessedata.to_sparse_arrays()
    #We need to convert from sparse matrix to dense matrix to avoid conflict
    dense_df = pddata.sparse.to_dense()
    rdata=to_dataFrame_Robject(dense_df)
    robjects.r.assign("smallPanMatNesseOne",rdata)
    os.chdir(defdir+"/Rdata")
    robjects.r("save(smallPanMatNesseOne, file='{}')".format("50Nesse1panmatrixCDS.RData"))
    os.chdir(defdir)

    #Large Dataset
    pangenomedata=defdir+"/pangenome-data/NesseLarge1/CDS/nesse1pangenome400_strain_by_gene.npz"
    pangenomeheaders=defdir+"/pangenome-data/NesseLarge1/CDS/nesse1pangenome400_strain_by_gene.npz.labels.txt"
    nessedata=read_lsdf(pangenomedata, label_file=pangenomeheaders)
    nessedata=nessedata.transpose()
    pddata=nessedata.to_sparse_arrays()
    #We need to convert from sparse matrix to dense matrix to avoid conflict
    dense_df = pddata.sparse.to_dense()
    rdata=to_dataFrame_Robject(dense_df)
    robjects.r.assign("LargePanMatNesseOne",rdata)
    os.chdir(defdir+"/Rdata")
    robjects.r("save(LargePanMatNesseOne, file='{}')".format("400Nesse1panmatrixCDS.RData"))
    os.chdir(defdir)

    #For ncRNA pangenome
    #Small dataset
    pangenomedata=defdir+"/pangenome-data/NesseSmall1/ncRNA/nesse1ncRNApangenome50_strain_by_noncoding_gene.npz"
    pangenomeheaders=defdir+"/pangenome-data/NesseSmall1/ncRNA/nesse1ncRNApangenome50_strain_by_noncoding_gene.npz.labels.txt"
    nessedata=read_lsdf(pangenomedata, label_file=pangenomeheaders)
    nessedata=nessedata.transpose()
    pddata=nessedata.to_sparse_arrays()
    #We need to convert from sparse matrix to dense matrix to avoid conflict
    dense_df = pddata.sparse.to_dense()
    rdata=to_dataFrame_Robject(dense_df)
    robjects.r.assign("smallncRNAPanMatNesseOne",rdata)
    os.chdir(defdir+"/Rdata")
    robjects.r("save(smallncRNAPanMatNesseOne, file='{}')".format("50Nesse1panmatrixncRNA.RData"))
    os.chdir(defdir)

    #Large dataset
    pangenomedata=defdir+"/pangenome-data/NesseLarge1/ncRNA/nesse1ncRNApangenome400_strain_by_noncoding_gene.npz"
    pangenomeheaders=defdir+"/pangenome-data/NesseLarge1/ncRNA/nesse1ncRNApangenome400_strain_by_noncoding_gene.npz.labels.txt"
    nessedata=read_lsdf(pangenomedata, label_file=pangenomeheaders)
    nessedata=nessedata.transpose()
    pddata=nessedata.to_sparse_arrays()
    #We need to convert from sparse matrix to dense matrix to avoid conflict
    dense_df = pddata.sparse.to_dense()
    rdata=to_dataFrame_Robject(dense_df)
    robjects.r.assign("LargencRNAPanMatNesseOne",rdata)
    os.chdir(defdir+"/Rdata")
    robjects.r("save(LargencRNAPanMatNesseOne, file='{}')".format("400Nesse1panmatrixncRNA.RData"))
    os.chdir(defdir)

#Just copy and adapt(file and directories names) code above
#Neisseria Sample 2

#Bacteroides sample 1

#Bacteroides sample 2
