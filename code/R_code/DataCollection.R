#iMPORTANT NOTE: If the directories structure has changed. This file needs to be modify.
#Follow the navigational directories structure in your local machine.
#For information about assumption of default directory in R:
#the default global working directory in R is in format user/name/Documents
#you can read more about this here: https://statisticsglobe.com/change-default-working-directory-r
######if you parent directory/default directory does not end with ~/Documents#######
getwd()#for checking in your computer
defdir="/Users/marshall/Documents/2ndYear"
setwd(defdir)
#>>>>>>> main
#Collect the source code from respective directory on your machines.
#Assign sourdir as one child dir, remember to maker sure "IntegrateProject/code/R_code" is right after the path defdir
sourdir=paste(defdir,"IntegrateProject/code/R_code",sep="/")
# setwd to child dir where the following R files are located.
setwd(sourdir)
source("GenomeQualFilter.R")
source("SampleSelection.R")

# Moving to data directory
sourdir=paste(defdir,"IntegrateProject/data/Rdata",sep="/")
setwd(sourdir)
#Requirements:
#Verify that the data objects from the dataset exist. Otherwise
# GO to R_code and run LoadingRData.R mannually
#####Loading data#########
load("Bacteroides.Rdata")
load("Neisseria.Rdata")
#Steps for collecting the data
#Instructions
########
#Now go to /bash-input-data-directory
#transfer the above output files to you VSC account and run the bash script "missingFastas.sh" for retrieving the ids with missing fasta
#Save this output files from the bashscript into the directory where the second step of this workflow is assuming these files are located.


######2-Second step filtering Missing fastas##################
#Requirments:
#Assumes you already have the files with the ids with missing fastas generated in step 1
#Moving to the directory where these files are
sourdir=paste(defdir,"IntegrateProject/data/missing-fasta-ids",sep="/")
#First species: Bacteroides
missings1<-paste(sourdir,"bacteroMissing.txt",sep = "/")
missing_ids1 <- readLines(missings1)
missing_ids1 <- as.numeric(missing_ids1)
filtered_data1 <- bacterodata[!bacterodata$Genome.ID %in% missing_ids1, ]
# Identify duplicated Genome.IDs
duplicated_ids <- duplicated(filtered_data1$Genome.ID)
# Keep only the first occurrence of each unique Genome.ID
data_unique <- filtered_data1[!duplicated_ids, ]
new_data_file1=paste(defdir,"IntegrateProject/data/balanceData/Bacteroidefiltered.Rdata",sep="/")
save(data_unique,file = new_data_file1)
######3-Third step quality filtering and sampling##################
data1=qualityFilterProposed(data_unique,3)

#Instructions:
#Go to "bash-input-data" and transfer the above files to VSC account. Be sure to be on $VSC_DATA
#Run the shell script "sequence-script.sh" to download the fasta files
# NOW YOU ARE READY TO BUILD THE PANGENOME


#Second species: Neisseria
######2-Second step filtering Missing fastas##################
#Requirments:
#Assumes you already have the files with the ids with missing fastas generated in step 1
#Moving to the directory where these files are
sourdir=paste(defdir,"IntegrateProject/data/missing-fasta-ids",sep="/")
missings2<-paste(sourdir,"nesseMissing.txt",sep = "/")
missing_ids2 <- readLines(missings2)
missing_ids2 <- as.numeric(missing_ids2)
filtered_data2 <- nessedata[!nessedata$Genome.ID %in% missing_ids2, ]
new_data_file2 <- paste(defdir,"IntegrateProject/data/balanceData/Neisseriafiltered.Rdata",sep="/")
save(filtered_data2,file = new_data_file2)
######3-Third step quality filtering and sampling##################
data2=qualityFilterProposed(filtered_data2,3)
smallSampleSelection1(data2,defdir,"50neisseria1_fna.txt","50neisseria1_faa.txt")
smallSampleSelection2(data2,defdir,"50neisseria2_fna.txt","50neisseria2_faa.txt")
largeSampleSelection1(data2,defdir,"400neisseria1_fna.txt","400neisseria1_faa.txt")
largeSampleSelection2(data2,defdir,"400neisseria2_fna.txt","400neisseria2_faa.txt")
#Instructions:
#Go to "bash-input-data" and transfer the above files to VSC account. Be sure to be on $VSC_DATA
#Run the shell script "sequence-script.sh" to download the fasta files
# NOW YOU ARE READY TO BUILD THE PANGENOME



                