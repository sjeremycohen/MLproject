library("FactoMineR")
library("factoextra")


quant_extra =
cdMCA <- subset(crimeDataTrim, select = - c(Latitude, Longitude, CMPLNT_FR_DT, CMPLNT_FR_TM, CMPLNT_TO_DT, CMPLNT_TO_TM, RPT_DT, FELONY, PARK, HOUSING_DEV, TRANSIT, VIC_HISPANIC, SUSP_HISPANIC))

res.famd <- FAMD(crimeDataTrim, graph = FALSE, sup.var = 13)

#we have to reconstruct the row data...
cd.rec <- reconst()

eig <- get_eigenvalue(res.mca)
fviz_mca_biplot(res.mca, repel = TRUE, ggtheme = theme_minimal())
lapply(res.mca$var, write, "pca_var.txt", append = FALSE)
write.csv(res.mca$var, "res_mca.csv")
class(res.mca$var)

