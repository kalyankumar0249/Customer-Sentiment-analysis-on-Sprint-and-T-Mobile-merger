#This file helps to perform sentiment analysis on the sprint comments collected

library(lubridate)
#install.packages("lubridate")

library(RSelenium)

#Loading the data
setwd("D:\\MSIS(R and Python)\\Project\\Sent\\Sent\\sprint_latest_data")
df_latest1 = read.table('latest_sprint_1.csv',header = TRUE, sep = ',')
df_latest1$Date1 <- mdy(df_latest1$Date)
max(df_latest1$Date1)


#install.packages('tidytext')
library(tidytext)
#install.packages('tm')
library(tm)
library(tidyverse)
library(SnowballC)

summary(df_latest1)

#Removing the tweets containing the word Apps
sprint_tweets = df_latest1 %>%
  filter(!str_detect(Text1, 'App|Apps|app|apps|APP|APPS')) %>%
  select(Text1,Rating1)

#sprint_tweets %>%
#  filter(str_detect(Text1, 'service|Service|Network|network|carrier|Carrier')) %>%
#  select(Text1)


sprint_tweets$Text1 = as.character(sprint_tweets$Text1)

#Tokenizing text
tidy_dataset = sprint_tweets%>%
  unnest_tokens(word,Text1)

tidy_dataset%>%
  count(word)%>%
  arrange(desc(n))

data("stop_words")

#Removing stopwords
tidy_dataset2 = tidy_dataset%>%
  anti_join(stop_words)

tidy_dataset2%>%
  count(word)%>%
  arrange(desc(n))

#Removing the digits, spacing, unnecessary words
patterndigits = '\\b[0-9]+\\b'

tidy_dataset2$word = tidy_dataset2$word%>%
  str_replace_all(patterndigits,'')

tidy_dataset2$word = tidy_dataset2$word%>%
  str_replace_all('[:space:]','')

tidy_dataset3 = tidy_dataset2%>%
  filter(!(word==''))

tidy_dataset3%>%
  count(word)%>%
  arrange(desc(n))

#Changing all the words into same proportions
frequency = tidy_dataset3%>%
  count(word)%>%
  arrange(desc(n))%>%
  mutate(proportion = (n/sum(n)*100))%>%
  filter(proportion>=0.5)

library(scales)

ggplot(frequency,aes(x=proportion,y=word))+
  geom_abline(color = "gray40",lty=2)+
  geom_jitter(alpha=0.1, size = 2.5, width = 0.3,height = 0.3)+
  geom_text(aes(label=word),check_overlap = TRUE,vjust = 1.5)+
  scale_color_gradient(limits=c(0,0.001),low="darkslategray4",high="gray75")+
  theme(legend.position = "none")+
  labs(y='word',x='Proportion')

#Removing unnecessary words
list = c("sprint","bill","service","pay","easy","payment","payments","password")
tidy_dataset3 = tidy_dataset3%>%
  filter(!(word%in%list))

tidy_dataset3%>%
  count(word)%>%
  arrange(desc(n))

#Word Stemming
tidy_dataset4 = tidy_dataset3%>%
  mutate_at("word",funs(wordStem((.),language = "en")))

tidy_dataset4%>%
  count(word)%>%
  arrange(desc(n))

#Document term matrix
tidy_tdm = tidy_dataset4%>%
  count(Rating1,word)%>%
  cast_dtm(Rating1,word,n)

library(wordcloud)
#install.packages("wordcloud")
#install.packages("udpipe")
library(udpipe)
#install.packages("lattice")
library(lattice)
library(NLP)
library(tm)
library(SnowballC)
#install.packages("textdata")
library(textdata)
library(dplyr)
library(rlang)
get_sentiments("bing") %>%
  distinct(sentiment)

get_sentiments('nrc') %>%
  distinct(sentiment)

#Number of positive and Negative comments
tidy_dataset4 %>%
  inner_join(get_sentiments("bing"))%>%
  count(sentiment) %>%
  spread(sentiment,n,fill = 0)%>%
  mutate(diffsent = positive-negative)

nrc_joysad = get_sentiments('nrc') %>%
  filter(sentiment=='joy'|
           sentiment =='sadness')

#Joy and sad sentiment
tidy_dataset4 %>%
  inner_join(get_sentiments("nrc"))%>%
  count(sentiment) %>%
  spread(sentiment,n,fill = 0)%>%
  mutate(diffsent = joy-sadness)

nrow(nrc_joysad)

