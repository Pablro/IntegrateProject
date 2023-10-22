#the default global working directory in R is in format user/name/Documents
#you can read more about this here: https://statisticsglobe.com/change-default-working-directory-r
#This should be your default directory
#This is my case, remember to update to your work directory structure
getwd() # so you can check
defdir="/Users/marshall/Documents/2ndYear"
#The directory where the source code are:
sourdir=paste(defdir,"IntegrateProject/code/R_code",sep="/")
#Collect the source code from respective directory on your machines.
setwd(sourdir)
library("dplyr")
library("car")
source("GenomeQualFilter.R")
#Loading data
setwd(defdir)
sourdir=paste(defdir,"IntegrateProject/data/Rdata",sep="/")
setwd(sourdir)
#Loading the data.
#Bacteroides fragilis
load(file="Bacteroides.RData")
#Neisseria Meningitidis
load(file="Neisseria.RData")


#Exploring the cutoffs of the quality processing of the data.
######################################
#Quality filtering for Contigs.
######################################
#Bacteroides fragilis

median1=median(bacterodata$Contigs)
median1
threshold=2.5*median1 #suggest by the authors. Why 2.5 and not 3. for example?
threshold
#what effect does the threshold has in the downstream analyis?
hist(bacterodata$Contigs)
barplot(bacterodata$Contigs,space=c(0,0)) #Does all low values contigs are okay?
index1<- rep(median1,length(bacterodata$Contigs))
index2<- rep(threshold,length(bacterodata$Contigs))
lines(index1,col="red") #median
lines(index2,col="green")# threshold

#Neisseria Meningitidis

median1=median(nessedata$Contigs)
median1
threshold=2.5*median1 #suggest by the authors. Why 2.5 and not 3. for example?
threshold
#what effect does the threshold has in the downstream analyis?
hist(nessedata$Contigs)
barplot(nessedata$Contigs,space=c(0,0)) #Does all low values contigs are okay?
index1<- rep(median1,length(nessedata$Contigs))
index2<- rep(threshold,length(nessedata$Contigs))
lines(index1,col="red") #median
lines(index2,col="green")# threshold

######################################
#Quality filtering for annotated CDS.
######################################
#Bacteroides fragilis
meanCDS=mean(bacterodata$CDS)
sd1=sd(bacterodata$CDS)
#3 sigma Rule-confidence interval
LCL=meanCDS-3*sd1
LCL
UCL=meanCDS+3*sd1
UCL
hist(bacterodata$CDS,breaks = 15)
dens=density(bacterodata$CDS)
plot(dens)
#Normality inspection
shapiro.test(bacterodata$CDS)
qqPlot(bacterodata$CDS)

#Neisseria Meningitidis
meanCDS=mean(nessedata$CDS)
sd1=sd(nessedata$CDS)
#3 sigma Rule-confidence interval
LCL=meanCDS-3*sd1
LCL
UCL=meanCDS+3*sd1
UCL
hist(nessedata$CDS,breaks = 15)
dens=density(nessedata$CDS)
plot(dens)
#Normality inspection
shapiro.test(nessedata$CDS)
qqPlot(nessedata$CDS)
######################################
#Quality filtering for total genome length.
######################################
#Bacteroides fragilis
meanSize=mean(bacterodata$Size)
sd1=sd(bacterodata$Size)
#3 sigma Rule-confidence interval
LCL=meanSize-3*sd1
LCL
UCL=meanSize+3*sd1
UCL
hist(bacterodata$Size,breaks = 15)
dens=density(bacterodata$Size)
plot(dens)
#Normality inspection
shapiro.test(bacterodata$Size)
qqPlot(bacterodata$Size)

#Neisseria Meningitidis
meanSize=mean(nessedata$Size)
sd1=sd(nessedata$Size)
#3 sigma Rule-confidence interval
LCL=meanSize-3*sd1
LCL
UCL=meanSize+3*sd1
UCL
hist(nessedata$Size,breaks = 15)
dens=density(nessedata$Size)
plot(dens)
#Normality inspection
shapiro.test(nessedata$Size)
qqPlot(nessedata$Size)

#Population structure account for normality. 
#Neisseria seems to be trimodal-anaerobic

