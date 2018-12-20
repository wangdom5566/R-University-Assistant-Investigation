install.packages("tidyverse")
install.packages("ggplot2")
library(ggplot2)
setwd("/Users/christinesfkao/R-University-Assistant-Investigation/student-workers/")
data = read.csv("data.csv")

ggplot(data, aes(x = data$totalrev, fill = data$grad)) 

#totalrev
hist(data$totalrev[data$grad == FALSE], col = rgb(1, 0, 0, 0.5), xlim = c(0, 50000), ylim = c(0, 120),
     main = "Histogram of Total Revenue", xlab = "NTD $", ylab = "Persons", breaks = 20)
hist(data$totalrev[data$grad == TRUE], col = rgb(0, 0, 1, 0.5), breaks = 20, add = TRUE)

hist(data$totalrev[data$school == "public"], col = rgb(0, 0, 1, 0.5), xlim = c(0, 50000), ylim = c(0, 120),
     main = "Histogram of Total Revenue", xlab = "NTD $", ylab = "Persons", breaks = 20)
hist(data$totalrev[data$school == "private"], col = rgb(0, 1, 0, 0.5), breaks = 20, add = TRUE)

hist(data$totalrev[data$region == "north"], col = rgb(0.7, 0, 0, 0.5), xlim = c(0, 50000), ylim = c(0, 120),
     main = "Histogram of Total Revenue", xlab = "NTD $", ylab = "Persons", breaks = 20)
hist(data$totalrev[data$region == "south"], col = rgb(0, 0.7, 0, 0.5), breaks = 20, add = TRUE)
hist(data$totalrev[data$region == "central"], col = rgb(0, 0, 1, 0.5), breaks = 20, add = TRUE)
hist(data$totalrev[data$region == "others"], col = rgb(1, 0, 0, 0.5), breaks = 20, add = TRUE)
hist(data$totalrev[data$region == "east"], col = rgb(0, 0, 0.7, 0.5), add = TRUE)

#totalexp
hist(data$totalexp[data$grad == FALSE], col = rgb(1, 0, 0, 0.5), xlim = c(0, 100000), ylim = c(0, 250),
     main = "Histogram of Total Expenses", xlab = "NTD $", ylab = "Persons", breaks = 20)
hist(data$totalexp[data$grad == TRUE], col = rgb(0, 0, 1, 0.5), breaks = 20, add = TRUE)

hist(data$totalexp[data$school == "public"], col = rgb(0, 0, 1, 0.5), xlim = c(0, 100000), ylim = c(0, 250),
     main = "Histogram of Total Expenses", xlab = "NTD $", ylab = "Persons", breaks = 20)
hist(data$totalexp[data$school == "private"], col = rgb(0, 1, 0, 0.5), add = TRUE)

hist(data$totalexp[data$region == "north"], col = rgb(0.7, 0, 0, 0.5), xlim = c(0, 100000), ylim = c(0, 250),
     main = "Histogram of Total Expenses", xlab = "NTD $", ylab = "Persons", breaks = 20)
hist(data$totalexp[data$region == "south"], col = rgb(0, 0.7, 0, 0.5), breaks = 20, add = TRUE)
hist(data$totalexp[data$region == "central"], col = rgb(0, 0, 1, 0.5), add = TRUE)
hist(data$totalexp[data$region == "others"], col = rgb(1, 0, 0, 0.5), add = TRUE)
hist(data$totalexp[data$region == "east"], col = rgb(0, 0, 0.7, 0.5), add = TRUE)

#totalwhr

hist(data$totalwhr[data$grad == FALSE], col = rgb(1, 0, 0, 0.5), xlim = c(0, 250), ylim = c(0, 100),
     main = "Histogram of Total Working Hours", xlab = "Hours per month", ylab = "Persons", breaks = 20)
hist(data$totalwhr[data$grad == TRUE], col = rgb(0, 0, 1, 0.5), breaks = 20, add = TRUE)

hist(data$totalwhr[data$school == "藍色是功力難度、public"], col = rgb(0, 0, 1, 0.5), xlim = c(0, 250), ylim = c(0, 100),
     main = "Histogram of Total Working Hours", xlab = "Hours per month", ylab = "Persons", breaks = 20)
hist(data$totalwhr[data$school == "private"], col = rgb(0, 1, 0, 0.5), breaks = 20, add = TRUE)

hist(data$totalwhr[data$region == "north"], col = rgb(0.7, 0, 0, 0.5), xlim = c(0, 250), ylim = c(0, 100),
     main = "Histogram of Total Working Hours", xlab = "Hours per month", ylab = "Persons", breaks = 20)
hist(data$totalwhr[data$region == "south"], col = rgb(0, 0.7, 0, 0.5), breaks = 20, add = TRUE)
hist(data$totalwhr[data$region == "central"], col = rgb(0, 0, 1, 0.5), breaks = 20, add = TRUE)
hist(data$totalwhr[data$region == "others"], col = rgb(1, 0, 0, 0.5), breaks = 20, add = TRUE)
hist(data$totalwhr[data$region == "east"], col = rgb(0, 0, 0.7, 0.5), add = TRUE)
紅色

+ 
  geom_histogram(breaks=seq(20, 50, by = 2), 
                 col="red", 
                 fill="green", 
                 alpha = .2) + 
  labs(title="Histogram for Total Revenue") +
  labs(x="NTD $", y="Count") + 
  xlim(c(0,50000)) + 
  ylim(c(0,120))