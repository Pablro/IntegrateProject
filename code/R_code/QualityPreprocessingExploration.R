#the default global working directory in R is in format user/name/Documents
#you can read more about this here: https://statisticsglobe.com/change-default-working-directory-r
#Remember the default directory in your machines. Later processes start from this point.
defdir=getwd()
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
#Creating the data.
#Original species
#Bifidobacterium longum
load(file="Bifidobacterium.RData")
#Bordetella pertussis
load(file="Bordetella.RData")
#Proposed species
#Bacteroides fragilis
load(file="Bacteroides.RData")
#Neisseria Meningiditis
load(file="Neisseria.RData")


#Exploring the cutoffs of the quality processing of the data.
######################################
#Quality filtering for Contigs.
######################################

#Bifidobacterium longum

median1=median(bifidodata$Contigs)
median1
threshold1=2.5*median1 #suggest by the authors. Why 2.5 and not 3. for example?
threshold1
#what effect does the threshold has in the downstream analyis?
hist(bifidodata$Contigs)
barplot(bifidodata$Contigs,space=c(0,0)) #Does all low values contigs are okay?
index<- rep(median1,length(bifidodata$Contigs))
index2<- rep(threshold1,length(bifidodata$Contigs))
lines(index,col="red") #median
lines(index2,col="green") #threshold

#Bordetella pertussis

#Does the median would be a good approach for this case? 
#Indeed the dataset contains many values of 1 for the contigs column.
#Hence the question about low values is interesting for this case.
median2=median(bordetedata$Contigs)
median2
threshold2=2.5*median2 #suggest by the authors. Why 2.5 and not 3. for example?
threshold2
#what effect does the threshold has in the downstream analyis?
hist(bordetedata$Contigs)
barplot(bordetedata$Contigs,space=c(0,0)) #Does all low values contigs are okay?
index3<- rep(median2,length(bordetedata$Contigs))
index4<- rep(threshold2,length(bordetedata$Contigs))
lines(index3,col="red") #median
lines(index4,col="green")# threshold

#Bacteroides fragilis

median3=median(bacterodata$Contigs)
median3
threshold3=2.5*median3 #suggest by the authors. Why 2.5 and not 3. for example?
threshold3
#what effect does the threshold has in the downstream analyis?
hist(bacterodata$Contigs)
barplot(bacterodata$Contigs,space=c(0,0)) #Does all low values contigs are okay?
index5<- rep(median3,length(bacterodata$Contigs))
index6<- rep(threshold3,length(bacterodata$Contigs))
lines(index5,col="red") #median
lines(index6,col="green")# threshold

#Neisseria Meningiditis

median4=median(nessedata$Contigs)
median4
threshold4=2.5*median4 #suggest by the authors. Why 2.5 and not 3. for example?
threshold4
#what effect does the threshold has in the downstream analyis?
hist(nessedata$Contigs)
barplot(nessedata$Contigs,space=c(0,0)) #Does all low values contigs are okay?
index7<- rep(median4,length(nessedata$Contigs))
index8<- rep(threshold4,length(nessedata$Contigs))
lines(index7,col="red") #median
lines(index8,col="green")# threshold

######################################
#Quality filtering for annotated CDS.
######################################
#Bifidobacterium longum
meanCDS1=mean(bifidodata$CDS)
sd1=sd(bifidodata$CDS)
#3 sigma Rule-confidence interval
LCL1=meanCDS1-3*sd1
LCL1
UCL1=meanCDS1+3*sd1
UCL1
hist(bifidodata$CDS,breaks = 15)
dens1=density(bifidodata$CDS)
plot(dens1)
#Normality inspection
shapiro.test(bifidodata$CDS)
qqPlot(bifidodata$CDS)
#There is an outlier here. must probably needs to be clean.

#Bordetella pertussis