######################
#Data cleaning effects
######################
##Bacteroides fragilis
#Postfiltering
#Data proportion compare to authors
filtered_data1<-qualityFilterAuthors(bacterodata,1)
filtered_data2<-qualityFilterAuthors(bacterodata,2)
filtered_data3<-qualityFilterAuthors(bacterodata,3)
totalnumber=nrow(bacterodata)
filtnumber1<-nrow(filtered_data1)
filtnumber2<-nrow(filtered_data2)
filtnumber3<-nrow(filtered_data3)
prop1<-filtnumber1/totalnumber
prop2<-filtnumber2/totalnumber
prop3<-filtnumber3/totalnumber
bacteropropmatrix.row1<-c(prop1,prop2,prop3)
#Data proportion contain compare to 68-95-99 rule (1sig,2sig,3sig)-that should follow a normal distribution
filtered_data4<-qualityFilter3Sigma(bacterodata,1)
filtered_data5<-qualityFilter3Sigma(bacterodata,2)
filtered_data6<-qualityFilter3Sigma(bacterodata,3)
filtnumber4<-nrow(filtered_data4)
filtnumber5<-nrow(filtered_data5)
filtnumber6<-nrow(filtered_data6)
prop4<-filtnumber4/totalnumber
prop5<-filtnumber5/totalnumber
prop6<-filtnumber6/totalnumber
bacteropropmatrix.row2<-c(prop4,prop5,prop6)
#Data proportion for proposed median correction
#The media proposed by the authors is quite ambiguous as it seems
#either random or empirical but not statistical based for which I search.
filtered_data7<-qualityFilterProposed(bacterodata,1)
filtered_data8<-qualityFilterProposed(bacterodata,2)
filtered_data9<-qualityFilterProposed(bacterodata,3)
filtnumber7<-nrow(filtered_data7)
filtnumber8<-nrow(filtered_data8)
filtnumber9<-nrow(filtered_data9)
prop7<-filtnumber7/totalnumber
prop8<-filtnumber8/totalnumber
prop9<-filtnumber9/totalnumber
bacteropropmatrix.row3<-c(prop7,prop8,prop9)
#Final matrix
bacteropropmatrix<-rbind(bacteropropmatrix.row1,bacteropropmatrix.row2,bacteropropmatrix.row3)
colnames(bacteropropmatrix)<-c("1*sigma","2*sigma","3*sigma")
rownames(bacteropropmatrix)<-c("AuthorsContigMedian_trimming","SigmaTrimming_NoConigTrim","Proposed_contigMedian_trimming")
#How much data/genomes the filtering conserves for this species after filtering for each method
bacteropropmatrix

#Neisseria Meningitidis
#Postfiltering
#Data proportion compare to authors
filtered_data1<-qualityFilterAuthors(nessedata,1)
filtered_data2<-qualityFilterAuthors(nessedata,2)
filtered_data3<-qualityFilterAuthors(nessedata,3)
totalnumber=nrow(nessedata)
filtnumber1<-nrow(filtered_data1)
filtnumber2<-nrow(filtered_data2)
filtnumber3<-nrow(filtered_data3)
prop1<-filtnumber1/totalnumber
prop2<-filtnumber2/totalnumber
prop3<-filtnumber3/totalnumber
nessepropmatrix.row1<-c(prop1,prop2,prop3)
#Data proportion contain compare to 68-95-99 rule (1sig,2sig,3sig)-that should follow a normal distribution
filtered_data4<-qualityFilter3Sigma(nessedata,1)
filtered_data5<-qualityFilter3Sigma(nessedata,2)
filtered_data6<-qualityFilter3Sigma(nessedata,3)
filtnumber4<-nrow(filtered_data4)
filtnumber5<-nrow(filtered_data5)
filtnumber6<-nrow(filtered_data6)
prop4<-filtnumber4/totalnumber
prop5<-filtnumber5/totalnumber
prop6<-filtnumber6/totalnumber
nessepropmatrix.row2<-c(prop4,prop5,prop6)
#Data proportion for proposed median correction
#The media proposed by the authors is quite ambigous as it seems
#either random or empirical but not statistical based for which I search.
filtered_data7<-qualityFilterProposed(nessedata,1)
filtered_data8<-qualityFilterProposed(nessedata,2)
filtered_data9<-qualityFilterProposed(nessedata,3)
filtnumber7<-nrow(filtered_data7)
filtnumber8<-nrow(filtered_data8)
filtnumber9<-nrow(filtered_data9)
prop7<-filtnumber7/totalnumber
prop8<-filtnumber8/totalnumber
prop9<-filtnumber9/totalnumber
nessepropmatrix.row3<-c(prop7,prop8,prop9)
#Final matrix
nessepropmatrix<-rbind(nessepropmatrix.row1,nessepropmatrix.row2,nessepropmatrix.row3)
colnames(nessepropmatrix)<-c("1*sigma","2*sigma","3*sigma")
rownames(nessepropmatrix)<-c("AuthorsContigMedian_trimming","SigmaTrimming_NoConigTrim","Proposed_contigMedian_trimming")
#How much data/genomes the filtering conserves for this species after filtering for each method
nessepropmatrix

