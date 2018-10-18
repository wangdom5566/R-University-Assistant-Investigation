調查的goolge表單<https://docs.google.com/document/d/1fesNHiSL8kvDLjwFaX88LhOXgDaxou4nd3imDH_Vipc/edit>
表單九是清完資料的試算表<https://docs.google.com/spreadsheets/d/1Kmw9Fo7zHbbQD9IoBIy89VGWkOvKPuTo79IPYu1xBX0/edit#gid=1057143170>
R版本資訊摘要

## R版本與中文亂碼解決

- R version       3.5.0  (2018-04-23)
- Rstudio version 1.1.447(2018-04-18)
  - 印象中Rstudio2017的某個版本起，支援big5編碼，UTF-8跟big5的讀檔方式些許不同，資料匯入是介紹UTF-8的讀取。
  Platform: x86_64-w64-mingw32/x64 (64-bit)
  Running under: Windows >= 8 x64 (build 9200)

- locale(執行背景預設語系):
  - [1] LC_COLLATE=Chinese (Traditional)_Taiwan.950  LC_CTYPE=Chinese (Traditional)_Taiwan.950   
  - [3] LC_MONETARY=Chinese (Traditional)_Taiwan.950 LC_NUMERIC=C                                
  - [5] LC_TIME=Chinese (Traditional)_Taiwan.950    
  - 相關中文編碼問題可參考<https://github.com/dspim/R/wiki/R-&-RStudio-Troubleshooting-Guide>
- attached base packages:
  - [1] stats     graphics  grDevices utils     datasets  methods   base     

  - other attached packages:
    - [1] RevoUtils_11.0.0     RevoUtilsMath_11.0.0

  - loaded via a namespace (and not attached):
    - [1] compiler_3.5.0 tools_3.5.0    rpart_4.1-13   XML_3.98-1.11 
    - (rpart跟XML要另外裝，但大學兼任助理調查分析，不需要這兩個套件)

## 資料匯入

- google表單下載csv後，更新至以上版本，則不需要特別指定編碼，即可匯入UTF-8編碼的csv中文表格。
  - ulabor是google表單未轉成big5編碼，原始的utf-8檔案；而investigation則是刪除前4欄測試樣本。
  - 其code如下。

```{r}
>library(readr)
>ulabor <- read_csv("D:/universitylabor.csv")
>investigation <- ulabor[(-c(1:4),]  # 將前4欄測試填答樣本刪除
>investigation[] <- lapply(investigation, factor) # 將character變數轉成factor變數，以利進一步編碼
# 以下是R自動編碼，將factor變數轉為數值，原有factor中文變數資料，可以做為編碼簿。
>investigation[, c(1:86)] <- sapply(investigation[, c(1:86)], as.numeric)

```

## 進一步編碼
```{r}
# 進一步分析要逐一確認序數、虛擬變數、
# 甚至連續變數跟其他類答題混在一起的狀況，如以下：

>investigation$學級 = factor(investigation$學級,
+                    levels = c('其他','大學部', '碩士班', '博士班'),
+                    labels = c(999, 1,2,3))

可能需要對這份問卷作版本控制，以保留這份資料的清理編碼過程，確保序數、其他的編碼不會對分析有影響。
所以我才開github的專案，雖然我不太會用呵呵.....但就更新資料確認版本、對格式、貼程式碼之類的可能方便點。
或是乾脆將問卷拆開兩部分題組，一人負責一半編碼。

```

## 921新編碼，本來想寫成腳本，但想想可能會有MAC、Linux不一定相容的問題，就只先更新MD檔
## google雲端試算表更新如下，可以下載csv來跑底下的腳本，但MAC和Linux或許得修改部分指令。
<https://docs.google.com/spreadsheets/d/1Kmw9Fo7zHbbQD9IoBIy89VGWkOvKPuTo79IPYu1xBX0/edit#gid=84061454>

```{r}

變數說明：rev1-rev4     是第1至4份校內工作。
         workhour      是第1至4份校內工作工時。
         ofcrev~ofcrev4是第1至4份校外工作。
         ofcwhr~ofcwhr4是第1至4份校外工作工時。

```

## 腳本如下

