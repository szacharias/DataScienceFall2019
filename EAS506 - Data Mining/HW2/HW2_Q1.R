cat("\014")  
rm(list = ls()) 
setwd("C:/Users/Matthew/Documents/WorkFolder") 
library("ElemStatLearn");
library("ElemStatLearn");
library(glmnet);
library(ISLR) ;
# install.packages('glmnet')
#install.packages("pls")
# In this exercise, we will predict the number of applications received using the other variables in the College data set. 

### Part a) 
# Split the data set into a training set and a test set.  
set.seed(1)
train=sample(c(TRUE,FALSE),nrow(College),rep=TRUE)
test=(!train)
College.train=College[train,,drop=F]
College.test=College[test,,drop=F]

### Part b) 
#Fit a linear model using least squares on the training set, and report the test error obtained. 
lm.fit=lm(Apps~.,data=College.train)
summary(lm.fit)
pred=predict(lm.fit,College.test)
rss=sum((pred-College.test$Apps)^2)
tss=sum((College.test$Apps-mean(College.test$Apps))^2)
test.rsq=1-(rss/tss)
test.rsq


### Part c) 
# Fit a ridge regression model on the training set, with $\lambda$ chosen by cross-validation. Report the test error obtained. 
College.train.X=scale(model.matrix(Apps~.,data=College.train)[,-1],scale=T,center=T)
College.train.Y=College.train$Apps
College.test.X=scale(model.matrix(Apps~.,data=College.test)[,-1],
                     attr(College.train.X,"scaled:center"),
                     attr(College.train.X,"scaled:scale"))
College.test.Y=College.test$Apps
cv.out=cv.glmnet(College.train.X,College.train.Y,alpha=0)
bestlam=cv.out$lambda.min
bestlam
lasso.mod=glmnet(College.train.X,College.train.Y,alpha=0,lambda=bestlam)
pred=predict(lasso.mod,College.test.X,s=bestlam)
rss=sum((pred-College.test$Apps)^2)
tss=sum((College.test$Apps-mean(College.test$Apps))^2)
test.rsq=1-(rss/tss)
test.rsq

### Part d) 
#> Fit a lasso model on the training set, with $\lambda$ chosen by cross-validation. Report the test error obtained, along with the number of non-zero coefficient estimates. 
cv.out=cv.glmnet(College.train.X,College.train.Y,alpha=1)
bestlam=cv.out$lambda.min
bestlam

lasso.mod=glmnet(College.train.X,College.train.Y,alpha=1,lambda=bestlam)
pred=predict(lasso.mod,College.test.X,s=bestlam)

rss=sum((pred-College.test$Apps)^2)
tss=sum((College.test$Apps-mean(College.test$Apps))^2)
test.rsq=1-(rss/tss)
test.rsq

#Number of coefficients equal to 0
sum(coef(lasso.mod)[,1]==0)
names(coef(lasso.mod)[, 1][coef(lasso.mod)[, 1] == 0])

### Part e) 
# > Fit a PCR model on the training set, with M chosen by cross-validation. Report the test error obtained, along with the value of M selected by cross-validation. 
library(pls)
set.seed(1)
pcr.fit=pcr(Apps~.,data=College.train, scale=TRUE, validation="CV")
summary(pcr.fit) #lowest at M=17
pred=predict(pcr.fit,College.test,ncomp=17)
rss=sum((pred-College.test$Apps)^2)
tss=sum((College.test$Apps-mean(College.test$Apps))^2)
test.rsq=1-(rss/tss)
test.rsq



### Part f)
#> Fit a PLS model on the training set, with M chosen by cross-validation. Report the test error obtained, along with the value of M selected by cross-validation. 
library(pls)
set.seed(1)
pls.fit=plsr(Apps~.,data=College.train, scale=TRUE, validation="CV")
summary(pls.fit) #pretty much lowest at 9 comps, certainly closest to lowest there
pred=predict(pls.fit,College.test,ncomp=9)
rss=sum((pred-College.test$Apps)^2)
tss=sum((College.test$Apps-mean(College.test$Apps))^2)
test.rsq=1-(rss/tss)
test.rsq 

### Part g) 
#> Comment on the results obtained. How accurately can we predict the number of college applications received? Is there much difference among the test errors resulting from these five approaches?
#Ordinary least squares, 
#PLS regression, 
#lasso, 
#and PCR regression performed (more or less equally) best. 
#These methods ended up using the same underlying data essentially, 
#since the optimal PCR regression used the same number of underlying variables. 
#PLS regression was able to cut out a few things, 
#chosing a model that used 9 of the possible 17 components, 
#and 83% of the variance, 
#while still performing pretty much as well. 
#Interestingly the Lasso,
#while not performing quite as well, still performed pretty comparably 0.8995 vs 0.9052 (a difference of `r 0.9052 - 0.8995`). 
#The lasso though only set 3 variables to 0 (Enroll (students enrolled), 
#                                            Terminal (pct fac w/ terminal degree), 
#                                            and S.F. Ratio(student/factulty ratio)).
#It is interesting that most of the variables seem to contribute interesting information to the model. 
#Ridge regression performed the poorest at $R^2=0.84$.



