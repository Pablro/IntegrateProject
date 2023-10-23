defdir="/Users/marshall/Documents/2ndYear"
sourdir=paste(defdir,"IntegrateProject/data/Rdata",sep="/")
setwd(sourdir)
load("Bacteroides.Rdata")
load("Neisseria.Rdata")
#parameters:
#totaldata- the whole dataset to revised for missing fasta.
#working direcctory- default working directory.
#filename- the user specifies the file names.
#this will pass the whole dataset for filtering the missing fastas in Unix
completedDatasetUnbalanceId<-function(totaldata,working_directory,filename){
  setwd(working_directory)
  # Retrieves all the ids for the dataset for further eliminating in bash the ones that do not have fasta file
  set.seed(123)
  totaldata<-totaldata[, "Genome.ID", drop = FALSE]
  for (i in 1:length(totaldata[,1])){
    totaldata[i,]=paste(paste(paste("ftp://ftp.bvbrc.org/genomes",totaldata[i,],sep="/"),totaldata[i,],sep="/"),"fna",sep = ".")
  }
  write.table(totaldata, file = paste(getwd(),paste("IntegrateProject/data/bash-input-data",filename,sep = "/"),sep = "/"), col.names = FALSE, row.names=FALSE,sep = "\t") 
}


######1-First step filtering Missing fastas##################
#The following line of code will generated a file with all ftp links for all(whole dataset) the ids of the select specie
#First specie:Bacteroides
completedDatasetUnbalanceId(bacterodata,defdir,"bacteroUnbalanceData.txt")
#Second specie: Nesseria
completedDatasetUnbalanceId(nessedata,defdir,"NesseUnbalanceData.txt")
