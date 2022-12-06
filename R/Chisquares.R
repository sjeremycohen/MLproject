#chi square testing loops
library(dplyr)
library(rcompanion)
library(tidyverse)
library(graphics)
library(plotfunctions)

crimeDataOrd <- subset(crimeData, select=c(6, 8:21, 24:27, 30:34))
crimeDataOrd <- crimeDataOrd %>% mutate_all(na_if,"")
ncols <- ncol(crimeDataOrd)

#Build an empty matrix
ordTable <- matrix(rep(0, times=(ncols^2)), ncol=ncols, byrow=TRUE)
rownames(ordTable) <- names(crimeDataOrd)
colnames(ordTable) <- names(crimeDataOrd)

#Calculate all Cramer's Vs
for (i in 1:(ncols-1)){
  for (j in (i+1):ncols){
    print (paste("Calculating: ", i, j))
    tempTable <- table(crimeDataOrd[,i], crimeDataOrd[,j])

    #This pair of loops ensures any tabulation that would be 0 is 1 instead.
    #Chi-Square uses row and column totals as denominator - we want to avoid this otherwise we get NaN.
    #In such a large dataset, 1 makes almost no difference to the calculations

    for (x in 1:(nrow(tempTable))) {
      tempRowSums <- rowSums(tempTable)
      if (as.numeric(tempRowSums[x]) == 0){
        tempTable[x,1] <- 1
      }
    }
    for (y in 1:(ncol(tempTable))) {
      tempColSums <- colSums(tempTable)
      if (as.numeric(tempColSums[y]) == 0){
        tempTable[1,y] <- 1
      }
    }

    tempCramer <- cramerV(tempTable)
    ordTable[i,j] <- tempCramer
  }
}

my_palette <- rev(heat.colors(100))
my_palette[1] <- "#999999"
heatmap(ordTable, Rowv = NA, Colv = "Rowv", symm = TRUE, revC = FALSE, col=my_palette)
gradientLegend(valRange=c(0,1),my_palette[2:length(my_palette)], pos=c(0.1,0.9,0,0.3), coords=TRUE)

