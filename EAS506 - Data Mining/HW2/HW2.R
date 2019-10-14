#HW2

install.packages("ISLR")
library(ISLR) 

help(ISLR)
?College
head(College)
write.csv(College, file = "College.csv")