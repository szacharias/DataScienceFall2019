library(glmnet)
library(pls)
library(leaps) 
library(MASS)
library(bestglm)
library(class)

#install.packages("bootstrap")
library(bootstrap)
library(boot)  

#install.packages("ElemStatLearn")
library(ElemStatLearn)

prostate

### ======= Functions ====

split_train_test <- function(data){ 
  prostate_training_set = sample(1:nrow(prostate), nrow(prostate)*0.8)
  prostate_testing_set = -prostate_training_set
  return_list <- list("training" = prostate_training_set, "testing" = prostate_testing_set )
  return(return_list)
}

five_fold_ <- function(prostate_train, prostate_test){
  train_errors = rep(NA,8)
  test_errors = rep(NA,8) 
  
  best_subset = regsubsets(train~.,data = prostate_train,method="exhaustive")
  Y_train=prostate_train$train
  Y_test=prostate_test$train
  train_pred_matrix = model.matrix(train~., data = prostate_train)
  
  test_pred_matrix = model.matrix(train~., data = prostate_test)
  for (i in 1:8) {
    coefi = coef(best_subset, id = i)
    pred_train <- train_pred_matrix[,names(coefi)] %*% coefi
    train_errors[i] = mean((Y_train - pred_train)^2)
    pred_test <- test_pred_matrix[,names(coefi)] %*% coefi
    test_errors[i] = mean((Y_test - pred_test)^2)
  } 
  # return_list <- list("target_train" = Y_train , "target_test" = Y_test, "test_errors" = test_errors)
  return_list <- list("test_errors" = test_errors)
  return(test_errors)
  
}
 
ten_fold <- function( prostate){
  train_errors = rep(NA,8)
  test_errors = rep(NA,8)
  prostate_training_set = sample(1:nrow(prostate), nrow(prostate)*0.90)
  prostate_testing_set = -prostate_training_set
  prostate_train = prostate[prostate_training_set, ]
  prostate_test = prostate[prostate_testing_set, ]
  Y_train=prostate_train$train
  Y_test=prostate_test$train
  
  best_subset = regsubsets(train~.,data = prostate_train,method="exhaustive") 
  train_pred_matrix = model.matrix(train~., data = prostate_train)
  
  test_pred_matrix = model.matrix(train~., data = prostate_test)
  for (i in 1:8) {
    coefi = coef(best_subset, id = i)
    pred_train <- train_pred_matrix[,names(coefi)] %*% coefi
    train_errors[i] = mean((Y_train - pred_train)^2)
    pred_test <- test_pred_matrix[,names(coefi)] %*% coefi
    test_errors[i] = mean((Y_test - pred_test)^2)
  }
  
  test_errors
  return(test_errors)  
  
}

boot_test_error <-function(prostate){
  beta.fit <- function(X,Y){
    lsfit(X,Y)	
  }
  
  beta.predict <- function(fit, X){
    cbind(1,X)%*%fit$coef
  }
  
  sq.error <- function(Y,Yhat){
    (Y-Yhat)^2
  }
  #boot
  best_subset = regsubsets(train~.,data = prostate,method="exhaustive")
  bss_regression_summary=summary(best_subset)
  select = bss_regression_summary$outmat
  error_score <- c()
  for (i in 1:8){
    # Pull out the model
    temp_data <- which(select[i,] == "*")
    
    result <- bootpred(prostate[,temp_data], prostate$train, nboot = 50, theta.fit = beta.fit, theta.predict = beta.predict, err.meas = sq.error) 
    error_score <- c(error_score, result[[3]])
    
  }
  return_list <- list("error_score" = error_score , "bss_regression_summary" = bss_regression_summary)
  return(return_list) 
}
### ====== FUNCTION ENDS ==== 

# Split train test 
split_data_train_test <- split_train_test(prostate)
prostate_training_set = split_data_train_test$training
prostate_testing_set = split_data_train_test$testing

prostate_train = prostate[prostate_training_set, ]
prostate_test = prostate[prostate_testing_set, ]

# Find best Subset
best_subset = regsubsets( train~ . , data = prostate , method = "exhaustive" )
bss_regression_summary=summary(best_subset)
bss_regression_summary 
# lcavol lweight age lbph svi lcp gleason pgg45 lpsa
# 1  ( 1 ) " "    " "     "*" " "  " " " " " "     " "   " " 
# 2  ( 1 ) " "    " "     " " " "  " " " " "*"     "*"   " " 
# 3  ( 1 ) " "    " "     "*" " "  " " " " "*"     "*"   " " 
# 4  ( 1 ) " "    " "     "*" " "  " " "*" "*"     "*"   " " 
# 5  ( 1 ) " "    " "     "*" "*"  " " "*" "*"     "*"   " " 
# 6  ( 1 ) " "    "*"     "*" "*"  " " "*" "*"     "*"   " " 
# 7  ( 1 ) " "    "*"     "*" "*"  "*" "*" "*"     "*"   " " 
# 8  ( 1 ) "*"    "*"     "*" "*"  "*" "*" "*"     "*"   " " 

bss_regression_summary$cp 
# [1] 0.4650382 1.3504137 0.4181619 1.3700022 2.3234078 4.1744943 6.1001435 8.0006358
# Lowest is better 3rd is best
bss_regression_summary$bic 
# [1]  6.040028  9.451005 10.895878 14.326838 17.745890 22.155045 26.646990 31.110819
#1st


five_fold_CV_test_error <- five_fold_(prostate_train, prostate_test)
five_fold_CV_test_error
# [1] 0.3391230 0.2942332 0.3031100 0.3129720 0.3079543 0.2926718 0.2958197 0.2939711
#6th

ten_fold_CV_test_error <-ten_fold( prostate )
ten_fold_CV_test_error
# [1] 0.1806838 0.2011806 0.1788826 0.1938684 0.2211844 0.2225437 0.2272899 0.2290687
# 3rd

boot_test_error_ = boot_test_error(prostate)
boot_test_error_$error_score
boot_test_error_$bss_regression_summary
# [1] 0.2144492 0.2195338 0.2142829 0.2137558 0.2183234 0.2254258 0.2250445 0.2273397
# # 3rd
# Selection Algorithm: exhaustive
# lcavol lweight age lbph svi lcp gleason pgg45 lpsa
# 1  ( 1 ) " "    " "     "*" " "  " " " " " "     " "   " " 
# 2  ( 1 ) " "    " "     " " " "  " " " " "*"     "*"   " " 
# 3  ( 1 ) " "    " "     "*" " "  " " " " "*"     "*"   " " 
# 4  ( 1 ) " "    " "     "*" " "  " " "*" "*"     "*"   " " 
# 5  ( 1 ) " "    " "     "*" "*"  " " "*" "*"     "*"   " " 
# 6  ( 1 ) " "    "*"     "*" "*"  " " "*" "*"     "*"   " " 
# 7  ( 1 ) " "    "*"     "*" "*"  "*" "*" "*"     "*"   " " 
# 8  ( 1 ) "*"    "*"     "*" "*"  "*" "*" "*"     "*"   " " 