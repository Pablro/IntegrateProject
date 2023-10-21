#iMPORTANT NOTE: If the directories structure has changed. This file needs to be modify.
#Follow the navigational directories structure in your local machine.
#For information about assumption of default directory in R:
#the default global working directory in R is in format user/name/Documents
#you can read more about this here: https://statisticsglobe.com/change-default-working-directory-r
#Remember the default directory in your machines. Later processes start from this point.
#<<<<<<< pablosImplementations
#<<<<<<< Updated upstream
defdir=getwd()
#The directory where th source code are:
#=======
getwd()
######if you parent directory/default directory does not end with ~/Documents#######
#Copy the previous result to the setwd() augrement like next line for example
setwd("/Users/marshall/Documents/2ndYear")
#Then we set the current working dir to "/Users/marshall/Documents/2ndYear" in my case and assign this to defdir as parent dir
defdir=getwd()
########################################
#Collect the source code from respective directory on your machines.
#Assign sourdir as one child dir, remember to maker sure "IntegrateProject/code/R_code" is right after the path defidr
#>>>>>>> Stashed changes
sourdir=paste(defdir,"IntegrateProject/code/R_code",sep="/")
=======
getwd()
#Copy the previous result to the setwd() augrement like next line for example
setwd("/Users/marshall/Documents/2ndYear")
#Then we set the current working dir to "/Users/marshall/Documents/2ndYear" in my case and assign this to defdir as parent dir
defdir=getwd()
#>>>>>>> main
#Collect the source code from respective directory on your machines.
#Assign sourdir as one child dir, remember to maker sure "IntegrateProject/code/R_code" is right after the path defidr
sourdir=paste(defdir,"IntegrateProject/code/R_code",sep="/")
# setwd to child dir to make sure source() functions work
setwd(sourdir)
source("GenomeQualFilter.R")
source("SampleSelection.R")

#Marshall Code. Generate a sample file that ca be further used for retrieving data via bash script in the VSC cluster.
# set correct current working dir
setwd(paste(defdir,"IntegrateProject/data/Rdata",sep="/"))
#<<<<<<< Updated upstream
#Bordetella Example
getwd()
# GO to R_code and run LoadingRData.R mannually 
load("Bordetella.RData")
data1=qualityFilterAuthors(bordetedata,3)
smallSampleSelection(data1,defdir,"50sample.txt")
largeSampleSelection(data1,defdir,"500sample.txt")
#=======
getwd()
#First species: Bacteroides
# GO to R_code and run LoadingRData.R mannually 
load("Bacteroides.Rdata")
data1=qualityFilterProposed(bacterodata,3)
smallSampleSelection(data1,defdir,"50bacterosample.txt")
largeSampleSelection(data1,defdir,"500bacterosample.txt")

#Second species: Neisseria
# GO to R_code and run LoadingRData.R mannually 
load("Neisseria.Rdata")
data2=qualityFilterProposed(nessedata,3)
smallSampleSelection(data2,defdir,"50nessesample.txt")
largeSampleSelection(data2,defdir,"500nessesample.txt")



                