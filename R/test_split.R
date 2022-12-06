set.seed(1)
train_pct = .05
split <- sample(c(TRUE, FALSE), nrow(cdata), replace=TRUE, prob=c(train_pct,(1-train_pct)))

cdTrain <- cdata[split,]
cdTest <- cdata[!split,]
#rm(cdata)