meanCDS2=mean(bordetedata$CDS)
sd2=sd(bordetedata$CDS)
#3 sigma Rule-confidence interval
LCL2=meanCDS2-3*sd2
LCL2
UCL2=meanCDS2+3*sd2
UCL2
hist(bordetedata$CDS,breaks = 15)
dens2=density(bordetedata$CDS)
plot(dens2)
#Normality inspection
shapiro.test(bordetedata$CDS)
qqPlot(bordetedata$CDS)
#There is 2 an outlier here. must probably needs to be clean.

#Bacteroides fragilis
meanCDS3=mean(bacterodata$CDS)
sd3=sd(bacterodata$CDS)
#3 sigma Rule-confidence interval
LCL3=meanCDS3-3*sd3
LCL3
UCL3=meanCDS3+3*sd3
UCL3
hist(bacterodata$CDS,breaks = 15)
dens3=density(bacterodata$CDS)
plot(dens3)
#Normality inspection
shapiro.test(bacterodata$CDS)
qqPlot(bacterodata$CDS)

#Neisseria Meningiditis
meanCDS4=mean(nessedata$CDS)
sd4=sd(nessedata$CDS)
#3 sigma Rule-confidence interval
LCL4=meanCDS4-3*sd4
LCL4
UCL4=meanCDS4+3*sd4
UCL4
hist(nessedata$CDS,breaks = 15)
dens4=density(nessedata$CDS)
plot(dens4)
#Normality inspection
shapiro.test(nessedata$CDS)
qqPlot(nessedata$CDS)
######################################
#Quality filtering for total genome length.
######################################
#Bifidobacterium longum
meanSize1=mean(bifidodata$Size)
sd5=sd(bifidodata$Size)
#3 sigma Rule-confidence interval
LCL5=meanSize1-3*sd5
LCL5
UCL5=meanSize1+3*sd5
UCL5
hist(bifidodata$Size,breaks = 15)
dens5=density(bifidodata$Size)
plot(dens5)
#Normality inspection
shapiro.test(bifidodata$Size)
qqPlot(bifidodata$Size)
#There is an outlier here. must probably needs to be clean.

#Bordetella pertussis

meanSize2=mean(bordetedata$Size)
sd6=sd(bordetedata$Size)
#3 sigma Rule-confidence interval
LCL6=meanSize2-3*sd6
LCL6
UCL6=meanSize2+3*sd6
UCL6
hist(bordetedata$Size,breaks = 15)
dens6=density(bordetedata$Size)
plot(dens6)
#Normality inspection
shapiro.test(bordetedata$Size)
qqPlot(bordetedata$Size)
#There is 2 an outlier here. must probably needs to be clean.

#Bacteroides fragilis
meanSize3=mean(bacterodata$Size)
sd7=sd(bacterodata$Size)
#3 sigma Rule-confidence interval
LCL7=meanSize3-3*sd7
LCL7
UCL7=meanSize3+3*sd7
UCL7
hist(bacterodata$Size,breaks = 15)
dens7=density(bacterodata$Size)
plot(dens7)
#Normality inspection
shapiro.test(bacterodata$Size)
qqPlot(bacterodata$Size)

#Neisseria Meningiditis
meanSize4=mean(nessedata$Size)
sd8=sd(nessedata$Size)
#3 sigma Rule-confidence interval
LCL8=meanSize4-3*sd8
LCL8
UCL8=meanSize4+3*sd8
UCL8
hist(nessedata$Size,breaks = 15)
dens8=density(nessedata$Size)
plot(dens8)
#Normality inspection
shapiro.test(nessedata$Size)
qqPlot(nessedata$Size)

#Population structure account for normality. 
#Neisseria seems to be trimodal-anaerobic
#Bardotella Bimodal-anaeorbic


