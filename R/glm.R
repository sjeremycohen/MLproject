logit_m =glm(FELONY ~ . ,data =cdTrain ,family='binomial')
summary(logit_m)
# 124 is the index of FELONY column
logit_P = predict(logit_m , newdata = cdTest[-124] ,type = 'response' )
logit_P <- ifelse(logit_P > 0.5,1,0) # Probability check
CM= table(cdTest[,124] , logit_P)
print(CM)
err_metric(CM)

#ROC-curve using pROC library
library(pROC)
roc_score=roc(cdTest[,13], logit_P) #AUC score
plot(roc_score ,main ="ROC curve -- Logistic Regression ")
print(roc_score$auc)
