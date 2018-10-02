setwd("/Users/christinesfkao/Desktop")
data = read.csv("assistant.csv")
analysis = data[-c(1:4),-c(15:200)] # delete the first four rows
analysis = analysis[,-1]
undergrad = analysis[which(analysis$學級 == '大學部')]
graduate =

  which(analysis$學級 == "大學部")


data2 = read.csv("new.csv")
ana2 = data2[-c(1:4), -c(1, 3, 4, 90)]
ana2 = ana2[,-c(14:86)]
names(ana2) = c('grad', 'ex-tuition', 'ex-other', 'ex-rent', 'in-scholarship', 'in-tuition', 'in-home', 'debt', 'work', 'worknum', 'region', 'pubpriv')

setwd("/Users/christinesfkao/Desktop")
data = read.csv("data.csv")
data = data[-c(820:870)]
summary(data)
