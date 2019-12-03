# install.packages("ElemStatLearn")
library(MASS)
library(bestglm)
library(class)
#install.packages("randomForest")
library(randomForest)
library(ElemStatLearn)
library(glmnet)
library(pls)
library(leaps)
library(tree)
library("rpart") #install.packages("rpart")
library(MASS)

spam = read.csv('/home/mavericku/Documents/DataScienceFall2019/EAS506 - Data Mining/HW4/spam.csv',header = FALSE, sep = " ")

spam_train = sample(1:nrow(spam), nrow(spam)*0.80)
spam_test = -spam_train
spam_train_data = spam[spam_train, ]
spam_test_data = spam[spam_test, ]
spam_train_data$V58 <- as.character(spam_train_data$V58)
spam_train_data$V58 <- as.factor(spam_train_data$V58)
ran_model = randomForest(V58~., data=spam_train_data,mtry=5,ntree=2500)
ran_model
#OOB 4.76%
ran_pred = predict(ran_model, spam_test_data, type = "class") 
mean(ran_pred != spam_test_data$V58)
#0.0413

#Using 4 inputs:
ran_model = randomForest(V58~., data=spam_train_data,mtry=4,ntree=2500)
ran_model
#OOB 4.81%
ran_pred = predict(ran_model, spam_test_data, type = "class") 
mean(ran_pred != spam_test_data$V58)
#0.0402


#using 10:
ran_model = randomForest(V58~., data=spam_train_data,mtry=10,ntree=2500)
ran_model
#OOB 4.81%
ran_pred = predict(ran_model, spam_test_data, type = "class") 
mean(ran_pred != spam_test_data$V58)
#0.0423
