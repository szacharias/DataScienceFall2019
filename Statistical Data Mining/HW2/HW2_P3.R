
cat("\014")  
rm(list = ls()) 
setwd("C:/Users/Matthew/Documents/WorkFolder") 
#subset
library(leaps)

## ========= Part 0 Functions === =======

#return regression
predict_regression_best_subset = function(object,newdata,id,...){ 
  form = as.formula( object$call[[2]]) ## extract formula
  coefi_matrix = model.matrix( form , newdata )
  coefi = coef (object , id = id ) 
  coefi_matrix[ ,names(coefi) ] %*% coefi 
}

#return mean_squared_error
mse = function( predicted_data , tested_data_value ){
  mean( ( predicted_data - tested_data_value )^2)
}

#### ======== Part 0 end==========


# === Part 1 Data Generating === 
# Data Production
feature_limit = 20
row_limit = 1000
beta_features = 3
train_data_amount = 900
set.seed(1)

#Generate Data 
gen_data =matrix(rnorm(row_limit*feature_limit),ncol=feature_limit,nrow=row_limit)

# generate column names to column data
colnames(gen_data) <- sprintf("feature_label_%d",1:feature_limit)

# Randoms
#random_beta_value = floor(runif(6, min=0, max=feature_limit))
random_beta_values = sample(1:feature_limit, beta_features) 
random_beta_values = sort(random_beta_values)
random_beta_values  

# Clear beta values
beta=rnorm(20)
beta[random_beta_values]=0
beta


#Associative Quantative Response Vector
e=rnorm(1000)
X = gen_data

# Y = X Beta + e 
Y=as.vector(X%*%beta+e)

#training and testing Data
# pick out 900
train=sample(1:nrow(gen_data),train_data_amount)
test=(-train)
 
# split data
#pick out sampled data for X
x_train=X[train,]
x_test=X[test,]
y_train=Y[train]
y_test=Y[test]


# ===== Part 2 Data Processing ======

#combine objects 
train_data=cbind(data.frame(Y=y_train),x_train)
test_data=cbind(data.frame(Y=y_test),x_test)

# ===== Calculating best subsets
regression_best_subset=regsubsets( Y~. , data=train_data , nvmax = feature_limit ) 

regression_best_subset_train=regsubsets( Y~. , data=train_data , nvmax = feature_limit ) 



# =============== Part 3 Plotting =================
# === MSE ===
train_mse <- sapply(1:20, function(index){
  pred=predict_regression_best_subset(regression_best_subset_train,train_data,index)
  mse(pred,y_train)
})





# === Training MSE ====
x11()
plot(seq(1:20),train_mse,xlab="Number of Features/ Predictors",
     ylab="Train MSE")
points(which.min(train_mse),train_mse[which.min(train_mse)],
       col="blue",cex=2,pch=20)
coef(regression_best_subset,id=which.min(train_mse))




test_mse <- sapply(1:20, function(index){
  pred=predict_regression_best_subset(regression_best_subset,test_data,index)
  mse(pred,y_test)
})


 # ==== Testing MSE ======
x11()
plot(seq(1:20),test_mse,xlab="Number of Features/ Predictors",
     ylab="Test MSE")
points(which.min(test_mse),test_mse[which.min(test_mse)],
       col="red",cex=2,pch=20)
coef(regression_best_subset,id=which.min(test_mse))







