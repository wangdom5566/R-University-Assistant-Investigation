```{r}
data$prlesson<-as.numeric(as.factor(data$practice.lesson)) ##將character轉成factor再轉成numeric，可以迅速將類別變項編碼，並方便模型運算(只有少數機器學習模型能納入字符類別變項運算，NLP的處理則是另一個邏輯)
data$practice.lesson                                       ##檢視編碼狀況
table(data$prlesson)    
data$prlesson[data$prlesson==1]<-0                         ##沒上實習課或非獎助生、學習型均編碼成0
data$prlesson[data$prlesson<4]<-0                          ##沒上實習課或非獎助生、學習型均編碼成0
data$prlesson[data$prlesson>3]<-1                          ##有上實習課(公文實習教學實習在原始問卷中未區分)

data$threshold1[is.na(data$threshold1)==TRUE]<-0           ##第一份校內工作是否是畢業門檻，餘下依此類推
data$threshold2[is.na(data$threshold2)==TRUE]<-0  
data$threshold3[is.na(data$threshold3)==TRUE]<-0
data$threshold4[is.na(data$threshold4)==TRUE]<-0

table(data$t.legitimacy4)
data$l.legitimacy1<-data.table(ifelse(data$labor1==1,0,1))*(data$prlesson)  ##獎助生有實習課合法，所以這裡是將有勞僱型倒過來編碼，成了學習型=1(TRUE)，勞僱型=0(FALSE)的狀況後*是否有實習課，取交集。
data$l.legitimacy2<-data.table(ifelse(data$labor2==1,0,1))*(data$prlesson)
data$l.legitimacy3<-data.table(ifelse(data$labor3==1,0,1))*(data$prlesson)
data$l.legitimacy4<-data.table(ifelse(data$labor4==1,0,1))*(data$prlesson)

data$t.legitimacy1<-data.table(ifelse(data$labor1==1,0,1))*(data$threshold1) ##獎助生有畢業條件合法，所以將有勞僱型倒過來編碼，成了學習型=1(TRUE)，勞僱型=0(FALSE)的狀況後*是否有畢業門檻，取交集。
data$t.legitimacy2<-data.table(ifelse(data$labor2==1,0,1))*(data$threshold2)
data$t.legitimacy3<-data.table(ifelse(data$labor3==1,0,1))*(data$threshold3)
data$t.legitimacy4<-data.table(ifelse(data$labor4==1,0,1))*(data$threshold4)

data$total.llegitimacy<-(data$l.legitimacy1+data$l.legitimacy2+
                            data$l.legitimacy3+data$l.legitimacy4)            ##總共有幾份合法的實習課獎助生工作
data$total.tlegitimacy<-(data$t.legitimacy1+data$t.legitimacy2+
                            data$t.legitimacy3+data$t.legitimacy4)            ##總共有幾分合法的畢業門檻綁獎助生工作
table(data$total.tlegitimacy)
```
