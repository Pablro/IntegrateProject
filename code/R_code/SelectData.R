library(dplyr)
data <- read.csv("/Users/marshall/Documents/2ndYear/Integrated_Bio_Project/dataset/Bifidobacterium_longum.csv") 

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
    (CDS >= mean_cds - 3 * sd_cds & CDS <= mean_cds + 3 * sd_cds) &
      (Size >= mean_size - 3 * sd_size & Size <= mean_size + 3 * sd_size) &
      (Genome.Status == "Complete" |
         (Genome.Status == "WGS" & Contigs <= median_contigs * 2.5))
  )

filtered_data <- filtered_data[, "Genome.ID", drop = FALSE]
head(filtered_data)
# Randomly select 50 observations
set.seed(123)
random_sample <- filtered_data[sample(nrow(filtered_data), 50), ]
random_sample
write.table(random_sample, file = "/Users/marshall/Documents/2ndYear/Integrated_Bio_Project/dataset/random_sample.txt", col.names = FALSE, row.names=FALSE,sep = "\t")

