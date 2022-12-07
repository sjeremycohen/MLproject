set.seed(777)
train_pct = .7
split <- sample(c(TRUE, FALSE), nrow(cdata), replace=TRUE, prob=c(train_pct,(1-train_pct)))

cdTrain <- cdata[split,]
cdTest <- cdata[!split,]
nrow(cdTrain)
nrow(cdTest)

library(rpart)

rpart_m =rpart(FELONY ~ . ,data = cdTrain , method="class")
# 26 is the index of FELONY column
rpart_P = predict(rpart_m , newdata = cdTest[-124])
rpart_P <- ifelse(rpart_P > 0.5,1,0) # Probability check
CM= table(cdTest[,124] , logit_P)
print(CM)
err_metric(CM)



library(rattle)
library(rpart.plot)
library(RColorBrewer)
fancyRpartPlot(rpart_m)
