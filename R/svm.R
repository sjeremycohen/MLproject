library(e1071)
svm_m = svm(FELONY ~ . ,data =cdTrain ,probability=TRUE, kernel = "linear")
summary(svm_m)
svm_P = predict(svm_m , newdata = cdTest[-124] ,type = 'response' )
svm_P <- ifelse(svm_P > 0.5,1,0) # Probability check
CM= table(cdTest[,124] , svm_P)
print(CM)
err_metric(CM)

#ROC-curve using pROC library
library(pROC)
roc_score=roc(cdTest[,13], svm_P) #AUC score
plot(roc_score ,main ="ROC curve -- Logistic Regression ")
print(roc_score$auc)