```{r}

#以下是讀取BIG5方法，但或許從我更新的GOOGLE試算表下載會比較少問題。
#library(readr)
#investigation1015 <- read_csv("D:/investigation1015.csv", 
#                          locale = locale(encoding = "BIG5"))
#View(investigation1015)


#在D槽讀取investigation1015csv檔，
#把NA轉成0利於變項合併

investigation1015[is.na(investigation1015)] <- 0  

#據實際情況修改樣本資料：填答的工作份數與後續問題填答數不符者
#表單上僅填答 1 份校內工作但與原填寫「校內工作份數」不符，故修正為「1 份校內工作」：
#第 25, 130, 232, 246, 260, 269, 277, 301, 315, 329, 332, 450, 578, 591, 786 列。
#表單上填答了 2 份校內工作但與原填寫「校內工作份數」不符，故修正為「2 份校內工作」：

#第 20, 32, 115, 163, 171, 177, 189, 212, 225, 243, 268, 276, 328, 351, 363, 372, 
#379, 381, 437, 470, 481, 505, 514, 548, 552, 565, 590, 698, 725, 742, 753, 755, 764, 
#775, 784, 793, 798 列。

#表單上填答了 3 份校內工作但與原填寫「校內工作份數」不符，故修正為「3 份校內工作」：
#第 58, 153, 216, 312, 354, 473, 492, 506, 507 列。

#表單上填答了 4 份校內工作但與原填寫「校內工作份數」不符，故修正為「4 份校內工作」：
#第 228, 511, 715 列。

#表單上填答了 4 份校內工作但因選項上限僅有 4 份，而在填答完第四份工作後，該樣本「仍
#有其他校內工作」，故應至少有 5 份校內工作，修正為「5 份校內工作」：第 138, 615 列

investigation1015[24,11] <- 1
investigation1015[129,11] <- 1
investigation1015[231,11] <- 1
investigation1015[245,11] <- 1
investigation1015[259,11] <- 1
investigation1015[268,11] <- 1
investigation1015[276,11] <- 1
investigation1015[300,11] <- 1
investigation1015[314,11] <- 1
investigation1015[328,11] <- 1
investigation1015[331,11] <- 1
investigation1015[449,11] <- 1
investigation1015[577,11] <- 1
investigation1015[590,11] <- 1
investigation1015[785,11] <- 1


investigation1015[19,11] <- 2
investigation1015[31,11] <- 2
investigation1015[114,11] <- 2
investigation1015[162,11] <- 2
investigation1015[170,11] <- 2
investigation1015[176,11]  <- 2
investigation1015[188,11] <- 2
investigation1015[211,11] <- 2
investigation1015[224,11] <- 2
investigation1015[242,11] <- 2
investigation1015[267,11] <- 2
investigation1015[275,11] <-2
investigation1015[327,11] <-2
investigation1015[350,11] <-2
investigation1015[362,11] <-2
investigation1015[371,11] <-2

#379, 381, 437, 470, 481, 505, 514, 548, 552, 565, 590, 698, 725, 742, 753, 
investigation1015[378,11] <-2
investigation1015[380,11] <-2
investigation1015[436,11] <-2
investigation1015[470,11] <-2
investigation1015[480,11] <-2
investigation1015[504,11] <-2
investigation1015[513,11] <-2
investigation1015[547,11] <-2
investigation1015[551,11] <-2
investigation1015[564,11] <-2
investigation1015[589,11] <-2
investigation1015[697,11] <-2
investigation1015[724,11] <-2
investigation1015[741,11] <-2
investigation1015[752,11] <-2
#755, 764, 775, 784, 793, 798 列。

investigation1015[754,11] <-2
investigation1015[763,11] <-2
investigation1015[774,11] <-2
investigation1015[783,11] <-2
investigation1015[792,11] <-2

investigation1015[797,11] <-2

investigation1015[57,11] <-3
investigation1015[152,11] <-3
investigation1015[215,11] <-3
investigation1015[311,11] <-3
investigation1015[353,11] <-3
investigation1015[472,11] <-3
investigation1015[491,11] <-3
investigation1015[505,11] <-3
investigation1015[506,11] <-3

investigation1015[227,11] <-4
investigation1015[510,11] <-4
investigation1015[714,11] <-4

investigation1015[137,11] <-5
investigation1015[616,11] <-5

investigation1 <- investigation1015[-817,]    
investigation2 <- investigation1[-809,]
investigation3 <- investigation2[-796:-798,]
investigation4 <- investigation3[-491:-504,]
investigationv <- investigation4[-1:-4,]

investigation <- subset(investigationv,work =="TRUE")


investigation$rev1[investigation$rev1=="0-2000"]   <-1000
investigation$rev1[investigation$rev1=="2001-4000"]<-3000
investigation$rev1[investigation$rev1=="4001-6000"]<-5000
investigation$rev1[investigation$rev1=="6001-8000"]<-7000
investigation$rev1[investigation$rev1=="8001-10000"]<-9000
investigation$rev1[investigation$rev1=="10001-12000"]<-11000
investigation$rev1[investigation$rev1=="12001-14000"]<-13000
investigation$rev1[investigation$rev1=="14001-16000"]<-15000
investigation$rev1[investigation$rev1=="算學期的，一學期4500"]<-900
investigation$rev1[investigation$rev1=="31000~6000都有"]<-3500
investigation$rev1[investigation$rev1=="14000-28000"]<-21000
investigation$rev1[investigation$rev1=="20000左右，不只掛一個計畫助理"]<-20000
investigation$rev1[investigation$rev1=="1000"]<-1000


investigation$rev1 <- as.numeric(investigation$rev1)
summary(investigation$rev1)
#car在recode中文上會出現問題，所以底下使用取代功能。

summary.factor(investigation$workhour1)

investigation$workhour1[investigation$workhour1=="平日幾乎每天都在實驗室裡待6~8HR"] <-140
investigation$workhour1[investigation$workhour1==">100"] <-101
investigation$workhour1[investigation$workhour1=="0-10HR"]<-5
investigation$workhour1[investigation$workhour1=="100HR以上 無法實際估計"]<-101
investigation$workhour1[investigation$workhour1=="101HR"]<-101
investigation$workhour1[investigation$workhour1=="11-20HR"]<-15
investigation$workhour1[investigation$workhour1=="1200HR"]<-NA
investigation$workhour1[investigation$workhour1=="133HR"]<-133
investigation$workhour1[investigation$workhour1=="160 Hr"]<-160
investigation$workhour1[investigation$workhour1=="160HR以上"] <-161
investigation$workhour1[investigation$workhour1=="200HR"]<-200
investigation$workhour1[investigation$workhour1=="21-30HR"]<-25
investigation$workhour1[investigation$workhour1=="31-40HR"]<-35
investigation$workhour1[investigation$workhour1=="31-50HR不等"]<-40
investigation$workhour1[investigation$workhour1=="41-50HR"]<-45
investigation$workhour1[investigation$workhour1=="51-60HR"]<-55
investigation$workhour1[investigation$workhour1=="61-70HR"]<-65
investigation$workhour1[investigation$workhour1=="71-80HR"]<-75
investigation$workhour1[investigation$workhour1=="96HR"]<-96
investigation$workhour1[investigation$workhour1=="一天八HR，一週五天"]<-160
investigation$workhour1[investigation$workhour1=="不一定，看情況(期中期末會特別忙)"]<-NA
investigation$workhour1[investigation$workhour1=="不等，看老師狀況"]<-NA
investigation$workhour1[investigation$workhour1=="包含平日，一天大約五HR，共約 150 hr"]<-150
investigation$workhour1[investigation$workhour1=="平日幾乎每天都在實驗室裡待6~8HR"]<-140
investigation$workhour1[investigation$workhour1=="因是責任制，不定時，有時候還要熬夜工作"]<-NA
investigation$workhour1[investigation$workhour1=="老師想要你做多久就做多久"]<-NA
investigation$workhour1[investigation$workhour1=="每天"]<-NA
investigation$workhour1[investigation$workhour1=="每天6HR 不包含假日"]<-120
investigation$workhour1[investigation$workhour1=="沒有實際上下班時間 自行安排時間"]<-NA
investigation$workhour1[investigation$workhour1=="看個人課表平均分配排班，我目前是一個禮拜6HR，有時有事會找代班，所以不固定"]<-NA
investigation$workhour1[investigation$workhour1=="接近全天待命"]<-NA
investigation$workhour1[investigation$workhour1=="教授需要時 至少35HR"]<-35
investigation$workhour1[investigation$workhour1=="責任制"]<-NA
investigation$workhour1[investigation$workhour1=="250HR"]<-250

investigation$workhour1 <- as.numeric(investigation$workhour1)
summary(investigation$workhour1)

summary.factor(investigation$rev2)

investigation$rev2[investigation$rev2=="0-2000"]   <-1000
investigation$rev2[investigation$rev2=="2001-4000"]<-3000
investigation$rev2[investigation$rev2=="4001-6000"]<-5000
investigation$rev2[investigation$rev2=="6001-8000"]<-7000
investigation$rev2[investigation$rev2=="8001-10000"]<-9000
investigation$rev2[investigation$rev2=="10001-12000"]<-11000
investigation$rev2[investigation$rev2=="12001-14000"]<-13000
investigation$rev2[investigation$rev2=="2月1000，3-6月4000元"]<-1000
investigation$rev2[investigation$rev2=="30HR助理，算一個學期的錢，一個學期7200而已"]<-1440
investigation$rev2[investigation$rev2=="一支影片7500"]<-NA

investigation$rev2 <- as.numeric(investigation$rev2)
summary(investigation$rev2)

summary.factor(investigation$workhour2)
investigation$ workhour2[investigation$ workhour2=="0-10HR"]<-5
investigation$ workhour2[investigation$ workhour2=="11-20HR"]<-15
investigation$ workhour2[investigation$ workhour2=="21-30HR"]<-25
investigation$ workhour2[investigation$ workhour2=="31-40HR"]<-35
investigation$ workhour2[investigation$ workhour2=="31-50HR"]<-40
investigation$ workhour2[investigation$ workhour2=="41-50HR"]<-45
investigation$ workhour2[investigation$ workhour2=="51-60HR"]<-55
investigation$ workhour2[investigation$ workhour2=="61-70HR"]<-65
investigation$ workhour2[investigation$ workhour2=="71-80HR"]<-75
investigation$ workhour2[investigation$ workhour2=="80-100"]<-90
investigation$ workhour2[investigation$ workhour2=="100HR以上 無法實際估計"]<-101
investigation$ workhour2[investigation$ workhour2=="80 HR以上吧"]<-81
investigation$ workhour2[investigation$ workhour2=="80以上"]<-81
investigation$ workhour2[investigation$ workhour2=="90hrs."]<-90
investigation$ workhour2[investigation$ workhour2=="不一定，有時候10HR，有時候因課程要求陪學生出去一次就2天1夜"]<-NA
investigation$ workhour2[investigation$ workhour2=="不定時責任制"]<-NA
investigation$ workhour2[investigation$ workhour2=="有考試才需批改考卷 不是每個月都有實際工作"]<-NA
investigation$ workhour2[investigation$ workhour2=="看效率"]<-NA
investigation$ workhour2[investigation$ workhour2=="133HR"]<-133

investigation$workhour2 <-as.numeric(investigation$workhour2)

summary(investigation$workhour2)

summary.factor(investigation$rev3)
investigation$rev3[investigation$rev3=="0-2000"]   <-1000
investigation$rev3[investigation$rev3=="2001-4000"]<-3000
investigation$rev3[investigation$rev3=="4001-6000"]<-5000
investigation$rev3[investigation$rev3=="6001-8000"]<-7000
investigation$rev3[investigation$rev3=="8001-10000"]<-9000
investigation$rev3[investigation$rev3=="12001-14000"]<-13000

investigation$rev3 <-as.numeric(investigation$rev3)
summary(investigation$rev3)

summary.factor(investigation$workhour3)
investigation$ workhour3[investigation$ workhour3=="0-10HR"]<-5
investigation$ workhour3[investigation$ workhour3=="11-20HR"]<-15
investigation$ workhour3[investigation$ workhour3=="21-30HR"]<-25
investigation$ workhour3[investigation$ workhour3=="31-40HR"]<-35
investigation$ workhour3[investigation$ workhour3=="31-50HR"]<-40
investigation$ workhour3[investigation$ workhour3=="41-50HR"]<-45
investigation$ workhour3[investigation$ workhour3=="51-60HR"]<-55
investigation$ workhour3[investigation$ workhour3=="61-70HR"]<-65
investigation$ workhour3[investigation$ workhour3=="71-80HR"]<-75

investigation$workhour3<-as.numeric(investigation$workhour3)
summary(investigation$workhour3)

summary.factor(investigation$rev4)
investigation$rev4[investigation$rev4=="2001-4000"]<-3000
investigation$rev4[investigation$rev4=="4001-6000"]<-5000
investigation$rev4[investigation$rev4=="6001-8000"]<-7000
investigation$rev4<-as.numeric(investigation$rev4)
summary(investigation$rev4)

summary.factor(investigation$workhour4)
investigation$ workhour4[investigation$ workhour4=="0-10HR"]<-5
investigation$ workhour4[investigation$ workhour4=="11-20HR"]<-15
investigation$ workhour4[investigation$ workhour4=="21-30HR"]<-25
investigation$ workhour4[investigation$ workhour4=="31-40HR"]<-35
investigation$workhour4<-as.numeric(investigation$workhour4)
summary(investigation$workhour4)

#校內工作
#labor:第一份工作是否是勞僱型助理
#contract:是否有勞動契約
#paywage:是否超過一個月以上的遲發薪

summary.factor(investigation1015$labor1)
investigation$labor1[investigation$labor1=="勞僱型助理"]<-1
investigation$labor1[investigation$labor1=="獎助生(學習型助理)"]<-0
investigation$labor1<-as.numeric(investigation$labor1)
summary(investigation$labor1)

summary.factor(investigation1015$labor2)
investigation$labor2[investigation$labor2=="勞僱型助理"]<-1
investigation$labor2[investigation$labor2=="獎助生(學習型助理)"]<-0
investigation$labor2<-as.numeric(investigation$labor2)
summary(investigation$labor2)

summary.factor(investigation1015$labor2)
investigation$labor2[investigation$labor2=="勞僱型助理"]<-1
investigation$labor2[investigation$labor2=="獎助生(學習型助理)"]<-0
investigation$labor2<-as.numeric(investigation$labor2)
summary(investigation$labor2)

summary.factor(investigation1015$labor3)
investigation$labor3[investigation$labor3=="勞僱型助理"]<-1
investigation$labor3[investigation$labor3=="獎助生(學習型助理)"]<-0
investigation$labor3<-as.numeric(investigation$labor3)
summary(investigation$labor3)

summary.factor(investigation1015$labor4)
investigation$labor4[investigation$labor4=="勞僱型助理"]<-1
investigation$labor4[investigation$labor4=="獎助生(學習型助理)"]<-0
investigation$labor4<-as.numeric(investigation$labor4)
summary(investigation$labor4)

summary.factor(investigation1015$contract1)
investigation$contract1[investigation$contract1=="是"]<-1
investigation$contract1[investigation$contract1=="否"]<-0
investigation$contract1[investigation$contract1=="不知道"]<-999
investigation$contract1<-as.numeric(investigation$contract1)
summary(investigation$contract1)

summary.factor(investigation1015$contract2)
investigation$contract2[investigation$contract2=="是"]<-1
investigation$contract2[investigation$contract2=="否"]<-0
investigation$contract2[investigation$contract2=="不知道"]<-999
investigation$contract2<-as.numeric(investigation$contract2)
summary(investigation$contract2)

summary.factor(investigation1015$contract3)
investigation$contract3[investigation$contract3=="是"]<-1
investigation$contract3[investigation$contract3=="否"]<-0
investigation$contract3[investigation$contract3=="不知道"]<-999
investigation$contract3<-as.numeric(investigation$contract3)
summary(investigation$contract3)

summary.factor(investigation1015$contract4)
investigation$contract4[investigation$contract4=="是"]<-1
investigation$contract4[investigation$contract4=="否"]<-0
investigation$contract4[investigation$contract4=="不知道"]<-999
investigation$contract4<-as.numeric(investigation$contract4)
summary(investigation$contract4)

summary.factor(investigation1015$paywage1)
investigation$paywage1[investigation$paywage1=="一個學期發放一次"]<-0
investigation$paywage1[investigation$paywage1=="下個月月底發薪"]<-0
investigation$paywage1[investigation$paywage1=="不一定，大多數是準時的，偶爾兩個月才入帳"]<-1
investigation$paywage1[investigation$paywage1=="不清楚"]<-999
investigation$paywage1[investigation$paywage1=="不清楚發放時間"]<-999
investigation$paywage1[investigation$paywage1=="不會"]<-0
investigation$paywage1[investigation$paywage1=="企劃的補助要慢慢下來，所以會拖到"]<-1
investigation$paywage1[investigation$paywage1=="我也不知道什麼時候會發，因為是一學期只給一次的錢"]<-0
investigation$paywage1[investigation$paywage1=="固定隔月15日發放，但不確定是否算拖欠"]<-0

investigation$paywage1[investigation$paywage1=="契約明文隔月發放，約在隔月10號發薪"]<-0
investigation$paywage1[investigation$paywage1=="第一個月都不發，第二個月才開始發"]<-0
investigation$paywage1[investigation$paywage1=="脫半個月"]<-0
investigation$paywage1[investigation$paywage1=="通常是以自己提報系統後經簽核始撥款，發薪日期極不穩定。"]<-1
investigation$paywage1[investigation$paywage1=="都是一個月後才會拿到"]<-0
investigation$paywage1[investigation$paywage1=="勞雇型助理最一開始認定身分有被學校刁難。"]<-1

investigation$paywage1[investigation$paywage1=="開始不到一個月的新人，還沒開始領薪"]<-0
investigation$paywage1[investigation$paywage1=="僅有一次是因為校內改制，慢了1.5個月才發放"]<-1
investigation$paywage1[investigation$paywage1=="會"]<-1
investigation$paywage1[investigation$paywage1=="會，因為學校一次核銷工讀金約需47小時時數，系辦會輪流讓工讀生領薪水"]<-1
investigation$paywage1[investigation$paywage1=="會，但是因為助理需要整批報帳，其他同學未點擊工作時數確認被拖延到"]<-1
investigation$paywage1[investigation$paywage1=="暫時還沒有，但以前被拖欠過三個月"]<-1

investigation$paywage1[investigation$paywage1=="學校核帳很慢，開學後才確定助理名額。確定後才填寫出勤紀錄，經常已經工作一個多月後才有薪水入帳。"]<-1
investigation$paywage1[investigation$paywage1=="學校統一於隔月月底發薪資"]<-1
investigation$paywage1[investigation$paywage1=="會"]<-1
investigation$paywage1[investigation$paywage1=="學習型助理是這學期四月開始受聘，還沒領到薪水。"]<-1
investigation$paywage1[investigation$paywage1=="學習型助理薪水整學期一次發放，工讀金部分按月發放未拖延"]<-0

investigation$paywage1<-as.numeric(investigation$paywage1)
summary(investigation$paywage1)


summary.factor(investigation1015$paywage2)
investigation$paywage2[investigation$paywage2=="30小時助理，算一個學期的錢。固定在學期中一次給"]<-0
investigation$paywage2[investigation$paywage2=="不清楚"]<-999
investigation$paywage2[investigation$paywage2=="不清楚發放時間"]<-999
investigation$paywage2[investigation$paywage2=="不清楚，尚未發放"]<-999
investigation$paywage2[investigation$paywage2=="不會"]<-0
investigation$paywage2[investigation$paywage2=="同上一份工作"]<-999
investigation$paywage2[investigation$paywage2=="有，不過是自己的疏失"]<-1
investigation$paywage2[investigation$paywage2=="校方要求學習型助理需繳交實習學分費1500"]<-999
investigation$paywage2[investigation$paywage2=="偶爾 須自己提報工時至系統後簽核，實際發薪日不穩定。"]<-1
investigation$paywage2[investigation$paywage2=="會"]<-1
investigation$paywage2[investigation$paywage2=="學校統一於隔月底發薪"]<-0

investigation$paywage2<-as.numeric(investigation$paywage2)
summary(investigation$paywage2)

summary.factor(investigation1015$paywage3)
investigation$paywage3[investigation$paywage3=="不會"]<-0
investigation$paywage3[investigation$paywage3=="會"]<-1
investigation$paywage3<-as.numeric(investigation$paywage3)
summary(investigation$paywage3)

summary.factor(investigation1015$paywage4)
investigation$paywage4[investigation$paywage4=="不會"]<-0
investigation$paywage4[investigation$paywage4=="會"]<-1
investigation$paywage4<-as.numeric(investigation$paywage4)
summary(investigation$paywage4)



#校外工作
#ofccontract:校外是否簽勞動契約	
#ofcins:     校外是否有保勞保	
#ofcwage:    校外是否有薪水遲發

summary.factor(investigation1015$ofccontract1)
investigation$ofccontract1[investigation$ofccontract1=="是"]<-1
investigation$ofccontract1[investigation$ofccontract1=="否"]<-0
investigation$ofccontract1[investigation$ofccontract1=="否"]<-0
investigation$ofccontract1[investigation$ofccontract1=="不知道"]<-999
investigation$ofccontract1<-as.numeric(investigation$ofccontract1)
summary(investigation$ofccontract1)

summary.factor(investigation1015$ofccontract2)
investigation$ofccontract2[investigation$ofccontract2=="是"]<-1
investigation$ofccontract2[investigation$ofccontract2=="否"]<-0
investigation$ofccontract2[investigation$ofccontract2=="不知道"]<-999
investigation$ofccontract2<-as.numeric(investigation$ofccontract2)
summary(investigation$ofccontract2)

summary.factor(investigation1015$ofccontract3)
investigation$ofccontract3[investigation$ofccontract3=="是"]<-1
investigation$ofccontract3[investigation$ofccontract3=="否"]<-0
investigation$ofccontract3<-as.numeric(investigation$ofccontract3)
summary(investigation$ofccontract3)

summary.factor(investigation1015$ofccontract4)
investigation$ofccontract4[investigation$ofccontract4=="否"]<-0
investigation$ofccontract4<-as.numeric(investigation$ofccontract4)
summary(investigation$ofccontract4)

summary.factor(investigation1015$ofcins1)
investigation$ofcins1[investigation$ofcins1=="是"]<-1
investigation$ofcins1[investigation$ofcins1=="否"]<-0
investigation$ofcins1<-as.numeric(investigation$ofcins1)
summary(investigation$ofcins1)

summary.factor(investigation1015$ofcins2)
investigation$ofcins2[investigation$ofcins2=="是"]<-1
investigation$ofcins2[investigation$ofcins2=="否"]<-0
investigation$ofcins2<-as.numeric(investigation$ofcins2)
summary(investigation$ofcins2)

summary.factor(investigation1015$ofcins3)
investigation$ofcins3[investigation$ofcins3=="是"]<-1
investigation$ofcins3[investigation$ofcins3=="否"]<-0
investigation$ofcins3<-as.numeric(investigation$ofcins3)
summary(investigation$ofcins3)


summary.factor(investigation1015$ofcins4)
investigation$ofcins4[investigation$ofcins4=="是"]<-1
investigation$ofcins4[investigation$ofcins4=="否"]<-0
investigation$ofcins4<-as.numeric(investigation$ofcins4)
summary(investigation$ofcins4)

summary.factor(investigation1015$ofcwage1)
investigation$ofcwage1[investigation$ofcwage1=="一梯（六次）發一次薪資"]<-999
investigation$ofcwage1[investigation$ofcwage1=="不會"]<-0
investigation$ofcwage1[investigation$ofcwage1=="月初第一次上班發放"]<-0
investigation$ofcwage1[investigation$ofcwage1=="以時薪計算，約兩個月給一次"]<-0
investigation$ofcwage1[investigation$ofcwage1=="因為是承攬形式的工作，論件計酬，所以沒有每個月固定發放，不過大概都完成後2個月才會收到款項。"]<-0
investigation$ofcwage1[investigation$ofcwage1=="她媽過年不發薪水的coco啦幹"]<-1
investigation$ofcwage1[investigation$ofcwage1=="服務業，依場次記酬（一場約6H/700元）並現場領薪"]<-0
investigation$ofcwage1[investigation$ofcwage1=="剛開始做不知道"]<-999
investigation$ofcwage1[investigation$ofcwage1=="會"]<-1
investigation$ofcwage1[investigation$ofcwage1=="預防及延緩失能計畫，期滿才發錢"]<-0
investigation$ofcwage1[investigation$ofcwage1=="領日薪"]<-0

investigation$ofcwage1<-as.numeric(investigation$ofcwage1)
summary(investigation$ofcwage1)

summary.factor(investigation1015$ofcwage2)
investigation$ofcwage2[investigation$ofcwage2=="不會"]<-0
investigation$ofcwage2[investigation$ofcwage2=="以件計酬"]<-0
investigation$ofcwage2[investigation$ofcwage2=="按件計酬 專案性質，專案結束才發放"]<-0
investigation$ofcwage2[investigation$ofcwage2=="會"]<-1
investigation$ofcwage2[investigation$ofcwage2=="還未領薪"]<-999
investigation$ofcwage2<-as.numeric(investigation$ofcwage2)
summary(investigation$ofcwage2)

summary.factor(investigation1015$ofcwage3)
investigation$ofcwage3[investigation$ofcwage3=="不會"]<-0
investigation$ofcwage3[investigation$ofcwage3=="看她媽老闆心情 專案性質，專案結束才發放，並不按期發放"]<-0
investigation$ofcwage3[investigation$ofcwage3=="會"]<-1
investigation$ofcwage3<-as.numeric(investigation$ofcwage3)
summary(investigation$ofcwage3)

summary.factor(investigation1015$ofcwage4)
investigation$ofcwage4[investigation$ofcwage4=="不會"]<-0
investigation$ofcwage4[investigation$ofcwage4=="會"]<-1
investigation$ofcwage4<-as.numeric(investigation$ofcwage4)
summary(investigation$ofcwage4)



investigation[is.na(investigation)] <- 0  



investigation$totalrev <- (investigation$rev1 + investigation$rev2  + investigation$rev3 + investigation$rev4  + investigation$ofcrev + investigation$ofcrev2 + investigation$ofcrev3 + investigation$ofcrev4)
summary(investigation$totalrev)

investigation$totalexp <- ( (investigation$ex.tuition)*0.2 + (investigation$ex.other) + (investigation$ex.rent))


investigation$totalwhr <- (investigation$workhour1 + investigation$workhour2 + 
                             investigation$workhour3 + investigation$workhour4 +
                             investigation$ofcwhr    + investigation$ofcwhr2   +
                             investigation$ofcwhr3   + investigation$ofcwhr4)
summary(investigation$totalwhr)

investigation$ofcnum1 <- ifelse(investigation$ofcwhr>0,1,0)
investigation$ofcnum2 <- ifelse(investigation$ofcwhr2>0,1,0)
investigation$ofcnum3 <- ifelse(investigation$ofcwhr3>0,1,0)
investigation$ofcnum4 <- ifelse(investigation$ofcwhr4>0,1,0)

investigation$ofcworknum <- (investigation$ofcnum1 + investigation$ofcnum2+
                               investigation$ofcnum3 + investigation$ofcnum4)

investigation$totalworknum <- (investigation$worknum + investigation$ofcworknum)

investigation$totallabor <- (investigation$labor1 + investigation$labor2 + 
                            investigation$labor3 + investigation$labor4)

investigation$totalcontract <- (investigation$contract1 + investigation$contract2 + 
                                  investigation$contract3 + investigation$contract4)

investigation$totalins <-(investigation$ofcins1 + investigation$ofcins2 + 
                            investigation$ofcins3 + investigation$ofcins4)

investigation$totalwage <-(investigation$paywage1 + investigation$paywage2 + 
                            investigation$paywage3 + investigation$paywage4)

investigation$totalofcwage <-(investigation$ofcwage1 + investigation$ofcwage2 + 
                            investigation$ofcwage3 + investigation$ofcwage4)

dataE <- subset(investigation,totalwhr <214)
write.csv(dataE,"datacleancc.csv")

#各次群體描述統計
#應該可以用迴圈處理，但要花點巧思，我暫時懶得動腦。
#北部國立大學大學生
data <- subset(datae,region == "north" &  school == "public" & grad =="FALSE")
summary(data$totalexp)
summary(data$totalrev)
sd(data$totalexp)
sd(data$totalrev)

x<- data$worknum
table(x)[table(x)==max(table(x))]
summary(data$totalwhr)

#北部國立大學研究生
data <- subset(datae,region == "north" &  school == "public" & grad =="TRUE")
summary(data$totalexp)
summary(data$totalrev)
sd(data$totalexp)
sd(data$totalrev)

x<- data$worknum
table(x)[table(x)==max(table(x))]
v<- data$ofcworknum
table(v)[table(v)==max(table(v))]
summary(data$totalwhr)

#北部私立大學大學生
data <- subset(datae,region == "north" &  school == "private" & grad =="FALSE")
summary(data$totalexp)
summary(data$totalrev)
sd(data$totalexp)
sd(data$totalrev)

x<- data$worknum
table(x)[table(x)==max(table(x))]
v<- data$ofcworknum
table(v)[table(v)==max(table(v))]
summary(data$totalwhr)

#北部私立大學研究生
data <- subset(datae,region == "north" &  school == "private" & grad =="TRUE")
summary(data$totalexp)
summary(data$totalrev)
sd(data$totalexp)
sd(data$totalrev)

x<- data$worknum
table(x)[table(x)==max(table(x))]
v<- data$ofcworknum
table(v)[table(v)==max(table(v))]
summary(data$totalwhr)

#中部國立大學大學生
data <- subset(datae,region == "central" &  school == "public" & grad =="FALSE")
summary(data$totalexp)
summary(data$totalrev)
sd(data$totalexp)
sd(data$totalrev)

x<- data$worknum
table(x)[table(x)==max(table(x))]
v<- data$ofcworknum
table(v)[table(v)==max(table(v))]
summary(data$totalwhr)

#中部國立大學研究生
data <- subset(datae,region == "central" &  school == "public" & grad =="TRUE")
summary(data$totalexp)
summary(data$totalrev)
sd(data$totalexp)
sd(data$totalrev)

x<- data$worknum
table(x)[table(x)==max(table(x))]
v<- data$ofcworknum
table(v)[table(v)==max(table(v))]
summary(data$totalwhr)

#中部私立大學大學生
data <- subset(datae,region == "central" &  school == "private" & grad =="FALSE")
summary(data$totalexp)
summary(data$totalrev)
sd(data$totalexp)
sd(data$totalrev)

x<- data$worknum
table(x)[table(x)==max(table(x))]
v<- data$ofcworknum
table(v)[table(v)==max(table(v))]
summary(data$totalwhr)

#中部私立大學研究生
data <- subset(datae,region == "central" &  school == "private" & grad =="TRUE")
summary(data$totalexp)
summary(data$totalrev)
sd(data$totalexp)
sd(data$totalrev)

x<- data$worknum
table(x)[table(x)==max(table(x))]
v<- data$ofcworknum
table(v)[table(v)==max(table(v))]
summary(data$totalwhr)

#南部國立大學大學生
data <- subset(datae,region == "south" &  school == "public" & grad =="FALSE")
summary(data$totalexp)
summary(data$totalrev)
sd(data$totalexp)
sd(data$totalrev)

x<- data$worknum
table(x)[table(x)==max(table(x))]
v<- data$ofcworknum
table(v)[table(v)==max(table(v))]
summary(data$totalwhr)

#南部私立大學大學生
data <- subset(datae,region == "south" &  school == "private" & grad =="FALSE")
summary(data$totalexp)
summary(data$totalrev)
sd(data$totalexp)
sd(data$totalrev)

x<- data$worknum
table(x)[table(x)==max(table(x))]
v<- data$ofcworknum
table(v)[table(v)==max(table(v))]
summary(data$totalwhr)

#南部私立大學研究生
data <- subset(datae,region == "south" &  school == "private" & grad =="TRUE")
summary(data$totalexp)
summary(data$totalrev)
sd(data$totalexp)
sd(data$totalrev)

x<- data$worknum
table(x)[table(x)==max(table(x))]
v<- data$ofcworknum
table(v)[table(v)==max(table(v))]
summary(data$totalwhr)

#東部國立大學大學生
data <- subset(datae,region == "east" &  school == "public" & grad =="FALSE")
summary(data$totalexp)
summary(data$totalrev)
sd(data$totalexp)
sd(data$totalrev)

x<- data$worknum
table(x)[table(x)==max(table(x))]
v<- data$ofcworknum
table(v)[table(v)==max(table(v))]
summary(data$totalwhr)

#東部國立大學研究生
data <- subset(datae,region == "east" &  school == "public" & grad =="TRUE")
summary(data$totalexp)
summary(data$totalrev)
sd(data$totalexp)
sd(data$totalrev)

x<- data$worknum
table(x)[table(x)==max(table(x))]
v<- data$ofcworknum
table(v)[table(v)==max(table(v))]
summary(data$totalwhr)

#東部私立大學大學生
data <- subset(datae,region == "east" &  school == "private" & grad =="FALSE")
summary(data$totalexp)
summary(data$totalrev)
sd(data$totalexp)
sd(data$totalrev)

x<- data$worknum
table(x)[table(x)==max(table(x))]
v<- data$ofcworknum
table(v)[table(v)==max(table(v))]
summary(data$totalwhr)


#腳本結束
pause

```
