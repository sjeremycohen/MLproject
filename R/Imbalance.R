classCount <- 3
nrows <- nrow(crimeData)
catCount <- table(crimeData$LAW_CAT_CD)

for (i in 1:classCount){
  if (catCount[[i]] > (nrows * (2/classCount)) | catCount[[i]] < (nrows / (2*classCount))) {
    print(names(catCount[i]))
  }
}
