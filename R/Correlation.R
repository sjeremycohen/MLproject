library(chron)

crimeDataNum <- subset(crimeData, select=c(2:5, 7, 22:23, 28:29))
CDCorr <- crimeDataNum
ncols <- ncol(crimeDataNum)
CDCorr$CMPLNT_FR_DT <- as.numeric(CDCorr$CMPLNT_FR_DT)
CDCorr$CMPLNT_TO_DT <- as.numeric(CDCorr$CMPLNT_TO_DT)
CDCorr$RPT_DT <- as.numeric(CDCorr$RPT_DT)

crimeCorr <- cor(CDCorr, use="pairwise.complete.obs")
print(crimeCorr)

my_palette <- rev(heat.colors(100))
my_palette[1:5] <- "#999999"
heatmap(crimeCorr, Rowv = NA, Colv = "Rowv", symm = TRUE, revC = FALSE, col=my_palette)
gradientLegend(valRange=c(0,1),my_palette[5:length(my_palette)], pos=c(0.1,0.9,0,0.3), coords=TRUE)
