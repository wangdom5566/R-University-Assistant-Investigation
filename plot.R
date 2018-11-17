setwd("/Users/christinesfkao/Desktop/student-workers/")
data = read.csv("data.csv")
setwd("/Users/christinesfkao/Desktop/")
student = read.csv("106_student.csv")

#北部大學生
ncpub = data$totalrev[data$grad == FALSE & data$region == "north" & data$school == "public"]
ncpri = data$totalrev[data$grad == FALSE & data$region == "north" & data$school == "private"]
ngpub = data$totalrev[data$grad == TRUE & data$region == "north" & data$school == "public"]
ngpri = data$totalrev[data$grad == TRUE & data$region == "north" & data$school == "private"]

ncpubt_t = student$一年級男生+student$一年級女生+student$二年級男生+student$二年級女生
  
ccpub = data$totalrev[data$grad == FALSE & data$region == "central" & data$school == "public"]
ccpri = data$totalrev[data$grad == FALSE & data$region == "central" & data$school == "private"]
cgpub = data$totalrev[data$grad == TRUE & data$region == "central" & data$school == "public"]
cgpri = data$totalrev[data$grad == TRUE & data$region == "central" & data$school == "private"]

scpub = data$totalrev[data$grad == FALSE & data$region == "south" & data$school == "public"]
scpri = data$totalrev[data$grad == FALSE & data$region == "south" & data$school == "private"]
sgpub = data$totalrev[data$grad == TRUE & data$region == "south" & data$school == "public"]
sgpri = data$totalrev[data$grad == TRUE & data$region == "south" & data$school == "private"]

ecpub = data$totalrev[data$grad == FALSE & data$region == "east" & data$school == "public"]
ecpri = data$totalrev[data$grad == FALSE & data$region == "east" & data$school == "private"]
egpub = data$totalrev[data$grad == TRUE & data$region == "east" & data$school == "public"]
egpri = data$totalrev[data$grad == TRUE & data$region == "east" & data$school == "private"]

ocpub = data$totalrev[data$grad == FALSE & data$region == "other" & data$school == "public"]
ocpri = data$totalrev[data$grad == FALSE & data$region == "other" & data$school == "private"]
ogpub = data$totalrev[data$grad == TRUE & data$region == "other" & data$school == "public"]
ogpri = data$totalrev[data$grad == TRUE & data$region == "other" & data$school == "private"]