(tweet_joysad=tidy_dataset4 %>%
    inner_join(nrc_joysad)%>%
    count(word,sentiment)%>%
    spread(sentiment,n,fill=0)%>%
    mutate(contentment = joy-sadness,linenumber = row_number())%>%
    arrange(desc(contentment)))

ggplot(tweet_joysad,aes(x=linenumber,y=contentment))+
  coord_flip()+
  theme_light(base_size=15)+
  labs(
    x='Index Value',
    y='Contentment'
  )+
  theme(
    legend.position='none',
    panel.grid = element_blank(),
    axis.title = element_text(size=10),
    axis.text.x=element_text(size=10),
    axis.text.y = element_text(size = 10)
  )+
  geom_col()

(tweet_joysad2 = tweet_joysad%>%
  slice(1:10,58:67))

ggplot(tweet_joysad2, aes(x=linenumber, y=contentment, fill=word)) +
  coord_flip() +
  theme_light(base_size = 15) +
  labs(
    x='Index Value',
    y='Contentment'
  ) +
  theme(
    legend.position = 'bottom',
    panel.grid = element_blank(),
    axis.title = element_text(size = 10),
    axis.text.x = element_text(size = 10),
    axis.text.y = element_text(size = 10)
  ) +
  geom_col()

#Trust and fear sentiment
nrc_trstfear = get_sentiments('nrc') %>%
  filter(sentiment == 'trust' |
           sentiment == 'fear')

nrow(nrc_trstfear)

(tweet_trstfear = tidy_dataset4 %>%
    inner_join(nrc_trstfear) %>%
    count(word, sentiment) %>%
    spread(sentiment, n, fill = 0) %>%
    mutate(trustworthy = trust - fear, linenumber = row_number()) %>%
    arrange(desc(trustworthy)) %>%
    slice(1:10,80:89))

ggplot(tweet_trstfear, aes(x=linenumber, y=trustworthy, fill=word)) +
  coord_flip() +
  theme_light(base_size = 15) +
  labs(
    x='Index Value',
    y='Trustworthiness'
  ) +
  theme(
    legend.position = 'bottom',
    panel.grid = element_blank(),
    axis.title = element_text(size = 10),
    axis.text.x = element_text(size = 10),
    axis.text.y = element_text(size = 10)
  ) +
  geom_col()


sprint_tweets %>%
  filter(str_detect(Text1, 'account|Account')) %>%
  select(Text1)

library(reshape2)

tidy_dataset4 %>%
  inner_join(nrc_trstfear) %>%
  count(word, sentiment) %>%
  slice(1:10,80:89)%>%
  acast(word~sentiment, value.var='n',fill=0) %>%
  comparison.cloud(colors=c('gray30','gray70'))

#ud_model = udpipe_download_model(language = "english")

#Parts of speech recognition
tidy_post1 = tidy_dataset4 %>%
  select(word)

ud_model = udpipe_load_model(ud_model$file_model)

x = as.data.frame(udpipe_annotate(ud_model, x = tidy_post1$word))

post_stats = txt_freq(x$upos)

post_stats$key = factor(post_stats$key, levels = rev(post_stats$key))

noun_stats = subset(x, upos %in% c("NOUN"))

noun_stats2 = txt_freq(noun_stats$token)

noun_stats2$key = factor(noun_stats2$key, levels = rev(noun_stats2$key))

#Top Nouns
noun_stats2 %>%
  slice(1:19) %>%
  ggplot(aes(x=key, y=as.factor(freq), fill=freq)) +
  coord_flip() +
  theme_light(base_size = 15) +
  labs(
    x='Frequency',
    y='',
    title='Noun Occurrences'
  ) +
  theme(
    legend.position = 'none',
    panel.grid = element_blank(),
    axis.title = element_text(size = 10),
    axis.text.x = element_text(size = 10),
    axis.text.y = element_text(size = 10),
    title = element_text(size = 13)
  ) +
  scale_fill_gradient(low="orange", high="orange3") +
  geom_col()



adjstats = subset(x, upos %in% c("ADJ"))

adjstats2 = txt_freq(adjstats$token)

adjstats2$key = factor(adjstats2$key, levels = rev(adjstats2$key))

#Top Adjectives
adjstats2 %>%
  slice(1:20) %>%
  ggplot(aes(x=key, y=as.factor(freq), fill=freq)) +
  coord_flip() +
  theme_light(base_size = 15) +
  labs(
    x='Frequency',
    y='',
    title='Adjectives Occurrences'
  ) +
  theme(
    legend.position = 'none',
    panel.grid = element_blank(),
    axis.title = element_text(size = 10),
    axis.text.x = element_text(size = 10),
    axis.text.y = element_text(size = 10),
    title = element_text(size = 13)
  ) +
  scale_fill_gradient(low="chartreuse", high="chartreuse3") +
  geom_col()


