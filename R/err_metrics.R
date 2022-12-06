err_metric=function(CM)
{
  TN =CM[1,1]
  TP =CM[2,2]
  FP =CM[1,2]
  FN =CM[2,1]
  precision =(TP)/(TP+FP)
  specificity_score = (TN) / (TN + FP)
  recall_score =(FP)/(FP+TN)
  f1_score=2*((precision*recall_score)/(precision+recall_score))
  accuracy_model  =(TP+TN)/(TP+TN+FP+FN)
  False_positive_rate =(FP)/(FP+TN)
  False_negative_rate =(FN)/(FN+TP)
  print(paste("Accuracy of the model: ",round(accuracy_model,2)))
  print(paste("Specificity value of the model: ",round(specificity_score,2)))
  print(paste("Precision value of the model: ",round(precision,2)))
  print(paste("Recall/Sensitivity value of the model: ",round(recall_score,2)))
}
