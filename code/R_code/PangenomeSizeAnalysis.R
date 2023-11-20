library("readr")
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

#Neisseria sample 2
#sample 50
load("50Nesse2panmatrixCDS.RData")
#sample 400
load("400Nesse2panmatrixCDS.RData")

#Pangenome size analysis
#Neisseria sample 1
#CDS pangenome
#Convert to matrix
smallPanMatNesseOne<-as.matrix(smallPanMatNesseOne)
LargePanMatNesseOne<-as.matrix(LargePanMatNesseOne)
#Replace NA with zeros
smallPanMatNesseOne<-replace_NA(smallPanMatNesseOne)
LargePanMatNesseOne<-replace_NA(LargePanMatNesseOne)

#Neisseria sample 2
smallPanMatNesseTwo<-as.matrix(smallPanMatNesseTwo)
LargePanMatNesseTwo<-as.matrix(LargePanMatNesseTwo)
#Replace NA with zeros
smallPanMatNesseTwo<-replace_NA(smallPanMatNesseTwo)
LargePanMatNesseTwo<-replace_NA(LargePanMatNesseTwo)

#Heaps Law:
#neisseria 1
smallheapsnesse=heaps(smallPanMatNesseOne)
largeheapsnesse=heaps(LargePanMatNesseOne)
#Neisseria 2
smallheapsnesse2=heaps(smallPanMatNesseTwo)
largeheapsnesse2=heaps(LargePanMatNesseTwo)

#if alpha is greater than 1 is closed otherwise is open
smallheapsnesse
smallheapsnesse2
# Frequencies estimation by fitting binomial mixture model
#Neisseria 1
fittedsmall <- binomixEstimate(smallPanMatNesseOne, K.range = 3:20)
fittedlarge<- binomixEstimate(LargePanMatNesseOne, K.range = 3:20)
print(fittedsmall$BIC.tbl)
print(fittedlarge$BIC.tbl)
#Neisseria sample 2
View(smallPanMatNesseTwo)
fittedsmall2<- binomixEstimate(smallPanMatNesseTwo, K.range = 3:20)
fittedlarge2<- binomixEstimate(LargePanMatNesseTwo, K.range = 3:20)
print(fittedsmall2$BIC.tbl)
print(fittedlarge2$BIC.tbl)
#Small Dataset
ncomp <- 13
fig4 <- fittedsmall$Mix.tbl %>% 
  filter(Components == ncomp) %>% 
  ggplot() +
  geom_col(aes(x = "", y = Mixing.proportion, fill = Detection.prob)) +
  coord_polar(theta = "y") +
  labs(x = "", y = "", title = "Pan-genome gene family distribution")+ 
  scale_fill_gradientn(colors = c("pink", "orange", "green", "cyan", "blue"))
#Core genomes are presume to be in the fraction with a detection probability of 1
#for the rest read the paper of micropan.
print(fig4)


#Large Dataset
ncomp<-16
fig5<-fittedlarge$Mix.tbl %>% 
  filter(Components == ncomp) %>% 
  ggplot() +
  geom_col(aes(x = "", y = Mixing.proportion, fill = Detection.prob)) +
  coord_polar(theta = "y") +
  labs(x = "", y = "", title = "Pan-genome gene family distribution") +
  scale_fill_gradientn(colors = c("pink", "orange", "green", "cyan", "blue"))
#Core genomes are presume to be in the fraction with a detection probability of 1
#for the rest read the paper of micropan.
print(fig5)

#Neisseria sample 2
#Small Dataset
ncomp <- 8
fig6 <- fittedsmall2$Mix.tbl %>% 
  filter(Components == ncomp) %>% 
  ggplot() +
  geom_col(aes(x = "", y = Mixing.proportion, fill = Detection.prob)) +
  coord_polar(theta = "y") +
  labs(x = "", y = "", title = "Pan-genome gene family distribution")+ 
  scale_fill_gradientn(colors = c("pink", "orange", "green", "cyan", "blue"))
#Core genomes are presume to be in the fraction with a detection probability of 1
#for the accesory genomes. read the paper of micropan.
print(fig6)
#Large dataset
ncomp<-15
fig7<-fittedlarge2$Mix.tbl %>% 
  filter(Components == ncomp) %>% 
  ggplot() +
  geom_col(aes(x = "", y = Mixing.proportion, fill = Detection.prob)) +
  coord_polar(theta = "y") +
  labs(x = "", y = "", title = "Pan-genome gene family distribution") +
  scale_fill_gradientn(colors = c("pink", "orange", "green", "cyan", "blue"))
#Core genomes are presume to be in the fraction with a detection probability of 1
#for the rest read the paper of micropan.
print(fig7)
#Bacteroides sample 1

#Bacteroides sample 2
