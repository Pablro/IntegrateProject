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
#Bacteroides sample 1
#sample 50
load("50Bactero1panmatrixCDS.RData")
#sample 400
load("400Bactero1panmatrixCDS.RData")
#Bacteroides sample 2
#sample 50
load("50Bactero2panmatrixCDS.RData")
#sample 400
load("400Bactero2panmatrixCDS.RData")
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
#Bacteroides sample 1
smallPanMatBacteroOne<-as.matrix(smallPanMatBacteroOne)
LargePanMatBacteroOne<-as.matrix(LargePanMatBacteroOne)
#Replace NA with zeros
smallPanMatBacteroOne<-replace_NA(smallPanMatBacteroOne)
LargePanMatBacteroOne<-replace_NA(LargePanMatBacteroOne)
#Bacteroides sample 2
smallPanMatBacteroTwo<-as.matrix(smallPanMatBacteroTwo)
LargePanMatBacteroTwo<-as.matrix(LargePanMatBacteroTwo)
#Replace NA with zeros
smallPanMatBacteroTwo<-replace_NA(smallPanMatBacteroTwo)
LargePanMatBacteroTwo<-replace_NA(LargePanMatBacteroTwo)
#Heaps Law:
#neisseria 1
smallheapsnesse=heaps(smallPanMatNesseOne)
largeheapsnesse=heaps(LargePanMatNesseOne)
smallheapsnesse
largeheapsnesse
#Neisseria 2
smallheapsnesse2=heaps(smallPanMatNesseTwo)
largeheapsnesse2=heaps(LargePanMatNesseTwo)
smallheapsnesse2
largeheapsnesse2
#Bacteroides 1
smallheapsbactero=heaps(smallPanMatBacteroOne)
largeheapsbactero=heaps(LargePanMatBacteroOne)
smallheapsbactero
largeheapsbactero
#Bacteroides 2
smallheapsbactero2=heaps(smallPanMatBacteroTwo)
largeheapsbactero2=heaps(LargePanMatBacteroTwo)
smallheapsbactero2
largeheapsbactero2
#if alpha is greater than 1 is closed otherwise is open
# Frequencies estimation by fitting binomial mixture model
#Neisseria 1
nessefittedsmall <- binomixEstimate(smallPanMatNesseOne, K.range = 3:20)
nessefittedlarge<- binomixEstimate(LargePanMatNesseOne, K.range = 3:20)
print(nessefittedsmall$BIC.tbl)
print(nessefittedlarge$BIC.tbl)
#Neisseria sample 2
nessefittedsmall2<- binomixEstimate(smallPanMatNesseTwo, K.range = 3:20)
nessefittedlarge2<- binomixEstimate(LargePanMatNesseTwo, K.range = 3:20)
print(nessefittedsmall2$BIC.tbl)
print(nessefittedlarge2$BIC.tbl)
#Bacteroides sample 1
bacterofittedsmall <- binomixEstimate(smallPanMatBacteroOne, K.range = 3:20)
bacterofittedlarge<- binomixEstimate(LargePanMatBacteroOne, K.range = 3:20)
print(bacterofittedsmall$BIC.tbl)
print(bacterofittedlarge$BIC.tbl)
#Bacteroides sample 2
bacterofittedsmall2<- binomixEstimate(smallPanMatBacteroTwo, K.range = 3:20)
bacterofittedlarge2<- binomixEstimate(LargePanMatBacteroTwo, K.range = 3:20)
print(bacterofittedsmall2$BIC.tbl)
print(bacterofittedlarge2$BIC.tbl)

#Neisseria 1
#Small Dataset
ncomp <- 13
fig4 <- nessefittedsmall$Mix.tbl %>% 
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
fig5<-nessefittedlarge$Mix.tbl %>% 
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
fig6 <- nessefittedsmall2$Mix.tbl %>% 
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
fig7<-nessefittedlarge2$Mix.tbl %>% 
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
#Small Dataset
ncomp <- 11
fig8 <- bacterofittedsmall$Mix.tbl %>% 
  filter(Components == ncomp) %>% 
  ggplot() +
  geom_col(aes(x = "", y = Mixing.proportion, fill = Detection.prob)) +
  coord_polar(theta = "y") +
  labs(x = "", y = "", title = "Pan-genome gene family distribution")+ 
  scale_fill_gradientn(colors = c("pink", "orange", "green", "cyan", "blue"))
#Core genomes are presume to be in the fraction with a detection probability of 1
#for the accesory genomes. read the paper of micropan.
print(fig8)
#Large dataset
ncomp<-21
fig9<-bacterofittedlarge$Mix.tbl %>% 
  filter(Components == ncomp) %>% 
  ggplot() +
  geom_col(aes(x = "", y = Mixing.proportion, fill = Detection.prob)) +
  coord_polar(theta = "y") +
  labs(x = "", y = "", title = "Pan-genome gene family distribution") +
  scale_fill_gradientn(colors = c("pink", "orange", "green", "cyan", "blue"))
#Core genomes are presume to be in the fraction with a detection probability of 1
#for the rest read the paper of micropan.
print(fig9)
#Error in this plot
#Bacteroides sample 2
#Small Dataset
ncomp <- 8
fig10 <- bacterofittedsmall2$Mix.tbl %>% 
  filter(Components == ncomp) %>% 
  ggplot() +
  geom_col(aes(x = "", y = Mixing.proportion, fill = Detection.prob)) +
  coord_polar(theta = "y") +
  labs(x = "", y = "", title = "Pan-genome gene family distribution")+ 
  scale_fill_gradientn(colors = c("pink", "orange", "green", "cyan", "blue"))
#Core genomes are presume to be in the fraction with a detection probability of 1
#for the accesory genomes. read the paper of micropan.
print(fig10)
#Large dataset
ncomp<-13
fig11<-bacterofittedlarge2$Mix.tbl %>% 
  filter(Components == ncomp) %>% 
  ggplot() +
  geom_col(aes(x = "", y = Mixing.proportion, fill = Detection.prob)) +
  coord_polar(theta = "y") +
  labs(x = "", y = "", title = "Pan-genome gene family distribution") +
  scale_fill_gradientn(colors = c("pink", "orange", "green", "cyan", "blue"))
#Core genomes are presume to be in the fraction with a detection probability of 1
#for the rest read the paper of micropan.
print(fig11)
