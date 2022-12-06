library(dplyr)

cdata <- read.csv("NYPD_Complaint_Data_Historic.csv") %>% mutate_all(na_if,"") %>% mutate_all(na_if,"UNKNOWN")%>% select(-Lat_Lon)

cdata$RPT_DT <- as.Date(cdata$RPT_DT, format = "%m/%d/%Y")

cdata <- subset(cdata, RPT_DT >= "2021-07-01")

valid_age <- c("<18", "18-24", "25-44", "45-64", "65+")
cdata$VIC_AGE_GROUP[!(cdata$VIC_AGE_GROUP %in% valid_age)] <- NA
cdata$SUSP_AGE_GROUP[!(cdata$SUSP_AGE_GROUP %in% valid_age)] <- NA

cdata$VIC_SEX[(cdata$VIC_SEX == "U")] <- NA
cdata$SUSP_SEX[(cdata$SUSP_SEX == "U")] <- NA

cdata <- subset(cdata, select = - c(CMPLNT_NUM, JURIS_DESC, KY_CD, OFNS_DESC, PD_CD, PD_DESC, HADEVELOPT, BORO_NM, X_COORD_CD, Y_COORD_CD))
cdata$FELONY <- (cdata$LAW_CAT_CD == "FELONY")
cdata$PARK <- !is.na(cdata$PARKS_NM)
cdata$HOUSING_DEV <- !is.na(cdata$HOUSING_PSA)
cdata$TRANSIT <- !is.na(cdata$TRANSIT_DISTRICT)



cdata <- subset(cdata, select = - c(PATROL_BORO, ADDR_PCT_CD, RPT_DT, CMPLNT_FR_TM, CMPLNT_FR_DT, CMPLNT_TO_TM, CMPLNT_TO_DT, PARKS_NM, HOUSING_PSA, TRANSIT_DISTRICT, STATION_NAME, LAW_CAT_CD))

cdata$VIC_HISPANIC <- (cdata$VIC_RACE %in% c("BLACK HISPANIC", "WHITE HISPANIC"))
cdata$SUSP_HISPANIC <- (cdata$SUSP_RACE %in% c("BLACK HISPANIC", "WHITE HISPANIC"))
cdata$VIC_RACE[cdata$VIC_RACE == "WHITE HISPANIC"] <- "WHITE"
cdata$VIC_RACE[cdata$VIC_RACE == "BLACK HISPANIC"] <- "BLACK"
cdata$SUSP_RACE[cdata$SUSP_RACE == "WHITE HISPANIC"] <- "WHITE"
cdata$SUSP_RACE[cdata$SUSP_RACE == "BLACK HISPANIC"] <- "BLACK"

cdata$JURISDICTION_CODE <- as.character(cdata$JURISDICTION_CODE)

cdata$FELONY <- as.integer(as.logical(cdata$FELONY))
cdata$PARK <- as.integer(as.logical(cdata$PARK))
cdata$HOUSING_DEV <- as.integer(as.logical(cdata$HOUSING_DEV))
cdata$TRANSIT <- as.integer(as.logical(cdata$TRANSIT))
cdata$VIC_HISPANIC <- as.integer(as.logical(cdata$VIC_HISPANIC))
cdata$SUSP_HISPANIC <- as.integer(as.logical(cdata$SUSP_HISPANIC))

#one-hot our data

library(caret)

#split the table into numbers and factors, encode the factors, merge
setAsideCD <- subset(cdata, select = c(FELONY, PARK, HOUSING_DEV, TRANSIT, VIC_HISPANIC, SUSP_HISPANIC, Latitude, Longitude))

encodeCD <- subset(cdata, select = - c(FELONY, PARK, HOUSING_DEV, TRANSIT, VIC_HISPANIC, SUSP_HISPANIC, Latitude, Longitude))

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

write.csv(cdata, "cdata.csv")