#####
#So in general more genome information is gain with the proposed method based on the assumtpion of normality.
#rather than using the author default contig median trimming method.
####
# What is the visual difference?
par(mfcol=c(1,1))
#Bacteroides fragilis
median1=median(bacterodata$Contigs)
authorthreshold=2.5*median1 #suggest by the authors. Why 2.5 and not 3. for example?
n1=nrow(bacterodata)
#as you can see the value 2.5 is preserved as z value but the equation change according to the reference:
#https://www.statology.org/confidence-interval-for-median/
#in this way we still assume the orginal normal distribution for the median.
#Adapted to be upper bound only-one sided
#around 99 confidence interval-still author value is used
proposedthreshold=(n1*0.5)+2.5*sqrt( n1*0.5*(1-0.5))
#what effect does the threshold has in the downstream analyis?
barplot(bacterodata$Contigs,space=c(0,0)) #Does all low values contigs are okay? probably yes, depending in the sequencing technology used
index<- rep(median1,length(bacterodata$Contigs))
index2<- rep(authorthreshold,length(bacterodata$Contigs))
index3<- rep(proposedthreshold,length(bacterodata$Contigs))
lines(index,col="red") #median
lines(index2,col="green") #threshold author
lines(index3,col="blue") #threshold proposed
legend(x = "topright",legend = c("median", "Author threshold","proposed threshold"),lty = c(1,1,1),col = c("red","green","blue"),lwd = 0.5,cex=0.5)

#Neisseria Meningiditis

median1=median(nessedata$Contigs)
authorthreshold=2.5*median1 #suggest by the authors. Why 2.5 and not 3. for example?
authorthreshold
n1=nrow(nessedata)
#as you can see the value 2.5 is preserved as z value but the equation change according to the reference:
#https://www.statology.org/confidence-interval-for-median/
#in this way we still assume the orginal normal distribution for the median.
#Adapted to be upper bound only-one sided
#around 99 confidence interval-still author value is used
proposedthreshold=(n1*0.5)+2.5*sqrt( n1*0.5*(1-0.5))
proposedthreshold
#what effect does the threshold has in the downstream analyis?
barplot(nessedata$Contigs,space = c(0,0),ylim=c(0,1500)) #Does all low values contigs are okay? Yes
index<- rep(median1,length(nessedata$Contigs))
index2<- rep(authorthreshold,length(nessedata$Contigs))
index3<- rep(proposedthreshold,length(nessedata$Contigs))
lines(index,col="red") #median
lines(index2,col="green") #threshold author
lines(index3,col="blue") #threshold proposed
legend(x = "topright",legend = c("median", "Author threshold","proposed threshold"),lty = c(1,1,1),col = c("red","green","blue"),lwd = 0.5,cex=0.3)
#This seems to be very large threshold but at least it preserve the genome information rather that trimming incorrectly.

#Conclusion:
#Population structure is imporant to assess the best trimming strategy. Because of the normality assumption in the used methods.
#The proposed method account better for the normality assumption and trims better the data. It seens to be like a robust statistic.
# yet if normality assumption is the best way to preprocess the data is still dubious as previously shown. Choosing a logical statistical approach matters
#for the preprocessing
#Authors contigs filter does not seem to have a logical statistical based approach rather empirical or random approach.
#This affect the proportion of genomes that is preserved for downstream analysis.
# Having a large threshold might not be wrong but further analysis and proves would need to be shown. For example,
#In general and based in this observations using the proposed  preprocessing method might be a tentative option rather than using the authors method which was based in his species.
#And we see how species distribution has a significant impact in the preprocessing filtering for further downstream analysis.
#Also the proposed method is still build under normality assumptions. But it improve the authors contigs filter because it seems quite ambigous.
# A unsuitable cutoff value means loosing valuable information (genomes) for further downstream analysis. How to account for good genomes selection
# is still a prevailing question because we need to account for the population structure or the data distribution and the possible hidden biological concepts behind it.