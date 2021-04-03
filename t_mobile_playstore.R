#This file scraped the playstore comments for the T-mobile App. As the people generally speak about the network in comments we have scraped all the comments from playstore

#import required packages
library(RSelenium)

url = 'https://play.google.com/store/apps/details?id=com.tmobile.pr.mytmobile&hl=en_US&showAllReviews=true'


rD = rsDriver(verbose=FALSE, browser = 'firefox', port = 4560L)

remDr <- rD$client

remDr$navigate(url)


#1-star most relevant

ex1 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/span'
module_elem1 = remDr$findElements(using = "xpath", value = ex1)
Name1 = unlist(sapply(module_elem1, function(x) {x$getElementText()}))

ex2 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/div/span/div/div'
module_elem2 = remDr$findElements(using = "xpath", value = ex2)
Rating1 = unlist(sapply(module_elem2, function(x) {x$getElementAttribute("aria-label")}))

ex3 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/div/span[2]'
module_elem3 = remDr$findElements(using = "xpath", value = ex3)
Date1 = unlist(sapply(module_elem3, function(x) {x$getElementText()}))

ex4 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div[2]/span[1]'
module_elem4 = remDr$findElements(using = "xpath", value = ex4)
Text1 = unlist(sapply(module_elem4, function(x) {x$getElementText()}))

ex5 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div[2]/div/div/div[2]'
module_elem5 = remDr$findElements(using = "xpath", value = ex5)
Thanks1 = unlist(sapply(module_elem5, function(x) {x$getElementText()}))

df_1star = data.frame(Name1,Rating1,Date1,Text1)
write.csv(df_1star , "D:\\MSIS(R and Python)\\Project\\1star.csv")
write.csv(Thanks1 , "D:\\MSIS(R and Python)\\Project\\Thanks1.csv")

df_1star$Date <- mdy(df_1star$Date1)

sapply(df_1star$Date, class)

df_1star$Rating <- rep(1,nrow(df_1star))
df_1star$Text = as.character(df_1star$Text1)
df_1star$Name = as.character(df_1star$Name1)


write.csv(df_1star , "D:\\MSIS(R and Python)\\Project\\1star_1.csv")
#2-star most relevant

ex6 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/span'
module_elem6 = remDr$findElements(using = "xpath", value = ex6)
Name = unlist(sapply(module_elem6, function(x) {x$getElementText()}))

ex7 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/div/span/div/div'
module_elem7 = remDr$findElements(using = "xpath", value = ex7)
Rating = unlist(sapply(module_elem7, function(x) {x$getElementAttribute("aria-label")}))

ex8 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/div/span[2]'
module_elem8 = remDr$findElements(using = "xpath", value = ex8)
Date = unlist(sapply(module_elem8, function(x) {x$getElementText()}))

ex9 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div[2]/span[1]'
module_elem9 = remDr$findElements(using = "xpath", value = ex9)
Text = unlist(sapply(module_elem9, function(x) {x$getElementText()}))

ex10 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div[2]/div/div/div[2]'
module_elem10 = remDr$findElements(using = "xpath", value = ex10)
Thanks = unlist(sapply(module_elem10, function(x) {x$getElementText()}))

df_2star = data.frame(Name,Rating,Date,Text)
colnames(df_2star) <- c("Name1", "Rating1","Date1","Text1")
write.csv(df_2star , "D:\\MSIS(R and Python)\\Project\\2star.csv")
write.csv(Thanks , "D:\\MSIS(R and Python)\\Project\\Thanks.csv")

df_2star$Date <- mdy(df_2star$Date1)

sapply(df_2star$Date, class)

df_2star$Rating <- rep(2,nrow(df_2star))
df_2star$Text = as.character(df_2star$Text1)
df_2star$Name = as.character(df_2star$Name1)
write.csv(df_2star , "D:\\MSIS(R and Python)\\Project\\2star_1.csv")

#3-star most relevant

ex11 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/span'
module_elem11 = remDr$findElements(using = "xpath", value = ex11)
Name2 = unlist(sapply(module_elem11, function(x) {x$getElementText()}))

ex12 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/div/span/div/div'
module_elem12 = remDr$findElements(using = "xpath", value = ex12)
Rating2 = unlist(sapply(module_elem12, function(x) {x$getElementAttribute("aria-label")}))

ex13 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/div/span[2]'
module_elem13 = remDr$findElements(using = "xpath", value = ex13)
Date2 = unlist(sapply(module_elem13, function(x) {x$getElementText()}))

ex14 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div[2]/span[1]'
module_elem14 = remDr$findElements(using = "xpath", value = ex14)
Text2 = unlist(sapply(module_elem14, function(x) {x$getElementText()}))

ex15 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div[2]/div/div/div[2]'
module_elem15 = remDr$findElements(using = "xpath", value = ex15)
Thanks2 = unlist(sapply(module_elem15, function(x) {x$getElementText()}))

df_3star = data.frame(Name2,Rating2,Date2,Text2)
write.csv(df_3star , "D:\\MSIS(R and Python)\\Project\\3star.csv")
write.csv(Thanks2 , "D:\\MSIS(R and Python)\\Project\\Thanks2.csv")

df_3star$Date <- mdy(df_3star$Date2)

df_3star$Rating <- rep(3,nrow(df_3star))
df_3star$Text = as.character(df_3star$Text2)
df_3star$Name = as.character(df_3star$Name2)
write.csv(df_3star , "D:\\MSIS(R and Python)\\Project\\3star_1.csv")

#4-star most relevant

ex16 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/span'
module_elem16 = remDr$findElements(using = "xpath", value = ex16)
Name3 = unlist(sapply(module_elem16, function(x) {x$getElementText()}))

