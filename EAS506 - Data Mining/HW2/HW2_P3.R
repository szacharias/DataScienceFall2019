
#> We have seen that as the number of features used in a model increases, the training error will necessarily decrease, but the test error may not. We will now explore this in a simulated data set.
#> Generate a data set with p = 20 features, n = 1000 observations, and an associated quantitative response vector generated according to the model $Y=X\beta+\epsilon$
#  where $\beta$ has some elements that are exactly equal to zero. 

cat("\014")  
rm(list = ls()) 
setwd("C:/Users/Matthew/Documents/WorkFolder") 


library(leaps)

## === Part 0 Functions === 
#predict.regsubsets=function(object,newdata,id,...){ 
#  form=as.formula(object$call[[2]]) ## extract formula
#  mat=model.matrix(form,newdata)
#  coefi=coef(object,id=id)
#  xvars=names(coefi)
#  mat[,xvars]%*%coefi
#}

#return regression predictions
predict_regression_best_subset = function(object,newdata,id,...){ 
  form=as.formula(object$call[[2]]) ## extract formula
  mat=model.matrix(form,newdata)
  coefi=coef(object,id=id)
  xvars=names(coefi)
  mat[,xvars]%*%coefi
}

#return MSE
mse=function(predicted_data,tested_data_value){
  mean( ( predicted_data - tested_data_value )^2)
}



# === Part 1 Data Generating === 
# Data Production
feature_limit = 20
row_limit = 1000
beta_features = 6
train_data_amount = 900
set.seed(1)

#Generate Data
# replace X with gen_data
gen_data =matrix(rnorm(row_limit*feature_limit),ncol=feature_limit,nrow=row_limit)
colnames(gen_data) <- sprintf("feature_label_%d",1:feature_limit)


#distinct features with normal ditribution
#random_beta_value = floor(runif(6, min=0, max=feature_limit))
random_beta_values = sample(1:feature_limit, 6) 
random_beta_values = sort(random_beta_values)
random_beta_values
#tester = c(3,7,9,11,13,18)
#random_beta_values
beta=rnorm(20,sd=10)
beta[random_beta_values]=0
beta


#Associative Quantative Response Vector
e=rnorm(1000)
X = gen_data
# Y = X Beta + e
#This operator is used to multiply a matrix with its transpose.
Y=as.vector(X%*%beta+e)

#training and testing Data
# pick out 900
train=sample(1:nrow(gen_data),train_data_amount)
test=(-train)


# split data
#pick out sampled data for X
X.train=X[train,]
X.test=X[test,]
Y.train=Y[train]
Y.test=Y[test]

# ===== Part 2 Data Processing ======

#combine objects
#dat.train=cbind(data.frame(Y=Y.train),X.train)
#dat.test=cbind(data.frame(Y=Y.test),X.test)
train_data=cbind(data.frame(Y=Y.train),X.train)
test_data=cbind(data.frame(Y=Y.test),X.test)

# best subsets
#regfit.best=regsubsets(Y~. , data=dat.train , nvmax = feature_limit )
regression_best_subset=regsubsets( Y~. , data=train_data , nvmax = feature_limit )


test.mse <- sapply(1:20, function(id){
  pred=predict.regsubsets(regfit.best,test_data,id)
  mse(pred,Y.test)
})


plot(seq(1:20),test.mse,xlab="Number of Features",
     ylab="Test MSE")
points(which.min(test.mse),test.mse[which.min(test.mse)],
       col="red",cex=2,pch=20)
coef(regfit.best,id=which.min(test.mse))


#My 0 beta features are 3,7,9,11,13, and 18.
#The lowest test MSE was found at 14/20 features. This is indeed the correct number of features which is encouraging (20-6). Best subset selection selected against Features 3, 7, 9, 11, 13, 18, so it did really well at finding the true underlying model!
  
 #### Part g)
 #
 #```{r fig.width=7,fig.height=5}
beta.rsqb.diffs <- sapply(1:20,function(r){
  coefi<-coef(regfit.best,id=r)
  ncoefi<-names(coefi)
  beta.est <- sapply(1:20,function(i){
    id<-sprintf("Feature_%d",i)
    if(id %in% names(coefi)){
      return(coefi[id])
    }else{
      return(0)
    }
  })
  
  return(sqrt(sum((beta-beta.est)^2)))
})
plot(seq(1:20),beta.rsqb.diffs,xlab="Number of Features",
     ylab="Root Squared Diff Of Betas")
points(which.min(beta.rsqb.diffs),beta.rsqb.diffs[which.min(beta.rsqb.diffs)],
       col="red",cex=2,pch=20)
#```
#
#The minimum value is the same as before, 14 features, however the cool thing is how much more pronounced the answer is. The dip is really strong between 13 and 14, and then stays small going out to 20.
