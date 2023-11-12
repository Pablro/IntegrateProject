library("micropan")
# Based on: https://github.com/larssnip/micropan
library("collapse")
library("ggplot2")
######if you parent directory/default directory does not end with ~/Documents#######
getwd()#for checking in your computer
defdir="/Users/marshall/Documents/2ndYear"
setwd(defdir)
#>>>>>>> main
#Collect the source code from respective directory on your machines.
#Assign sourdir as one child dir, remember to maker sure "IntegrateProject/code/R_code" is right after the path defdir
sourdir=paste(defdir,"IntegrateProject/data/Rdata",sep="/")
setwd(sourdir)
#Loading CDS panmatrix data
#Neisseria sample 1
#sample of 50
load("50Nesse1panmatrixCDS.RData")
#sample of 400
load("400Nesse1panmatrixCDS.RData")

#Loading ncRNA panmatrix data
#sample 50
load("50Nesse1panmatrixncRNA.RData")
#sample 400
load("400Nesse1panmatrixncRNA.RData")

#Pangenome size analysis
#Neisseria sample 1
#CDS pangenome
#Convert to matrix
smallPanMatNesseOne<-as.matrix(smallPanMatNesseOne)
LargePanMatNesseOne<-as.matrix(LargePanMatNesseOne)
#Replace NA with zeros
smallPanMatNesseOne<-replace_NA(smallPanMatNesseOne)
LargePanMatNesseOne<-replace_NA(LargePanMatNesseOne)

#Heaps Law:
smallheapsnesse=heaps(smallPanMatNesseOne)
largeheapsnesse=heaps(LargePanMatNesseOne)
#if alpha is greater than 1 is closed otherwise is open
smallheapsnesse
largeheapsnesse
# Frequencies estimation by fitting binomial mixture model
fittedsmall <- binomixEstimate(smallPanMatNesseOne, K.range = 3:20)
fittedlarge<- binomixEstimate(LargePanMatNesseOne, K.range = 3:20)
print(fittedsmall$BIC.tbl)
print(fittedlarge$BIC.tbl)
#Small Dataset
ncomp <- 13
fig4 <- fittedsmall$Mix.tbl %>% 
  filter(Components == ncomp) %>% 
  ggplot() +
  geom_col(aes(x = "", y = Mixing.proportion, fill = Detection.prob)) +
  coord_polar(theta = "y") +
  labs(x = "", y = "", title = "Pan-genome gene family distribution",
       fill = "Detection\nprobability")
#Core genomes are presume to be in the fraction with a detection probability of 1
#for the rest nothing can be conclude
print(fig4)
#Large Dataset
ncomp<-16
fig5<-fittedlarge$Mix.tbl %>% 
  filter(Components == ncomp) %>% 
  ggplot() +
  geom_col(aes(x = "", y = Mixing.proportion, fill = Detection.prob)) +
  coord_polar(theta = "y") +
  labs(x = "", y = "", title = "Pan-genome gene family distribution",
       fill = "Detection\nprobability")
#Core genomes are presume to be in the fraction with a detection probability of 1
#for the rest nothing can be conclude
print(fig5)
# ncRNA pangenome
#Convert to matrix
smallncRNAPanMatNesseOne<-as.matrix(smallncRNAPanMatNesseOne)
LargencRNAPanMatNesseOne<-as.matrix(LargencRNAPanMatNesseOne)
#Replace NA with zeros
smallncRNAPanMatNesseOne<-replace_NA(smallncRNAPanMatNesseOne)
LargencRNAPanMatNesseOne<-replace_NA(LargencRNAPanMatNesseOne)

#Heaps Law:
smallheapsnessencRNA=heaps(smallncRNAPanMatNesseOne)
largeheapsnessencRNA=heaps(LargencRNAPanMatNesseOne)
#if alpha is greater than 1 is closed otherwise  is open
smallheapsnessencRNA
largeheapsnessencRNA
# Frequencies estimation by fitting binomial mixture model
fittedsmallncRNA <- binomixEstimate(smallncRNAPanMatNesseOne, K.range = 3:20)
fittedlargencRNA<- binomixEstimate(LargencRNAPanMatNesseOne, K.range = 3:20)
print(fittedsmallncRNA$BIC.tbl)
print(fittedlargencRNA$BIC.tbl)
#Small Dataset
ncomp <- 4
fig6 <- fittedsmallncRNA$Mix.tbl %>% 
  filter(Components == ncomp) %>% 
  ggplot() +
  geom_col(aes(x = "", y = Mixing.proportion, fill = Detection.prob)) +
  coord_polar(theta = "y") +
  labs(x = "", y = "", title = "Pan-genome gene family distribution",
       fill = "Detection\nprobability")
#Core genomes are presume to be in the fraction with a detection probability of 1
#for the rest nothing can be conclude
print(fig6)
#Large Dataset
ncomp<-8
fig7<-fittedlargencRNA$Mix.tbl %>% 
  filter(Components == ncomp) %>% 
  ggplot() +
  geom_col(aes(x = "", y = Mixing.proportion, fill = Detection.prob)) +
  coord_polar(theta = "y") +
  labs(x = "", y = "", title = "Pan-genome gene family distribution",
       fill = "Detection\nprobability")
#Core genomes are presume to be in the fraction with a detection probability of 1
#for the rest nothing can be conclude
print(fig7)

#Neisseria sample 2

#Bacteroides sample 1

#Bacteroides sample 2