######################
#Data cleaning effects
######################
#Bifidobacterium longum
#Postfiltering
#Data proportion compare to authors
filtered_data1<-qualityFilterAuthors(bifidodata,1)
filtered_data2<-qualityFilterAuthors(bifidodata,2)
filtered_data3<-qualityFilterAuthors(bifidodata,3)
totalnumber=nrow(bifidodata)
filtnumber1<-nrow(filtered_data1)
filtnumber2<-nrow(filtered_data2)
filtnumber3<-nrow(filtered_data3)
prop1<-filtnumber1/totalnumber
prop2<-filtnumber2/totalnumber
prop3<-filtnumber3/totalnumber
bifidopropmatrix.row1<-c(prop1,prop2,prop3)
#Data proportion contain compare to 68-95-99 rule (1sig,2sig,3sig)-that should follow a normal distribution
filtered_data4<-qualityFilter3Sigma(bifidodata,1)
filtered_data5<-qualityFilter3Sigma(bifidodata,2)
filtered_data6<-qualityFilter3Sigma(bifidodata,3)
filtnumber4<-nrow(filtered_data4)
filtnumber5<-nrow(filtered_data5)
filtnumber6<-nrow(filtered_data6)
prop4<-filtnumber4/totalnumber
prop5<-filtnumber5/totalnumber
prop6<-filtnumber6/totalnumber
bifidopropmatrix.row2<-c(prop4,prop5,prop6)
#Data proportion for proposed median correction
#The media proposed by the authors is quite ambigous as it seems
#either random or empirical but not statistical based for which I search.
filtered_data7<-qualityFilterProposed(bifidodata,1)
filtered_data8<-qualityFilterProposed(bifidodata,2)
filtered_data9<-qualityFilterProposed(bifidodata,3)
filtnumber7<-nrow(filtered_data7)
filtnumber8<-nrow(filtered_data8)
filtnumber9<-nrow(filtered_data9)
prop7<-filtnumber7/totalnumber
prop8<-filtnumber8/totalnumber
prop9<-filtnumber9/totalnumber
bifidopropmatrix.row3<-c(prop7,prop8,prop9)
#Final matrix
bifidopropmatrix<-rbind(bifidopropmatrix.row1,bifidopropmatrix.row2,bifidopropmatrix.row3)
colnames(bifidopropmatrix)<-c("1*sigma","2*sigma","3*sigma")
rownames(bifidopropmatrix)<-c("AuthorsContigMedian_trimming","SigmaTrimming_NoConigTrim","Proposed_contigMedian_trimming")
#How much data/genomes the filtering conserves for this species after filtering for each method
bifidopropmatrix
#Bordetella pertussis
#Postfiltering
#Data proportion compare to authors
filtered_data1<-qualityFilterAuthors(bordetedata,1)
filtered_data2<-qualityFilterAuthors(bordetedata,2)
filtered_data3<-qualityFilterAuthors(bordetedata,3)
totalnumber=nrow(bordetedata)
filtnumber1<-nrow(filtered_data1)
filtnumber2<-nrow(filtered_data2)
filtnumber3<-nrow(filtered_data3)
prop1<-filtnumber1/totalnumber
prop2<-filtnumber2/totalnumber
prop3<-filtnumber3/totalnumber
bordetepropmatrix.row1<-c(prop1,prop2,prop3)
#Data proportion contain compare to 68-95-99 rule (1sig,2sig,3sig)-that should follow a normal distribution
filtered_data4<-qualityFilter3Sigma(bordetedata,1)
filtered_data5<-qualityFilter3Sigma(bordetedata,2)
filtered_data6<-qualityFilter3Sigma(bordetedata,3)
filtnumber4<-nrow(filtered_data4)
filtnumber5<-nrow(filtered_data5)
filtnumber6<-nrow(filtered_data6)
prop4<-filtnumber4/totalnumber
prop5<-filtnumber5/totalnumber
prop6<-filtnumber6/totalnumber
bordetepropmatrix.row2<-c(prop4,prop5,prop6)
#Data proportion for proposed median correction
#The media proposed by the authors is quite ambigous as it seems
#either random or empirical but not statistical based for which I search.
filtered_data7<-qualityFilterProposed(bordetedata,1)
filtered_data8<-qualityFilterProposed(bordetedata,2)
filtered_data9<-qualityFilterProposed(bordetedata,3)
filtnumber7<-nrow(filtered_data7)
filtnumber8<-nrow(filtered_data8)
filtnumber9<-nrow(filtered_data9)
prop7<-filtnumber7/totalnumber
prop8<-filtnumber8/totalnumber
prop9<-filtnumber9/totalnumber
bordetepropmatrix.row3<-c(prop7,prop8,prop9)
#Final matrix
bordetepropmatrix<-rbind(bordetepropmatrix.row1,bordetepropmatrix.row2,bordetepropmatrix.row3)
colnames(bordetepropmatrix)<-c("1*sigma","2*sigma","3*sigma")
rownames(bordetepropmatrix)<-c("AuthorsContigMedian_trimming","SigmaTrimming_NoConigTrim","Proposed_contigMedian_trimming")
#How much data/genomes the filtering conserves for this species after filtering for each method
bordetepropmatrix

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

