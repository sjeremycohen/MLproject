set.seed(1)
library(caret)
trctrl <- trainControl(method = "cv", number = 10)
knn_fit <- train(FELONY ~., data = cdTrain, method = "knn",
                 trControl=trctrl,
                 preProcess = c("center", "scale"),
                 tuneLength = 10)
knn_tP <- predict(knn_fit, newdata = cdTest[-124])
knn_P <- ifelse(knn_P > 0.5,1,0) # Probability check
CM= table(cdTest[,124] , knn_P)
print(CM)
err_metric(CM)

library(pROC)
roc_score=roc(cdTest[,13], knn_P) #AUC score
plot(roc_score ,main ="ROC curve -- Logistic Regression ")
print(roc_score$auc)
