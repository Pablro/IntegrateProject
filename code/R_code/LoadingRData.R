#iMPORTANT NOTE: If the directories structure has changed. This file needs to be modify.
#Follow the navigational directories structure in your local machine.
#For information about assumption of default directory in R:
#the default global working directory in R is in format user/name/Documents
#you can read more about this here: https://statisticsglobe.com/change-default-working-directory-r
#Relevant Note: In this way you can access the RDATA whenever you need it.
#Loading RData
#Remember the default directory in your machines. Later processes start from this point.
defdir=getwd()


#Creating the data.
setwd(paste(defdir,"IntegrateProject/data/bv-brc-data",sep="/"))
#Original species
#Bifidobacterium longum
bifidodata<- read.table("Bifidobacterium_longum.csv",sep=",",header = T)

#Bordetella pertussis 
bordetedata<-read.table("Bordetella_pertussis.csv",sep=",",header = T)

#Proposed species
#Bacteroides fragilis
bacterodata<-read.table("Bacteroides_fragilis_data.csv",sep=",",header = T)

#Neisseria Meningiditis
nessedata<-read.table("Neisseria_meningitidis_data.csv",sep=",",header = T)

#Saving the data objects:
setwd(paste(defdir,"IntegrateProject/data/Rdata",sep="/"))
save(bifidodata,file = "Bifidobacterium.RData")
save(bordetedata,file = "Bordetella.RData")
save(bacterodata,file = "Bacteroides.RData")
save(nessedata,file = "Neisseria.RData")