#Neisseria Meningiditis
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
#Bifidobacterium longum
median1=median(bifidodata$Contigs)
authorthreshold1=2.5*median1 #suggest by the authors. Why 2.5 and not 3. for example?
n1=nrow(bifidodata)
#as you can see the value 2.5 is preserved as z value but the equation change according to the reference:
#https://www.statology.org/confidence-interval-for-median/
#in this way we still assume the orginal normal distribution for the median.
#Adapted to be upper bound only-one sided
#around 99 confidence interval-still author value is used
proposedthreshold1=(n1*0.5)+2.5*sqrt( n1*0.5*(1-0.5))
#what effect does the threshold has in the downstream analyis?
barplot(bifidodata$Contigs,space=c(0,0)) #Does all low values contigs are okay? probably yes, depending in the sequencing technology used
index<- rep(median1,length(bifidodata$Contigs))
index2<- rep(authorthreshold1,length(bifidodata$Contigs))
index3<- rep(proposedthreshold1,length(bifidodata$Contigs))
lines(index,col="red") #median
lines(index2,col="green") #threshold author
lines(index3,col="blue") #threshold proposed
legend(x = "topleft",legend = c("median", "Author threshold","proposed threshold"),lty = c(1,1,1),col = c("red","green","blue"),lwd = 0.5,cex=0.5)
#Bordetella pertussis
median2=median(bordetedata$Contigs)
authorthreshold2=2.5*median2 #suggest by the authors. Why 2.5 and not 3. for example?
n2=nrow(bordetedata)
#as you can see the value 2.5 is preserved as z value but the equation change according to the reference:
#https://www.statology.org/confidence-interval-for-median/
#in this way we still assume the orginal normal distribution for the median.
#Adapted to be upper bound only-one sided
#around 99 confidence interval-still author value is used
proposedthreshold2=(n2*0.5)+2.5*sqrt( n2*0.5*(1-0.5))
#what effect does the threshold has in the downstream analyis?
barplot(bordetedata$Contigs,space=c(0,0)) #Does all low values contigs are okay? probably yes, depending in the sequencing technology used
index<- rep(median2,length(bordetedata$Contigs))
index2<- rep(authorthreshold2,length(bordetedata$Contigs))
index3<- rep(proposedthreshold2,length(bordetedata$Contigs))
#Why is 1? because possibly the sequencing technique nanopore. more reads by other techniques should be discarded?
lines(index,col="red") #median
lines(index2,col="green") #threshold author
#More reasonable to consider other genomes obtain by other techniques.
lines(index3,col="blue") #threshold proposed
legend(x = "topleft",legend = c("median", "Author threshold","proposed threshold"),lty = c(1,1,1),col = c("red","green","blue"),lwd = 0.5,cex=0.5)

