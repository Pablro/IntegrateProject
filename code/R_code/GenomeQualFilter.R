#Relevant Note: This filter has an important role in trimming the data for further analysis. Discussions regarding the optimality of the preprocessing approach can be seen in
# the analysis: QualityPreprocessingExploration.R
# Any further improvement to the data preprocessing should imply modifying this file.
#Marshall code: Part 1
library(dplyr)
#Filter for genomes which are public(can be downloaded their fasta)

#Authors filtering method
qualityFilterAuthors<- function(data,sigm){
#Calculate the median number of contigs
median_contigs <- median(data$Contigs)

#Calculate the mean and standard deviation of the number of CDS
mean_cds <- mean(data$CDS)
sd_cds <- sd(data$CDS)

#Calculate the mean and standard deviation of the size
mean_size <- mean(data$Size)
sd_size <- sd(data$Size)

#Filter the data based on the specified conditions
filtered_data <- data %>%
  filter(
    (CDS >= mean_cds - sigm * sd_cds & CDS <= mean_cds + sigm * sd_cds) &
      (Size >= mean_size - sigm * sd_size & Size <= mean_size + sigm * sd_size) &
      (Genome.Status == "Complete" |
         (Genome.Status == "WGS" & Contigs <= median_contigs * 2.5))
  )
return(filtered_data)
}
#Evaluating the effect of the 3 sigma statistical approach for trimming the data without considering the median
#This function is only used in QualityPreprocessingExploration.R
qualityFilter3Sigma<- function(data,sigm){
  #Calculate the median number of contigs
  median_contigs <- median(data$Contigs)
  
  #Calculate the mean and standard deviation of the number of CDS
  mean_cds <- mean(data$CDS)
  sd_cds <- sd(data$CDS)
  
  #Calculate the mean and standard deviation of the size
  mean_size <- mean(data$Size)
  sd_size <- sd(data$Size)
  
  #Filter the data based on the specified conditions
  filtered_data <- data %>%
    filter(
      (CDS >= mean_cds - sigm * sd_cds & CDS <= mean_cds + sigm * sd_cds) &
        (Size >= mean_size - sigm * sd_size & Size <= mean_size + sigm * sd_size) &
        (Genome.Status == "Complete" |
           (Genome.Status == "WGS"))
    )
  return(filtered_data)
}
#These methods looks to define a better statistical approach to filter based on the median.
#Following the same assumptions of normality
#Under upper limit.
#How to work under normal assumptions for a median.
#https://www.statology.org/confidence-interval-for-median/
#This is actually a binomial confidence interval based on normality assumption.
#Consulted in the book of:
#Practical Nonparametric Statistics, 3rd Edition by W.J. Conover.

qualityFilterProposed<- function(data,sigm){
  #Calculate the median number of contigs
  median_contigs <- median(data$Contigs)
  n=nrow(data)
  
  #Calculate the mean and standard deviation of the number of CDS
  mean_cds <- mean(data$CDS)
  sd_cds <- sd(data$CDS)
  
  #Calculate the mean and standard deviation of the size
  mean_size <- mean(data$Size)
  sd_size <- sd(data$Size)
  
  #Filter the data based on the specified conditions
  filtered_data <- data %>%
    filter(
      (CDS >= mean_cds - sigm * sd_cds & CDS <= mean_cds + sigm * sd_cds) &
        (Size >= mean_size - sigm * sd_size & Size <= mean_size + sigm * sd_size) &
        (Genome.Status == "Complete" |
           #based on: https://www.statology.org/confidence-interval-for-median/
           #adapted to one side confidence interval for the contigs feature.
           #2.5 as z value because is equivalent to 99% of confidence. So I am still kind of in the 3sigma rule 
           #for the three features.
           (Genome.Status == "WGS" & Contigs <=(n*0.5)+2.5*sqrt( n*0.5*(1-0.5))))
    )
  return(filtered_data)
}

