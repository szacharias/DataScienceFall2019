#install.packages("ElemStatLearn")
library(MASS)
library(bestglm)
library(class)


library(ElemStatLearn)
library(glmnet)
library(pls)
library(leaps)
#1#
 
#read data
pro_1_train = sample(1:nrow(prostate), nrow(prostate)*0.80)
pro_1_test = -pro_1_train
pro_1_train_data = prostate[pro_1_train, ]
pro_1_test_data = prostate[pro_1_test, ]
best_sub = regsubsets(train~.,data = prostate,method="exhaustive")
reg_summary=summary(best_sub)
reg_summary$cp
#0.4650382 1.3504137 0.4181619 1.3700022 2.3234078 4.1744943 6.1001435 8.0006358
#third is the best
reg_summary$bic
#6.040028  9.451005 10.895878 14.326838 17.745890 22.155045 26.646990 31.110819
#first is the best

#5-fold
best_sub = regsubsets(train~.,data = pro_1_train_data,method="exhaustive")
train_errors = rep(NA,8)
test_errors = rep(NA,8)
#Y_train=pro_1_train_data['train']
Y_train=pro_1_train_data$train
Y_test=pro_1_test_data$train
train_pred_matrix = model.matrix(train~., data = pro_1_train_data)

test_pred_matrix = model.matrix(train~., data = pro_1_test_data)
for (i in 1:8) {
  coefi = coef(best_sub, id = i)
  pred_train <- train_pred_matrix[,names(coefi)] %*% coefi
  train_errors[i] = mean((Y_train - pred_train)^2)
  pred_test <- test_pred_matrix[,names(coefi)] %*% coefi
  test_errors[i] = mean((Y_test - pred_test)^2)
}

test_errors

#0.2236606 0.2390604 0.2249300 0.2512954 0.2537141 0.2700974 0.2727801 0.2772596 
#first is the best

#10-fold
pro_1_train = sample(1:nrow(prostate), nrow(prostate)*0.90)
pro_1_test = -pro_1_train
pro_1_train_data = prostate[pro_1_train, ]
pro_1_test_data = prostate[pro_1_test, ]
best_sub = regsubsets(train~.,data = pro_1_train_data,method="exhaustive")
train_errors = rep(NA,8)
test_errors = rep(NA,8)
#Y_train=pro_1_train_data[train]
Y_train=pro_1_train_data$train
Y_test=pro_1_test_data$train
train_pred_matrix = model.matrix(train~., data = pro_1_train_data)

test_pred_matrix = model.matrix(train~., data = pro_1_test_data)
for (i in 1:8) {
  coefi = coef(best_sub, id = i)
  pred_train <- train_pred_matrix[,names(coefi)] %*% coefi
  train_errors[i] = mean((Y_train - pred_train)^2)
  pred_test <- test_pred_matrix[,names(coefi)] %*% coefi
  test_errors[i] = mean((Y_test - pred_test)^2)
}

test_errors
#0.2086378 0.2217119 0.2263627 0.2200508 0.2280732 0.2175277 0.2139478 0.2097320
#first is the best


#boot
library(bootstrap)
library(boot)  #install.packages("bootstrap")
best_sub = regsubsets(train~.,data = prostate,method="exhaustive")
reg_summary=summary(best_sub)

beta.fit <- function(X,Y){
  lsfit(X,Y)	
}

beta.predict <- function(fit, X){
  cbind(1,X)%*%fit$coef
}

sq.error <- function(Y,Yhat){
  (Y-Yhat)^2
}
select = reg_summary$outmat
error_store <- c()
for (i in 1:8){
  # Pull out the model
  temp <- which(select[i,] == "*")
  
  res <- bootpred(prostate[,temp], prostate$train, nboot = 50, theta.fit = beta.fit, theta.predict = beta.predict, err.meas = sq.error) 
  error_store <- c(error_store, res[[3]])
  
}
#0.2136327 0.2135156 0.2106268 0.2179330 0.2147731 0.2188589 0.2301666 0.2334832
#third one is the best
#models using all
#         lcavol lweight age lbph svi lcp gleason pgg45 lpsa
#1  ( 1 ) " "    " "     "*" " "  " " " " " "     " "   " " 
#2  ( 1 ) " "    " "     " " " "  " " " " "*"     "*"   " " 
#3  ( 1 ) " "    " "     "*" " "  " " " " "*"     "*"   " " 
#4  ( 1 ) " "    " "     "*" " "  " " "*" "*"     "*"   " " 
#5  ( 1 ) " "    " "     "*" "*"  " " "*" "*"     "*"   " " 
#6  ( 1 ) " "    "*"     "*" "*"  " " "*" "*"     "*"   " " 
#7  ( 1 ) " "    "*"     "*" "*"  "*" "*" "*"     "*"   " " 
#8  ( 1 ) "*"    "*"     "*" "*"  "*" "*" "*"     "*"   " "