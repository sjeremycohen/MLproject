library(scales)

ncols <- ncol(crimeData)
nrows <- nrow(crimeData)
blanksTable <- matrix(rep(0, times=((ncols+1)*2)), ncol=ncols+1, byrow=TRUE)
colnames(blanksTable) <- c(names(crimeData), "Grand Total")
rownames(blanksTable) <- c("Data","NA")
naTotal <- 0

for (i in 1:ncols) {
  naSum <- sum(is.na(crimeData[,i]))
  naTotal <- naTotal + naSum
  blanksTable[2,i] <- percent(naSum/nrows, accuracy = 0.001)
  blanksTable[1,i] <- percent(1 - (naSum/nrows), accuracy = 0.001)
}
blanksTable[2,(ncols+1)] <- percent(naTotal/(nrows*ncols), accuracy = 0.001)
blanksTable[1,(ncols+1)] <- percent(1-(naTotal/(nrows*ncols)), accuracy = 0.001)
