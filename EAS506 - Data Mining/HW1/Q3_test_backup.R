
# ====== test =======
zip_testY <- subset( zip.test, select = 1) 
zip_testX <- subset( zip.test, select = -1)



test_fit = lm(zip_testX~zip_testY)


predict(test_fit, data.frame(zip_testX))


summary(test_fit$fitted.values)


fm = lm(zip_testY~ ., data.frame(zip_testX))


fmSum <-summary(test_fit$fitted.values)

lm.test.pred <- round(predict(test_fit, newdata=data.frame(zip_testX)))

lm.test.pred

lm.test.err <- mean(zip_testX[,1] != zip_testX)

lm.test.err


