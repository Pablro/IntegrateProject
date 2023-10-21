#iMPORTANT NOTE: If the directory structure has changed. This file needs to be modified.
#Follow the navigational directories structure in your local machine.
#For information about the assumption of the default directory in R:
#the default global working directory in R is in format user/name/Documents
#you can read more about this here: https://statisticsglobe.com/change-default-working-directory-r
#Relevant Note: In this way, you can access the RDATA whenever you need it.

# This file creates the RData objects from csv files

#Loading RData
#Remember the default directory in your machines. Later processes start from this point.
defdir=getwd()

#Creating the data.
setwd(paste(defdir,"IntegrateProject/data/bv-brc-data",sep="/"))

#Loading CSV files
#Bacteroides fragilis
bacterodata<-read.table("Bacteroides_fragilis_data.csv",sep=",",header = T)

#Neisseria Meningitidis
nessedata<-read.table("Neisseria_meningitidis_data.csv",sep=",",header = T)

#Saving the data objects:
setwd(paste(defdir,"IntegrateProject/data/Rdata",sep="/"))
save(bacterodata,file = "Bacteroides.RData")
save(nessedata,file = "Neisseria.RData")