verbstats = subset(x, upos %in% c("VERB"))

verbstats2 = txt_freq(verbstats$token)

verbstats2$key = factor(verbstats2$key, levels = rev(verbstats2$key))

#Top verbs
verbstats2 %>%
  slice(1:20) %>%
  ggplot(aes(x=key, y=as.factor(freq), fill=freq)) +
  coord_flip() +
  theme_light(base_size = 15) +
  labs(
    x='Frequency',
    y='',
    title='Verb Occurrences'
  ) +
  theme(
    legend.position = 'none',
    panel.grid = element_blank(),
    axis.title = element_text(size = 10),
    axis.text.x = element_text(size = 10),
    axis.text.y = element_text(size = 10),
    title = element_text(size = 13)
  ) +
  scale_fill_gradient(low="tan", high="tan3") +
  geom_col()

#To produce the descriptive analytics graphs

setwd("D:\\MSIS(R and Python)\\Project\\Sent\\Sent\\sprint_latest_data")
df_1star = read.table('6star_1.csv',header = TRUE, sep = ',',fill = NA)
#df_1star$Date = df_1star$Date1
setwd("D:\\MSIS(R and Python)\\Project\\Sent\\Sent\\sprint_latest_data")
df_2star = read.table('7star_1.csv',header = TRUE, sep = ',',fill = NA)
#df_2star$Date = df_2star$Date1
setwd("D:\\MSIS(R and Python)\\Project\\Sent\\Sent\\sprint_latest_data")
df_3star = read.table('8star_1.csv',header = TRUE, sep = ',',fill = NA)
#df_3star$Date = df_3star$Date2
setwd("D:\\MSIS(R and Python)\\Project\\Sent\\Sent\\sprint_latest_data")
df_4star = read.table('9star_1.csv',header = TRUE, sep = ',',fill = NA)
#df_4star$Date = df_4star$Date3
setwd("D:\\MSIS(R and Python)\\Project\\Sent\\Sent\\sprint_latest_data")
df_5star = read.table('10star_1.csv',header = TRUE, sep = ',',fill = NA)
#df_5star$Date = df_5star$Date4
summary(df_5star)

df_latest2 = rbind(df_1star[,c("Date","Text","Rating1")],df_2star[,c("Date","Text","Rating1")],df_3star[,c("Date","Text","Rating1")],df_4star[,c("Date","Text","Rating1")],df_5star[,c("Date","Text","Rating1")])
summary(df_latest2)
df_latest2$Date = mdy(df_latest2$Date)
min(df_latest2$Date)
max(df_latest2$Date)

df_latest2$Date1 = format(df_latest2$Date, "%Y - %m")

df_latest3 = df_latest2 %>% 
  group_by(df_latest2$Date1,Rating1) %>% 
  count(Rating1)

names(df_latest3)[1]="Date"

df_latest3$Rating = as.factor(df_latest3$Rating1)

df_latest3$Rating1[which(df_latest3$Rating == "4" | df_latest3$Rating == "5")] <- "High"
df_latest3$Rating1[which(df_latest3$Rating == "3")] <- "Medium"
df_latest3$Rating1[which(df_latest3$Rating == "1" | df_latest3$Rating == "2")] <- "Low"

df_latest3$Rating1 = as.factor(df_latest3$Rating1)

ggplot(df_latest3) +
  aes(x = Date, y = n, group = Rating1, color = Rating1) +
  geom_point() +
  geom_line() 

df_latest4 = df_latest3[df_latest3$Date == "2018 - 10"|df_latest3$Date == "2018 - 11"|df_latest3$Date == "2018 - 12"|
                          df_latest3$Date == "2019 - 01"|df_latest3$Date == "2019 - 02"|df_latest3$Date == "2019 - 03"|
                          df_latest3$Date == "2019 - 06"|df_latest3$Date == "2019 - 05"|df_latest3$Date == "2019 - 04"|
                          df_latest3$Date == "2019 - 07"|df_latest3$Date == "2019 - 08"|df_latest3$Date == "2019 - 09",]

ggplot(df_latest4) +
  aes(x = Date, y = n, group = Rating1, color = Rating1) +
  geom_point() +
  geom_line() 

