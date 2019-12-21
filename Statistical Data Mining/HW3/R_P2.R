library(MASS)
library(bestglm)
library(class)
 
data_2_a = data_2[ ,which(names(data_2) %in% c("V5","V6","V7","V8","V9","V10"))]
pairs(data_2_a[1:5])
cols <- character(nrow(data_2_a))
cols[]<-"black"
cols[data_2_a$V10 == 3] <- "blue"
cols[data_2_a$V10 == 2] <- "red"
pairs(data_2_a[1:5],col=cols)


lda_2 = lda(V10 ~ . , data = data_2_a)
lda_2_pred=predict(lda_2,data_2_a)
mean(lda_2_pred$class == data_2_a$V10)

qda_2 = qda(V10 ~ . , data = data_2_a)
qda_2_pred=predict(qda_2,data_2_a)
mean(qda_2_pred$class == data_2_a$V10)

V5=c(0.98)
V6=c(122)
V7=c(544)
V8=c(186)
V9=c(184)
df=data.frame(V5,V6,V7,V8,V9)
predict(qda_2,df)
#3
predict(lda_2,df)
#2