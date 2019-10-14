rm(list = ls()) 
setwd("C:/Users/Matthew/Documents/WorkFolder") 

library(leaps);library(Ecdat);library(car);library(lmtest);library(psych);library(ggplot2);library("ElemStatLearn");library("ggplot2");library("GGally")
ls("package:ElemStatLearn")
require(lattice)
library(data.table)
library("MASS")  
library(class)
library(reshape2)
library(ggplot2)
library(xtable)
K <- c(1,3,5,7,15)


sub.train <- subset(zip.train, zip.train[,1] %in% c(2,3))
sub.test <- subset(zip.test, zip.test[,1] %in% c(2,3))

# change the first column to factor
sub.train[,1] <- as.factor(zip.train[,1])
sub.test[,1] <- as.factor(zip.test[,1])

knn.train.err <- vector()
knn.test.err <- vector()

for ( i in 1:length(K) ){
  # Training the kNN model with different k
  knn.train.pred <- knn(sub.train[,-1], sub.train[,-1], sub.train[,1], k = K[i])
  knn.test.pred <- knn(sub.train[,-1], sub.test[,-1], sub.train[,1], k = K[i])
  
  # Calculate the error rate of kNN for training and testing datasets
  knn.train.err[i] <- mean(sub.train[,1] != knn.train.pred)
  knn.test.err[i] <- mean(sub.test[,1] != knn.test.pred)
}

# Data frame of classification errors
err <- data.frame("k" = K, "LM.Train" = lm.train.err, "LM.Test" = lm.test.err, "kNN.Train" = knn.train.err, "kNN.Test" = knn.test.err)

# Create Plots
plot.data <- melt(err, id = "k")
names(plot.data) <- c("k","Model", "Error")
ggplot(data = plot.data) + geom_line(mapping=aes(x = k, y = Error, colour = Model), size= 2.5) + theme(axis.text=element_text(size=14), axis.title=element_text(size=16), legend.title=element_text(size=16), legend.text=element_text(size=14))

# save the table
print(xtable(err, digits = c(0,0,4,4,4,4)), include.rownames = FALSE)
