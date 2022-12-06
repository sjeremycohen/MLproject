set.seed(777)
split <- sample(c(TRUE, FALSE), nrow(cdata), replace=TRUE, prob=c(.05,.95))

cdTrain <- cdata[split,]
cdTest <- cdata[!split,]
#rm(cdata)
