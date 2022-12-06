library("ggplot2")
library("dplyr")

catCount <- table(crimeData$LAW_CAT_CD)
labelNames <- names(catCount)
labelNums <- as.numeric(catCount)
df <- data.frame(name=c(labelNames), val=c(labelNums))

ggplot(df, aes(x=name, y=val)) +
  geom_bar(stat="identity") +
  ggtitle("Offense Category Counts") +
  xlab("Category") +
  ylab("Frequency")


labelNames <- names(catCount)
labelNums <- as.numeric(catCount)

df <- data.frame(name=c(labelNames), val=c(labelNums))

ggplot(df, aes(x=name, y=val)) +
  geom_bar(stat="identity") +
  ggtitle("Offense Category Counts") +
  xlab("Category") +
  ylab("Frequency")
