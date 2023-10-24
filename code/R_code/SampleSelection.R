#iMPORTANT NOTE: If the directories structure has changed. This file needs to be modify.
#Follow the navigational directories structure in your local machine.
#For information about assumption of default directory in R:
#the default global working directory in R is in format user/name/Documents
#you can read more about this here: https://statisticsglobe.com/change-default-working-directory-r
#Relevant Note: For the sample size sampling design, this file should be modify.
#For modifying the sample input format that goes to the bash script for the Data download or the bash script of missing fastas, this file should also need 
#to be modify.

#Marshall Code part 2
#Small Dataset sampling method- Sample 1
#parameters:
#filtered data previously generated
#working direcctory- default working directory.
#filename- the user specifies the file names.
smallSampleSelection1<-function(filtered_data,working_directory,filename){
  set.seed(123)
  setwd(working_directory)
  # Randomly select 50 observations
  filtered_data<-filtered_data[, "Genome.ID", drop = FALSE]
  small_random_sample <- filtered_data[sample(nrow(filtered_data), 50), ]
  for (i in 1:length(small_random_sample)){
    small_random_sample[i]=paste(paste(paste("ftp://ftp.bvbrc.org/genomes",small_random_sample[i],sep="/"),small_random_sample[i],sep="/"),"fna",sep = ".")
  }
  write.table(small_random_sample, file = paste(getwd(),paste("IntegrateProject/data/bash-input-data",filename,sep = "/"),sep = "/"), col.names = FALSE, row.names=FALSE,sep = "\t")
}
#Small Dataset sampling method-Sample 2
#parameters:
#filtered data previously generated
#working direcctory- default working directory.
#filename- the user specifies the file names.
smallSampleSelection2<-function(filtered_data,working_directory,filename){
  set.seed(456)
  setwd(working_directory)
  # Randomly select 50 observations
  filtered_data<-filtered_data[, "Genome.ID", drop = FALSE]
  small_random_sample <- filtered_data[sample(nrow(filtered_data), 50), ]
  for (i in 1:length(small_random_sample)){
    small_random_sample[i]=paste(paste(paste("ftp://ftp.bvbrc.org/genomes",small_random_sample[i],sep="/"),small_random_sample[i],sep="/"),"fna",sep = ".")
  }
  write.table(small_random_sample, file = paste(getwd(),paste("IntegrateProject/data/bash-input-data",filename,sep = "/"),sep = "/"), col.names = FALSE, row.names=FALSE,sep = "\t")
}
#Large Dataset sampling method-sample 1
#Note: If sample size  it is too large an  error will occur. The possibility of decreasing the size
#of the large data set is relevant. 
#parameters:
#filtered data previously generated
#working direcctory- default working directory.
#filename- the user specifies the file names.
largeSampleSelection1<-function(filtered_data,working_directory,filename){
  setwd(working_directory)
  set.seed(23)
  # Randomly select 400 observations
  filtered_data<-filtered_data[, "Genome.ID", drop = FALSE]
  large_random_sample <- filtered_data[sample(nrow(filtered_data), 400), ]
  for (i in 1:length(large_random_sample)){
    large_random_sample[i]=paste(paste(paste("ftp://ftp.bvbrc.org/genomes",large_random_sample[i],sep="/"),large_random_sample[i],sep="/"),"fna",sep = ".")
  }
  write.table(large_random_sample, file = paste(getwd(),paste("IntegrateProject/data/bash-input-data",filename,sep = "/"),sep = "/"), col.names = FALSE, row.names=FALSE,sep = "\t")
}
#Large Dataset sampling method-sample 2
#Note: If sample size  it is too large an  error will occur. The possibility of decreasing the size
#of the large data set is relevant. 
#parameters:
#filtered data previously generated
#working direcctory- default working directory.
#filename- the user specifies the file names.
largeSampleSelection2<-function(filtered_data,working_directory,filename){
  setwd(working_directory)
  set.seed(55)
  # Randomly select 400 observations
  filtered_data<-filtered_data[, "Genome.ID", drop = FALSE]
  large_random_sample <- filtered_data[sample(nrow(filtered_data), 400), ]
  for (i in 1:length(large_random_sample)){
    large_random_sample[i]=paste(paste(paste("ftp://ftp.bvbrc.org/genomes",large_random_sample[i],sep="/"),large_random_sample[i],sep="/"),"fna",sep = ".")
  }
  write.table(large_random_sample, file = paste(getwd(),paste("IntegrateProject/data/bash-input-data",filename,sep = "/"),sep = "/"), col.names = FALSE, row.names=FALSE,sep = "\t")
}
