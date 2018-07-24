調查的goolge表單<https://docs.google.com/document/d/1fesNHiSL8kvDLjwFaX88LhOXgDaxou4nd3imDH_Vipc/edit>

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

# 可能需要對這份問卷作版本控制，以保留這份資料的清理編碼過程，確保序數、其他的編碼不會對分析有影響。
# 所以我才開github的專案，雖然我不太會用呵呵.....但就更新資料確認版本、對格式、貼程式碼之類的可能方便點。
# 或是乾脆將問卷拆開兩部分題組，一人負責一半編碼。

ˋˋˋ
# 我想到這裡為止，至少已經有同一份資料能用，也解決亂碼問題了，剩下的可能等8月中在確認~~
