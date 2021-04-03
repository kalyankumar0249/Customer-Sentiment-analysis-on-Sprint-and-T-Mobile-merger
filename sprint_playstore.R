#This file scrapes the Sprint comments from Play Store
library(lubridate)
install.packages("lubridate")

library(RSelenium)

url = 'https://play.google.com/store/apps/details?id=com.sprint.care&hl=en_US&showAllReviews=true'


rD = rsDriver(verbose=FALSE, browser = 'firefox', port = 4560L)

remDr <- rD$client

remDr$navigate(url)

#module_elem = remDr$findElements(using = "class", "prdname")

#modulelist = unlist(sapply(module_elem, function(x) {x$getElementText()}))

#1-star most relevant - by selecting the rating = 1 in the website

ex31 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/span'
module_elem31 = remDr$findElements(using = "xpath", value = ex31)
Name6 = unlist(sapply(module_elem31, function(x) {x$getElementText()}))

ex32 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/div/span/div/div'
module_elem32 = remDr$findElements(using = "xpath", value = ex32)
Rating6 = unlist(sapply(module_elem32, function(x) {x$getElementAttribute("aria-label")}))

ex33 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/div/span[2]'
module_elem33 = remDr$findElements(using = "xpath", value = ex33)
Date6 = unlist(sapply(module_elem33, function(x) {x$getElementText()}))

ex34 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div[2]/span[1]'
module_elem34 = remDr$findElements(using = "xpath", value = ex34)
Text6 = unlist(sapply(module_elem34, function(x) {x$getElementText()}))

ex35 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div[2]/div/div/div[2]'
module_elem35 = remDr$findElements(using = "xpath", value = ex35)
Thanks6 = unlist(sapply(module_elem35, function(x) {x$getElementText()}))

df_6star = data.frame(Name6[1:2280],Rating6,Date6,Text6)
colnames(df_6star) <- c("Name", "Rating","Date","Text")
write.csv(df_6star , "D:\\MSIS(R and Python)\\Project\\6star.csv")

write.csv(Thanks6 , "D:\\MSIS(R and Python)\\Project\\Thanks6.csv")


df_6star$Date1 <- mdy(df_6star$Date)

sapply(df_6star$Date1, class)

df_6star$Rating1 <- rep(1,nrow(df_6star))
df_6star$Text1 = as.character(df_6star$Text)
df_6star$Name1 = as.character(df_6star$Name)
write.csv(df_6star , "D:\\MSIS(R and Python)\\Project\\6star_1.csv")
df_6star[,c(5:8)]

#2-star most relevant -  by selecting the rating = 2 in the website and later

ex36 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/span'
module_elem36 = remDr$findElements(using = "xpath", value = ex36)
Name7 = unlist(sapply(module_elem36, function(x) {x$getElementText()}))

ex37 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/div/span/div/div'
module_elem37 = remDr$findElements(using = "xpath", value = ex37)
Rating7 = unlist(sapply(module_elem37, function(x) {x$getElementAttribute("aria-label")}))

ex38 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/div/span[2]'
module_elem38 = remDr$findElements(using = "xpath", value = ex38)
Date7 = unlist(sapply(module_elem38, function(x) {x$getElementText()}))

ex39 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div[2]/span[1]'
module_elem39 = remDr$findElements(using = "xpath", value = ex39)
Text7 = unlist(sapply(module_elem39, function(x) {x$getElementText()}))

ex40 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div[2]/div/div/div[2]'
module_elem40 = remDr$findElements(using = "xpath", value = ex40)
Thanks7 = unlist(sapply(module_elem40, function(x) {x$getElementText()}))

df_7star = data.frame(Name7[1:1122],Rating7,Date7,Text7)
colnames(df_7star) <- c("Name", "Rating","Date","Text")
write.csv(df_7star , "D:\\MSIS(R and Python)\\Project\\7star.csv")

write.csv(Thanks7 , "D:\\MSIS(R and Python)\\Project\\Thanks7.csv")

