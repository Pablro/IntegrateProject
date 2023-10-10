#Relevant Note: This filter has an important role in trimming the data for further analysis. Discussions regarding optimality of the preprocessing approach can be seen in
# the analysis: QualityPreprocessingExploration.R
# Any further improvement to the optimality of the data preprocessing should imply modifying this file.
#Marshall code: Part 1
library(dplyr)
qualityFilter<- function(data,sigm){
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