ex17 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/div/span/div/div'
module_elem17 = remDr$findElements(using = "xpath", value = ex17)
Rating3 = unlist(sapply(module_elem17, function(x) {x$getElementAttribute("aria-label")}))

ex18 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/div/span[2]'
module_elem18 = remDr$findElements(using = "xpath", value = ex18)
Date3 = unlist(sapply(module_elem18, function(x) {x$getElementText()}))

ex19 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div[2]/span[1]'
module_elem19 = remDr$findElements(using = "xpath", value = ex19)
Text3 = unlist(sapply(module_elem19, function(x) {x$getElementText()}))

ex20 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div[2]/div/div/div[2]'
module_elem20 = remDr$findElements(using = "xpath", value = ex20)
Thanks3 = unlist(sapply(module_elem20, function(x) {x$getElementText()}))

df_4star = data.frame(Name3,Rating3,Date3,Text3)
write.csv(df_4star , "D:\\MSIS(R and Python)\\Project\\4star.csv")
write.csv(Thanks3 , "D:\\MSIS(R and Python)\\Project\\Thanks3.csv")

df_4star$Date <- mdy(df_4star$Date3)

df_4star$Rating <- rep(4,nrow(df_4star))
df_4star$Text = as.character(df_4star$Text3)
df_4star$Name = as.character(df_4star$Name3)
write.csv(df_4star , "D:\\MSIS(R and Python)\\Project\\4star_1.csv")


#5-star most relevant

ex21 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/span'
module_elem21 = remDr$findElements(using = "xpath", value = ex21)
Name4 = unlist(sapply(module_elem21, function(x) {x$getElementText()}))

ex22 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/div/span/div/div'
module_elem22 = remDr$findElements(using = "xpath", value = ex22)
Rating4 = unlist(sapply(module_elem22, function(x) {x$getElementAttribute("aria-label")}))

ex23 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/div/span[2]'
module_elem23 = remDr$findElements(using = "xpath", value = ex23)
Date4 = unlist(sapply(module_elem23, function(x) {x$getElementText()}))

ex24 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div[2]/span[1]'
module_elem24 = remDr$findElements(using = "xpath", value = ex24)
Text4 = unlist(sapply(module_elem24, function(x) {x$getElementText()}))

ex25 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div[2]/div/div/div[2]'
module_elem25 = remDr$findElements(using = "xpath", value = ex25)
Thanks4 = unlist(sapply(module_elem25, function(x) {x$getElementText()}))

df_5star = data.frame(Name4,Rating4,Date4,Text4)
write.csv(df_5star , "D:\\MSIS(R and Python)\\Project\\5star.csv")
write.csv(Thanks4 , "D:\\MSIS(R and Python)\\Project\\Thanks4.csv")

df_5star$Date <- mdy(df_5star$Date4)

df_5star$Rating <- rep(5,nrow(df_5star))
df_5star$Text = as.character(df_5star$Text4)
df_5star$Name = as.character(df_5star$Name4)
write.csv(df_5star , "D:\\MSIS(R and Python)\\Project\\5star_1.csv")

df_total_tmobile = rbind(df_1star[,c(5:8)],df_2star[,c(5:8)],df_3star[,c(5:8)],df_4star[,c(5:8)],df_5star[,c(5:8)])
write.csv(df_total_tmobile , "D:\\MSIS(R and Python)\\Project\\Total_tmobile.csv")



df_total_tmobile_2018 = df_total_tmobile[year(df_total_tmobile$Date)==2018,]
df_total_tmobile_2019 = df_total_tmobile[year(df_total_tmobile$Date)==2019,]

#latest

ex26 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/span'
module_elem26 = remDr$findElements(using = "xpath", value = ex26)
Name5 = unlist(sapply(module_elem26, function(x) {x$getElementText()}))

ex27 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/div/span/div/div'
module_elem27 = remDr$findElements(using = "xpath", value = ex27)
Rating5 = unlist(sapply(module_elem27, function(x) {x$getElementAttribute("aria-label")}))

ex28 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div/div/span[2]'
module_elem28 = remDr$findElements(using = "xpath", value = ex28)
Date5 = unlist(sapply(module_elem28, function(x) {x$getElementText()}))

ex29 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div[2]/span[1]'
module_elem29 = remDr$findElements(using = "xpath", value = ex29)
Text5 = unlist(sapply(module_elem29, function(x) {x$getElementText()}))

ex30 = '//div[@jsname="fk8dgd"]/div/div/div[2]/div/div[2]/div/div/div[2]'
module_elem30 = remDr$findElements(using = "xpath", value = ex30)
Thanks5 = unlist(sapply(module_elem30, function(x) {x$getElementText()}))

df_latest = data.frame(Name5,Rating5,Date5,Text5[1:5640])
write.csv(df_latest , "D:\\MSIS(R and Python)\\Project\\latest.csv")
write.csv(Thanks5 , "D:\\MSIS(R and Python)\\Project\\Thanks5.csv")

df_latest$Date <- mdy(df_latest$Date5)
df_latest$Rating = gsub(" stars out of five stars","",df_latest$Rating5)
df_latest$Rating = gsub("Rated ","",df_latest$Rating)

df_latest$Rating = noquote(df_latest$Rating)
df_latest$Rating = as.numeric(df_latest$Rating)
sapply(df_latest$Rating, class)
df_latest$Text = as.character(df_latest$Text5)
sapply(df_latest1$Text1, class)
df_latest$Name = as.character(df_latest$Name5)
write.csv(df_latest , "D:\\MSIS(R and Python)\\Project\\latest_1.csv")


remDr$close()
rD$server$stop()