df_7star$Date1 <- mdy(df_7star$Date)
df_7star$Rating1 <- rep(2,nrow(df_7star))
df_7star$Text1 = as.character(df_7star$Text)
df_7star$Name1 = as.character(df_7star$Name)
write.csv(df_7star , "D:\\MSIS(R and Python)\\Project\\7star_1.csv")

#3-star most relevant -  by selecting the rating = 3 in the website and later

ex41 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/span'
module_elem41 = remDr$findElements(using = "xpath", value = ex41)
Name8 = unlist(sapply(module_elem41, function(x) {x$getElementText()}))

ex42 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/div/span/div/div'
module_elem42 = remDr$findElements(using = "xpath", value = ex42)
Rating8 = unlist(sapply(module_elem42, function(x) {x$getElementAttribute("aria-label")}))

ex43 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/div/span[2]'
module_elem43 = remDr$findElements(using = "xpath", value = ex43)
Date8 = unlist(sapply(module_elem43, function(x) {x$getElementText()}))

ex44 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div[2]/span[1]'
module_elem44 = remDr$findElements(using = "xpath", value = ex44)
Text8 = unlist(sapply(module_elem44, function(x) {x$getElementText()}))

ex45 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div[2]/div/div/div[2]'
module_elem45 = remDr$findElements(using = "xpath", value = ex45)
Thanks8 = unlist(sapply(module_elem45, function(x) {x$getElementText()}))

df_8star = data.frame(Name8[1:1304],Rating8,Date8,Text8)
colnames(df_8star) <- c("Name", "Rating","Date","Text")
write.csv(df_8star , "D:\\MSIS(R and Python)\\Project\\8star.csv")
write.csv(Thanks8 , "D:\\MSIS(R and Python)\\Project\\Thanks8.csv")


df_8star$Date1 <- mdy(df_8star$Date)
df_8star$Rating1 <- rep(3,nrow(df_8star))
df_8star$Text1 = as.character(df_8star$Text)
df_8star$Name1 = as.character(df_8star$Name)
write.csv(df_8star , "D:\\MSIS(R and Python)\\Project\\8star_1.csv")

#4-star most relevant -  by selecting the rating = 4 in the website and later

ex46 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/span'
module_elem46 = remDr$findElements(using = "xpath", value = ex46)
Name9 = unlist(sapply(module_elem46, function(x) {x$getElementText()}))

ex47 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/div/span/div/div'
module_elem47 = remDr$findElements(using = "xpath", value = ex47)
Rating9 = unlist(sapply(module_elem47, function(x) {x$getElementAttribute("aria-label")}))

ex48 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/div/span[2]'
module_elem48 = remDr$findElements(using = "xpath", value = ex48)
Date9 = unlist(sapply(module_elem48, function(x) {x$getElementText()}))

ex49 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div[2]/span[1]'
module_elem49 = remDr$findElements(using = "xpath", value = ex49)
Text9 = unlist(sapply(module_elem49, function(x) {x$getElementText()}))

ex50 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div[2]/div/div/div[2]'
module_elem50 = remDr$findElements(using = "xpath", value = ex50)
Thanks9 = unlist(sapply(module_elem50, function(x) {x$getElementText()}))

df_9star = data.frame(Name9[1:2760],Rating9,Date9,Text9)
colnames(df_9star) <- c("Name", "Rating","Date","Text")
write.csv(df_9star , "D:\\MSIS(R and Python)\\Project\\9star.csv")
write.csv(Thanks9 , "D:\\MSIS(R and Python)\\Project\\Thanks9.csv")

df_9star$Date1 <- mdy(df_9star$Date)
df_9star$Rating1 <- rep(4,nrow(df_9star))
df_9star$Text1 = as.character(df_9star$Text)
df_9star$Name1 = as.character(df_9star$Name)
write.csv(df_9star , "D:\\MSIS(R and Python)\\Project\\9star_1.csv")


#5-star most relevant -  by selecting the rating = 5 in the website and later

ex51 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/span'
module_elem51 = remDr$findElements(using = "xpath", value = ex51)
Name10 = unlist(sapply(module_elem51, function(x) {x$getElementText()}))

