
rm(list = ls()) 
setwd("C:/Users/Matthew/Documents/WorkFolder") 

ls("package:ElemStatLearn")

 
y2or3 <- which(zip.test[, 1] == 2 | zip.test[, 1] == 3)
zip.test.train <- zip.test[y2or3, -1]
y.train <- zip.test[y2or3, 1] == 3

#Test file as input
zip.test <- as.matrix(read.table(gzfile("zip.test.gz")))
y2or3 <- which(zip.test[, 1] == 2 | zip.test[, 1] == 3)
zip.test.test <- zip.test[y2or3, -1]
y.test <- zip.test[y2or3, 1] == 3
