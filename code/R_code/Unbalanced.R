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

defdir="/Users/marshall/Documents/2ndYear"
load("Bacteroides.Rdata")
load("Neisseria.Rdata")

#First specie:Bacteroides
completedDatasetUnbalanceId(bacterodata,defdir,"bacteroUnbalanceData.txt")
#Second specie: Nesseria
completedDatasetUnbalanceId(nessedata,defdir,"NesseUnbalanceData.txt")