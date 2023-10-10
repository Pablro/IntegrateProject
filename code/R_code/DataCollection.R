#iMPORTANT NOTE: If the directories structure has changed. This file needs to be modify.
#Follow the navigational directories structure in your local machine.
#For information about assumption of default directory in R:
#the default global working directory in R is in format user/name/Documents
#you can read more about this here: https://statisticsglobe.com/change-default-working-directory-r
#Remember the default directory in your machines. Later processes start from this point.
defdir=getwd()
#The directory where th source code are:
sourdir=paste(defdir,"IntegrateProject/code/R_code",sep="/")
#Collect the source code from respective directory on your machines.
setwd(sourdir)
source("GenomeQualFilter.R")
source("SampleSelection.R")

#Marshall Code. Generate a sample file that ca be further used for retrieving data via bash script in the VSC cluster.
setwd(paste(defdir,"IntegrateProject/data/Rdata",sep="/"))
#Bordetella Example
data1=qualityFilter(bordetedata,3)
smallSampleSelection(data1,defdir,"50sample.txt")
largeSampleSelection(data1,defdir,"700sample.txt")
                