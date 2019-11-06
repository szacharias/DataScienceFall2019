#install.packages("bestglm")
library(MASS)
library(bestglm)
library(class)
set.seed(438)
#1
#data preprocess
c_bool = rep(0,length(Boston$crim))

c_bool[Boston$crim>median(Boston$crim)] = 1

c_bool


data_1 = data.frame(Boston,c_bool)

# random
train_index = sample(1:nrow(data_1), nrow(data_1)*0.8)

tester = 1:nrow(data_1)
tester

#size
testerr =  nrow(data_1)*0.8
testerr

#sort test/train data
test_index = -train_index

test_index
train_index

sorted_train = sort(train_index)
sorted_train

sorted_test = sort(test_index)
sorted_test


train_data = data_1[sorted_train,]
test_data = data_1[sorted_test,]
train_data
test_data

##### ==== LOG REGRESSION ===
#logistic regression
logistic_all = glm(c_bool ~ .-crim, data = train_data, family = binomial)
logistic_all
logistic_all_pred = predict(logistic_all, test_data)
pred_bool=rep(0,length(logistic_all_pred))
pred_bool[logistic_all_pred>0.5] = 1
mean(pred_bool == test_data$c_bool)
#0.912
logistic_all = glm(c_bool ~ .-crim-zn, data = train_data, family = binomial)
logistic_all
logistic_all = glm(c_bool ~ .-crim-rm, data = train_data, family = binomial)
logistic_all
#both 0.923


#LDA
lda_all = lda(c_bool ~ .-crim, data = train_data)
lda_pred=predict(lda_all,test_data)
mean(lda_pred$class == test_data$c_bool)
#0.882
lda_all = lda(c_bool ~ .-crim-chas-chas-lstat-nox-indus-zn, data = train_data)
lda_pred=predict(lda_all,test_data)
mean(lda_pred$class == test_data$c_bool)
#0.853


#knn


train_mod = train_data[ ,-which(names(train_data) %in% c("crim","c_bool"))]
test_mod = test_data[ ,-which(names(test_data) %in% c("crim","c_bool"))]
knn.pred = knn(train_mod, test_mod, train_data$c_bool, k = 10)
mean(knn.pred == test_data$c_bool)
#0.923  


train_mod = train_data[ ,-which(names(train_data) %in% c("crim","c_bool","zn","rm"))]
test_mod = test_data[ ,-which(names(test_data) %in% c("crim","c_bool","zn","rm"))]
knn.pred = knn(train_mod, test_mod, train_data$c_bool, k = 10)
mean(knn.pred == test_data$c_bool)
#0.892

