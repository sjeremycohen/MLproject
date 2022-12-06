library(caret)

#split the table into numbers and factors, encode the factors, merge
setAsideCD <- subset(cdata, select = c(RPT_DT, FELONY, PARK, HOUSING_DEV, TRANSIT, VIC_HISPANIC, SUSP_HISPANIC, Latitude, Longitude))

encodeCD <- subset(cdata, select = - c(RPT_DT, FELONY, PARK, HOUSING_DEV, TRANSIT, VIC_HISPANIC, SUSP_HISPANIC, Latitude, Longitude))

dummy <- dummyVars("~.",
                   data = encodeCD)
cdHot <- data.frame(predict(dummy, newdata = encodeCD))
cdHot[is.na(cdHot)] <- 0

for (i in 1:ncol(setAsideCD)){
  cdHot[ , ncol(cdHot)+1] <- setAsideCD[i]
  colnames(cdHot)[ncol(cdHot)] <- names(setAsideCD[i])
}

rm(list = c("encodeCD", "setAsideCD", "dummy"))

cdata <- cdHot
rm(cdHot)

write.csv(cdata, "cdHot.csv")
