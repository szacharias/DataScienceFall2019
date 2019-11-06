
rm(list = ls()) 
#install.packages("bestglm")
#library(MASS)
library(bestglm)
#library(class)
set.seed(1)
x=rnorm(100)
y=x-2*x^2+rnorm(100)

x2=x^2
x3=x^3
x4=x^4


#LOOCVfrombestglm
LOOCV(as.matrix(x),as.matrix(y))
# 7.288162 16.662385

df=data.frame(x2,x)
LOOCV(df,as.matrix(y))
# 0.9374236 1.1941645

df=data.frame(x3,x2,x)
LOOCV(df,as.matrix(y))
# 0.9566218 1.2081650

df=data.frame(x4,x3,x2,x)
LOOCV(df,as.matrix(y))
# 0.9539049 1.1930592
