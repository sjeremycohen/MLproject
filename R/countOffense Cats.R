library("ggplot2")

labelNames <- unique(as.numeric(offenseCatCount))
labelNums <- as.numeric(offenseCatCount)

df <- data.frame(name=c(labelNames), val=c(labelNums))

ggplot(df, aes(x=name, y=val)) +
  geom_bar(stat="identity") +
  xlab("LAW_CAT_CD count") +
  ylab("Frequency")
