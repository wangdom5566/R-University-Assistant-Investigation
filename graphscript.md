## 試繪圖1
各地區扣除學雜費支出累積機率密度圖<https://drive.google.com/file/d/1OtndrUYkzI6-3wKHRiqW-InGTcgy3PXF/view?usp=sharing>
## 繪圖指令

 ```{r}
#dataE是目前最新版本的"新增公私立+區域變項"的google雲端試算表工作表九，以下指令
#試繪累積機率密度圖("density")、累積次數圖(histogram)，以詳細資料分布情形取代柱狀圖。

library(ggplot2)

#各地區扣除學雜費支出累積機率密度圖、累積次數圖
qplot(dataE$expense,data = dataE,geom=c("histogram"),facets = region~.,fill = region)
qplot(dataE$expense,data = dataE,geom=c("density"),facets = region~.,fill = region)

#公私立學校學生扣除學雜費支出累積機率密度圖、累積次數圖
qplot(dataE$expense,data = dataE,geom=c("density"),facets = school~.,fill = school)
qplot(dataE$expense,data = dataE,geom=c("histogram"),facets = school~.,fill = school)

 ```