#Bacteroides fragilis
median3=median(bacterodata$Contigs)
authorthreshold3=2.5*median3 #suggest by the authors. Why 2.5 and not 3. for example?
n3=nrow(bacterodata)
#as you can see the value 2.5 is preserved as z value but the equation change according to the reference:
#https://www.statology.org/confidence-interval-for-median/
#in this way we still assume the orginal normal distribution for the median.
#Adapted to be upper bound only-one sided
#around 99 confidence interval-still author value is used
proposedthreshold3=(n3*0.5)+2.5*sqrt( n3*0.5*(1-0.5))
#what effect does the threshold has in the downstream analyis?
barplot(bacterodata$Contigs,space=c(0,0)) #Does all low values contigs are okay? probably yes, depending in the sequencing technology used
index<- rep(median3,length(bacterodata$Contigs))
index2<- rep(authorthreshold3,length(bacterodata$Contigs))
index3<- rep(proposedthreshold3,length(bacterodata$Contigs))
lines(index,col="red") #median
lines(index2,col="green") #threshold author
lines(index3,col="blue") #threshold proposed
legend(x = "topright",legend = c("median", "Author threshold","proposed threshold"),lty = c(1,1,1),col = c("red","green","blue"),lwd = 0.5,cex=0.5)

#Neisseria Meningiditis

median4=median(nessedata$Contigs)
authorthreshold4=2.5*median4 #suggest by the authors. Why 2.5 and not 3. for example?
authorthreshold4
n4=nrow(nessedata)
#as you can see the value 2.5 is preserved as z value but the equation change according to the reference:
#https://www.statology.org/confidence-interval-for-median/
#in this way we still assume the orginal normal distribution for the median.
#Adapted to be upper bound only-one sided
#around 99 confidence interval-still author value is used
proposedthreshold4=(n4*0.5)+2.5*sqrt( n4*0.5*(1-0.5))
proposedthreshold4
#what effect does the threshold has in the downstream analyis?
barplot(nessedata$Contigs,space = c(0,0),ylim=c(0,1500)) #Does all low values contigs are okay? probably yes, depending in the sequencing technology used
index<- rep(median4,length(nessedata$Contigs))
index2<- rep(authorthreshold4,length(nessedata$Contigs))
index3<- rep(proposedthreshold4,length(nessedata$Contigs))
lines(index,col="red") #median
lines(index2,col="green") #threshold author
lines(index3,col="blue") #threshold proposed
legend(x = "topright",legend = c("median", "Author threshold","proposed threshold"),lty = c(1,1,1),col = c("red","green","blue"),lwd = 0.5,cex=0.3)
#This seems to be very large threshold but at least it preserve the genome information rather that trimming incorrectly like in the bordetella case.

#Conclusion:
#Population structure is imporant to asses the best trimming strategy. Because of the normality assumption in the used methods.
#The proposed method account better for the normality assumption and trims better the data. 
# yet if normality assumption is the best way to preprocess the data is still dubious as previously shown. Choosing a logical statistical approach matters
#for the preprocessing
#Authors contigs filter does not seem to have a logical statistical based approach rather empirical or random approach.
#This affect the proportion of genomes that is preserved for downstream analysis.
# Having a large threshold might not be wrong but further analysis and proves would need to be shown. For example,
#if the sample size is sufficiently large is less probable to trim the data because of unusual observations. This might have some link 
#with normal distribution assumption.
#In general and based in this observations using the proposed  preprocessing method might be a tentative option rather than using the authors method which was based in his species.
#And we see how species distribution has a significant impact in the preprocessing filtering for further downstream analysis.
#Also the proposed method is still build under normality assumptions. But it improve the authors contigs filter because it seems quite ambigous.
# A unsuitable cutoff value means loosing valuable information (genomes) for further downstream analysis. How to account for good genomes selection
# is still prevailing question because we need to account for the population structure or the data distribution and the possible hidden biological concepts behind it.