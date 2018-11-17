## 試繪圖1
各地區扣除學雜費支出累積機率密度圖<https://drive.google.com/file/d/1OtndrUYkzI6-3wKHRiqW-InGTcgy3PXF/view?usp=sharing>
## 繪圖指令

 ```{r}
# 長條圖
公私立學校 <- c("public", "private")
國私立大學 <- c("國立", "私立")
expense <- c(17047, 20084)
Z <- cbind(公私立學校, expense, 國私立大學)
M <- as.data.frame(Z)
color <- c(1, 2)
M2 <- cbind(M2, color)
ggplot(M2, aes(國私立大學, 每月平均總支出, fill = 國私立大學)) + geom_bar(stat = "identity", 
    colour = "black") + ggtitle("國私立大學學生月總支出對比") + theme_grey(base_size = 13) + 
    theme(plot.background = element_rect(fill = "grey80", colour = NA)) + 
    geom_text(aes(label = 每月平均總支出), position = position_dodge(0.8), 
        vjust = 0)
ggsave("D:/acadamia sinica/R.university/school.bar.png")

# 盒鬚圖

summary.factor(dataCD$school)
dataCD$school[dataCD$school == "private"] <- "私立"
dataCD$school[dataCD$school == "public"] <- "國立"
dataCD$學校 <- dataCD$school
ggplot(dataCD, aes(x = 學校, y = totalexp, fill = 學校)) + geom_boxplot() + 
    xlab("類別") + ylab("每月平均總支出") + ggtitle("大學學生月總支出盒鬚圖") + 
    theme(plot.background = element_rect(fill = "grey80", colour = NA))
ggsave("D:/acadamia sinica/R.university/school.density.png")


# 累積機率密度圖or累積次數分配圖
qplot(dataCD$totalexp, data = dataCD, geom = c("density"), facets = 學校 ~ 
    ., fill = 學校) + xlab("每月平均總支出") + ylab("國私立大學") + ggtitle("累積機率密度圖") + 
    theme(plot.background = element_rect(fill = "grey80", colour = NA))
ggsave("D:/acadamia sinica/R.university/school.density1.png")

# 扣學雜費
ggplot(dataCD, aes(x = 學校, y = expense, fill = 學校)) + geom_boxplot() + 
    xlab("國私立大學") + ylab("每月平均生活費及租金") + ggtitle("大學生生活費及租金盒鬚圖") + 
    theme(plot.background = element_rect(fill = "grey80", colour = NA))
ggsave("D:/acadamia sinica/R.university/school.boxplot2.png")

# 累積機率密度圖or累積次數分配圖
qplot(dataCD$expense, data = dataCD, geom = c("density"), facets = 學校 ~ 
    ., fill = 學校) + xlab("每月平均生活費及租金") + ylab("國私立大學") + 
    ggtitle("累積機率密度圖") + theme(plot.background = element_rect(fill = "grey80", 
    colour = NA))
ggsave("D:/acadamia sinica/R.university/school.density2.png")


# 地區
summary.factor(dataCD$region)
dataCD$region[dataCD$region == "central"] <- "中部"
dataCD$region[dataCD$region == "east"] <- "東部"
dataCD$region[dataCD$region == "north"] <- "北部"
dataCD$region[dataCD$region == "外離島和其他"] <- "離島和其他"
dataCD$region[dataCD$region == "south"] <- "南部"
dataCD$地區 <- dataCD$region
qplot(dataCD$expense, data = dataCD, geom = c("density"), facets = 地區 ~ 
    ., fill = 地區) + xlab("生活費及租金") + ylab("各地區") + ggtitle("大學各地區生活費及租金對比") + 
    theme_grey(base_size = 13) + theme(plot.background = element_rect(fill = "grey80", 
    colour = NA))
ggsave("D:/acadamia sinica/R.university/density3.png")

# 研究生
summary.factor(dataCD$grad)
dataCD$研究生 <- dataCD$grad
dataCD$研究生[dataCD$研究生 == "TRUE"] <- "研究生"
dataCD$研究生[dataCD$研究生 == "FALSE"] <- "大學生"
qplot(dataCD$expense, data = dataCD, geom = c("density"), facets = 研究生 ~ 
    ., fill = 研究生) + xlab("每月平均生活費及租金") + ylab("是否是研究生") + 
    ggtitle("大學與研究生生活費及租金對比") + theme_grey(base_size = 13) + 
    theme(plot.background = element_rect(fill = "grey80", colour = NA))
ggsave("D:/acadamia sinica/R.university/grad.density.png")

# 是否是研究生盒鬚圖
ggplot(dataCD, aes(x = 研究生, y = expense, fill = 研究生)) + geom_boxplot() + 
    xlab("是否是研究生") + ylab("每月平均生活費及租金") + ggtitle("生活費及租金盒鬚圖") + 
    theme_grey(base_size = 13) + theme(plot.background = element_rect(fill = "grey80", 
    colour = NA))
ggsave("D:/acadamia sinica/R.university/grad.boxplot.png")

# 盒鬚圖
qplot(dataCD$expense, data = dataCD, geom = c("density"), facets = 研究生 ~ 
    ., fill = 研究生) + xlab("每月平均生活費及租金") + ylab("是否是研究生") + 
    ggtitle("大學與研究生生活費及租金對比") + theme_grey(base_size = 13) + 
    theme(plot.background = element_rect(fill = "grey80", colour = NA))
ggsave("D:/acadamia sinica/R.university/grad.density.png")


# 
ggplot(dataCD, aes(x = school, y = totalexp)) + geom_boxplot() + xlab("國私立大學") + 
    ylab("每月平均總支出") + ggtitle("國私立大學學生月總支出盒鬚圖")

table(dataCM$work.school)
qplot(dataCD$totalworknum, data = dataCD, geom = c("density"), facets = school ~ 
    ., fill = school) + xlab("生活費及租金") + ylab("各地區")
ggtitle("大學各地區生活費及租金對比") + theme_bw()

ggplot(M2, aes(國私立大學, 每月平均總支出, fill = 國私立大學)) + geom_bar(stat = "identity", 
    colour = "black") + ggtitle("國私立大學學生月總支出對比") + theme_grey(base_size = 13) + 
    theme(plot.background = element_rect(fill = "grey80", colour = NA)) + 
    geom_text(aes(label = 每月平均總支出), position = position_dodge(0.8), 
        vjust = 0)
ggsave("D:/acadamia sinica/R.university/school.bar.png")

lm1 <- rlm(dataCD$totalrev ~ dataCD$totalwhr + dataCD$totalwage + dataCD$totalexp, 
    data = dataCD)
lmvalue <- fitted.values(lm1)

dataCD$lm1 <- lmvalue

ggplot(dataCD, aes(x = dataCD$lmvalue, y = dataCD$totalrev, color = 地區, 
    shape = 地區)) + geom_point() + geom_smooth(method = lm, aes(fill = 地區)) + 
    theme_grey(base_size = 13) + theme(plot.background = element_rect(fill = "grey80", 
    colour = NA))
ggsave("D:/acadamia sinica/R.university/region.lm.png")
 ```