ex52 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/div/span/div/div'
module_elem52 = remDr$findElements(using = "xpath", value = ex52)
Rating10 = unlist(sapply(module_elem52, function(x) {x$getElementAttribute("aria-label")}))

ex53 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/div/span[2]'
module_elem53 = remDr$findElements(using = "xpath", value = ex53)
Date10 = unlist(sapply(module_elem53, function(x) {x$getElementText()}))

ex54 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div[2]/span[1]'
module_elem54 = remDr$findElements(using = "xpath", value = ex54)
Text10 = unlist(sapply(module_elem54, function(x) {x$getElementText()}))

ex55 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div[2]/div/div/div[2]'
module_elem55 = remDr$findElements(using = "xpath", value = ex55)
Thanks10 = unlist(sapply(module_elem55, function(x) {x$getElementText()}))

df_10star = data.frame(Name10[1:2600],Rating10,Date10,Text10)
colnames(df_10star) <- c("Name", "Rating","Date","Text")
write.csv(df_10star , "D:\\MSIS(R and Python)\\Project\\10star.csv")
write.csv(Thanks10 , "D:\\MSIS(R and Python)\\Project\\Thanks10.csv")

df_10star$Date1 <- mdy(df_10star$Date)
df_10star$Rating1 <- rep(5,nrow(df_10star))
df_10star[1,1]$Text1 = as.character(df_10star$Text)
df_10star$Name1 = as.character(df_10star$Name)
write.csv(df_10star , "D:\\MSIS(R and Python)\\Project\\10star_1.csv")

df_total = rbind(df_6star[,c(5:8)],df_7star[,c(5:8)],df_8star[,c(5:8)],df_9star[,c(5:8)],df_10star[,c(5:8)])
write.csv(df_total , "D:\\MSIS(R and Python)\\Project\\Total_sprint.csv")

df_total_sprint_2018 = df_total[year(df_total$Date1)==2018,]
df_total_sprint_2019 = df_total[year(df_total$Date1)==2019,]

#latest - by selecting the newest in the website.

ex56 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/span'
module_elem56 = remDr$findElements(using = "xpath", value = ex56)
Name11 = unlist(sapply(module_elem56, function(x) {x$getElementText()}))

ex57 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/div/span/div/div'
module_elem57 = remDr$findElements(using = "xpath", value = ex57)
Rating11 = unlist(sapply(module_elem57, function(x) {x$getElementAttribute("aria-label")}))

ex58 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/div/span[2]'
module_elem58 = remDr$findElements(using = "xpath", value = ex58)
Date11 = unlist(sapply(module_elem58, function(x) {x$getElementText()}))

ex59 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div[2]/span[1]'
module_elem59 = remDr$findElements(using = "xpath", value = ex59)
Text11 = unlist(sapply(module_elem59, function(x) {x$getElementText()}))

ex60 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div[2]/div/div/div[2]'
module_elem60 = remDr$findElements(using = "xpath", value = ex60)
Thanks11 = unlist(sapply(module_elem60, function(x) {x$getElementText()}))

df_latest1 = data.frame(Name11[1:2280],Rating11,Date11,Text11)
colnames(df_latest1) <- c("Name", "Rating","Date","Text")
write.csv(df_latest1 , "D:\\MSIS(R and Python)\\Project\\latest_sprint.csv")
write.csv(Thanks11 , "D:\\MSIS(R and Python)\\Project\\Thanks11.csv")

df_latest1$Date1 <- mdy(df_latest1$Date)
df_latest1$Rating1 = gsub(" stars out of five stars","",df_latest1$Rating)
df_latest1$Rating1 = gsub("Rated ","",df_latest1$Rating1)

df_latest1$Rating1 = noquote(df_latest1$Rating1)
df_latest1$Rating1 = as.numeric(df_latest1$Rating1)
sapply(df_latest1$Rating1, class)
df_latest1$Text1 = as.character(df_latest1$Text)
sapply(df_latest1$Text1, class)
df_latest1$Name1 = as.character(df_latest1$Name)

write.csv(df_latest1 , "D:\\MSIS(R and Python)\\Project\\latest_sprint_1.csv")

remDr$close()
rD$server$stop()