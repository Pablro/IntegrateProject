#iMPORTANT NOTE: If the directory structure has changed. This file needs to be modified.
#Follow the navigational directories structure in your local machine.
#For information about the assumption of the default directory in R:
#the default global working directory in R is in format user/name/Documents
#you can read more about this here: https://statisticsglobe.com/change-default-working-directory-r
#Relevant Note: In this way, you can access the RDATA whenever you need it.


#This should be your default directory
#This is my case, remember to update to your work directory structure
getwd() # so you can check
defdir="/Users/marshall/Documents/2ndYear"

#Directory where csv file should be
setwd(paste(defdir,"IntegrateProject/data/bv-brc-data",sep="/"))

#This file creates the RData objects from csv files
#Loading CSV files
#Bacteroides fragilis
bacterodata<-read.table("Bacteroides_fragilis_data.csv",sep=",",header = T)

#Neisseria Meningitidis
nessedata<-read.table("Neisseria_meningitidis_data.csv",sep=",",header = T)

#Saving the data objects:
setwd(paste(defdir,"IntegrateProject/data/Rdata",sep="/"))
save(bacterodata,file = "Bacteroides.RData")
save(nessedata,file = "Neisseria.RData")
