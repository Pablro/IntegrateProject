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

  

#Just copy and adapt(file and directories names) code above
#Neisseria Sample 2
    #For CDS pangenome
    #Small dataset
    pangenomedata=defdir+"/pangenome-data/NesseSmall2/CDS/output50_strain_by_gene.npz"
    pangenomeheaders=defdir+"/pangenome-data/NesseSmall2/CDS/output50_strain_by_gene.npz.labels.txt"
    nessedata=read_lsdf(pangenomedata, label_file=pangenomeheaders)
    nessedata=nessedata.transpose()
    pddata=nessedata.to_sparse_arrays()
    #We need to convert from sparse matrix to dense matrix to avoid conflict
    dense_df = pddata.sparse.to_dense()
    rdata=to_dataFrame_Robject(dense_df)
    robjects.r.assign("smallPanMatNesseTwo",rdata)
    os.chdir(defdir+"/Rdata")
    robjects.r("save(smallPanMatNesseTwo, file='{}')".format("50Nesse2panmatrixCDS.RData"))
    os.chdir(defdir)

    #Large Dataset
    pangenomedata=defdir+"/pangenome-data/NesseLarge2/CDS/output400_strain_by_gene.npz"
    pangenomeheaders=defdir+"/pangenome-data/NesseLarge2/CDS/output400_strain_by_gene.npz.labels.txt"
    nessedata=read_lsdf(pangenomedata, label_file=pangenomeheaders)
    nessedata=nessedata.transpose()
    pddata=nessedata.to_sparse_arrays()
    #We need to convert from sparse matrix to dense matrix to avoid conflict
    dense_df = pddata.sparse.to_dense()
    rdata=to_dataFrame_Robject(dense_df)
    robjects.r.assign("LargePanMatNesseTwo",rdata)
    os.chdir(defdir+"/Rdata")
    robjects.r("save(LargePanMatNesseTwo, file='{}')".format("400Nesse2panmatrixCDS.RData"))
    os.chdir(defdir)
#Bacteroides sample 1
    #For CDS pangenome
    #Small dataset
    pangenomedata=defdir+"/pangenome-data/BacteroSmall1/CDS/50bactero_strain_by_gene.npz"
    pangenomeheaders=defdir+"/pangenome-data/BacteroSmall1/CDS/50bactero_strain_by_gene.npz.labels.txt"
    nessedata=read_lsdf(pangenomedata, label_file=pangenomeheaders)
    nessedata=nessedata.transpose()
    pddata=nessedata.to_sparse_arrays()
    #We need to convert from sparse matrix to dense matrix to avoid conflict
    dense_df = pddata.sparse.to_dense()
    rdata=to_dataFrame_Robject(dense_df)
    robjects.r.assign("smallPanMatBacteroOne",rdata)
    os.chdir(defdir+"/Rdata")
    robjects.r("save(smallPanMatBacteroOne, file='{}')".format("50Bactero1panmatrixCDS.RData"))
    os.chdir(defdir)

    #Large Dataset
    pangenomedata=defdir+"/pangenome-data/BacteroLarge1/CDS/400bactero_strain_by_gene.npz"
    pangenomeheaders=defdir+"/pangenome-data/BacteroLarge1/CDS/400bactero_strain_by_gene.npz.labels.txt"
    nessedata=read_lsdf(pangenomedata, label_file=pangenomeheaders)
    nessedata=nessedata.transpose()
    pddata=nessedata.to_sparse_arrays()
    #We need to convert from sparse matrix to dense matrix to avoid conflict
    dense_df = pddata.sparse.to_dense()
    rdata=to_dataFrame_Robject(dense_df)
    robjects.r.assign("LargePanMatBacteroOne",rdata)
    os.chdir(defdir+"/Rdata")
    robjects.r("save(LargePanMatBacteroOne, file='{}')".format("400Bactero1panmatrixCDS.RData"))
    os.chdir(defdir)
#Bacteroides sample 2
    #For CDS pangenome
    #Small dataset
    pangenomedata=defdir+"/pangenome-data/BacteroSmall2/CDS/Bacteroides2_50_strain_by_gene.npz"
    pangenomeheaders=defdir+"/pangenome-data/BacteroSmall2/CDS/Bacteroides2_50_strain_by_gene.npz.labels.txt"
    nessedata=read_lsdf(pangenomedata, label_file=pangenomeheaders)
    nessedata=nessedata.transpose()
    pddata=nessedata.to_sparse_arrays()
    #We need to convert from sparse matrix to dense matrix to avoid conflict
    dense_df = pddata.sparse.to_dense()
    rdata=to_dataFrame_Robject(dense_df)
    robjects.r.assign("smallPanMatBacteroTwo",rdata)
    os.chdir(defdir+"/Rdata")
    robjects.r("save(smallPanMatBacteroTwo, file='{}')".format("50Bactero2panmatrixCDS.RData"))
    os.chdir(defdir)

    #Large Dataset
    pangenomedata=defdir+"/pangenome-data/BacteroLarge2/CDS/Bacteroides2_400_strain_by_gene.npz"
    pangenomeheaders=defdir+"/pangenome-data/BacteroLarge2/CDS/Bacteroides2_400_strain_by_gene.npz.labels.txt"
    nessedata=read_lsdf(pangenomedata, label_file=pangenomeheaders)
    nessedata=nessedata.transpose()
    pddata=nessedata.to_sparse_arrays()
    #We need to convert from sparse matrix to dense matrix to avoid conflict
    dense_df = pddata.sparse.to_dense()
    rdata=to_dataFrame_Robject(dense_df)
    robjects.r.assign("LargePanMatBacteroTwo",rdata)
    os.chdir(defdir+"/Rdata")
    robjects.r("save(LargePanMatBacteroTwo, file='{}')".format("400Bactero2panmatrixCDS.RData"))
    os.chdir(defdir)