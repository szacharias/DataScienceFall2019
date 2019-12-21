

#########2#################
library(tree)
library("rpart") #install.packages("rpart")
library(MASS)
set.seed(438)
setwd("/home/mavericku/Documents/DataScienceFall2019/EAS506 - Data Mining")
wine_data = read.csv('/home/mavericku/Documents/DataScienceFall2019/EAS506 - Data Mining/HW4/wine.csv',header = FALSE)

wine_train = sample(1:nrow(wine_data), nrow(wine_data)*0.80)
wine_test = -wine_train
wine_train_data = wine_data[wine_train, ]
wine_test_data = wine_data[wine_test, ]
model.control <- rpart.control(minsplit = 5, xval = 10, cp = 0)
wine_model <- rpart(V1~., data = wine_train_data, method = "class", control = model.control)
tree_pred = predict(wine_model, wine_test_data, type = "class")
mean(tree_pred != wine_test_data$V1)
#0.0278 pretty good fit

#to visulize 
plot(wine_model)
text(wine_model)

min_cp = which.min(wine_model$cptable[,4])
wine_model_pruned <- prune(wine_model, cp = wine_model$cptable[min_cp,1])
tree_pred = predict(wine_model_pruned, wine_test_data, type = "class")
mean(tree_pred != wine_test_data$V1)
#same error rates after prune
tree_pred = predict(wine_model_pruned, wine_train_data, type = "class")
mean(tree_pred != wine_train_data$V1)
#train error 0.0141
#similar results trying other parameters, yet when changing random number different results
#suggesting this model is superier than others (say using 5509) 

#using 
wine_model$frame
#to obtain node information 
table(wine_test_data$V1,tree_pred)

