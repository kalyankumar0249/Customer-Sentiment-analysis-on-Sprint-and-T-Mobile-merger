#This file helps to perform sentiment analysis on the scraped user comments data from twitter on the Merger

#Load the data from the source
setwd("D:\\MSIS(R and Python)\\Project\\Sent\\Sent")
df_latest1 = read.table('cleanfile2.csv',header = TRUE, sep = ',',fill = NA)
library(lubridate)
library(RSelenium)
df_latest1$Date1 <- mdy(df_latest1$date)
max(df_latest1$Date1)
summary(df_latest1)
#install.packages('tidytext')
library(tidytext)
#install.packages('tm')
library(tm)
library(tidyverse)
library(SnowballC)

summary(df_latest1$tweet)

merger_tweets = df_latest1%>%
  select(tweet)

#convert the text into character
merger_tweets$Text1 = as.character(merger_tweets$tweet)

#Tokenizing the text
tidy_dataset = merger_tweets%>%
  unnest_tokens(word,Text1)

tidy_dataset%>%
  count(word)%>%
  arrange(desc(n))

frequency = tidy_dataset%>%
  count(word)%>%
  arrange(desc(n))%>%
  mutate(proportion = (n/sum(n)*100))%>%
  filter(proportion>=0.5)

#Initial word cloud
set.seed(1234)
library(wordcloud)
wordcloud(words = frequency$word, freq = frequency$n, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35,scale=c(3.5,0.25),
          colors=brewer.pal(8, "Dark2"))

data("stop_words")

#Removal of the stop words
tidy_dataset2 = tidy_dataset%>%
  anti_join(stop_words)

tidy_dataset2%>%
  count(word)%>%
  arrange(desc(n))

#Removal of numerical digits and spaces and unnecessary words
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

#scaling down to same proportion
frequency = tidy_dataset3%>%
  count(word)%>%
  arrange(desc(n))%>%
  mutate(proportion = (n/sum(n)*100))%>%
  filter(proportion>=0.5)

#A plot to show the words based on proportions
library(scales)
#install.packages("ggplot2")
library(ggplot2)
ggplot(frequency,aes(x=proportion,y=word))+
  geom_abline(color = "gray40",lty=2)+
  geom_jitter(alpha=0.1, size = 2.5, width = 0.3,height = 0.3)+
  geom_text(aes(label=word),check_overlap = TRUE,vjust = 1.5)+
  scale_color_gradient(limits=c(0,0.001),low="darkslategray4",high="gray75")+
  theme(legend.position = "none")+
  labs(y='word',x='Proportion')

list = c("tmobile","tmobilesprint","sprint","merger","mobile",",","https","в","tmobile","fcc")
tidy_dataset3 = tidy_dataset3%>%
  filter(!(word%in%list))

tidy_dataset3%>%
  count(word)%>%
  arrange(desc(n))

list = c("http","pic.twitter.com","tmobilesprintmerger","sprinttmobilemerger","johnlegere","sprinttmobile","proposed","wireless","ря","news","bit.ly","people","sprintmerger","doj","billion","jeffkagan","г","tmobilemerger","verizon","twitter.com","company","lnkd.in","marceloclaure","merge")
tidy_dataset3 = tidy_dataset3%>%
  filter(!(word%in%list))

tidy_dataset3%>%
  count(word)%>%
  arrange(desc(n))
#Finding the frequency of the words after cleaning the data
frequency1 = tidy_dataset3%>%
  count(word)%>%
  arrange(desc(n))%>%
  mutate(proportion = (n/sum(n)*100))%>%
  filter(proportion>=0.1)

#set.seed(1234)
#library("wordcloud")
#wordcloud(words = frequency1$word, freq = frequency1$n,
#          max.words=200, random.order=FALSE, rot.per=0.35,scale=c(4,0.25),
#          colors=brewer.pal(8, "Dark2"))
#redPalette <- c("#5c1010", "#6f0000", "#560d0d", "#c30101", "#940000")
#url = "https://raw.githubusercontent.com/lgellis/MiscTutorial/master/twitter_wordcloud/handmaiden.jpeg"
#handmaiden <- "handmaiden.jpg"
#download.file(url, handmaiden) # download file

#plots
#wordcloud2(frequency1[,c(1,2)], size=1.6, figPath = handmaiden, color=rep_len( redPalette, nrow(frequency1[,c(1,2)]) ) )
#
#wordcloud2(hmtTable, size=1.6, figPath = resistance, color="#B20000")

#Stemming the data
tidy_dataset4 = tidy_dataset3%>%
  mutate_at("word",funs(wordStem((.),language = "en")))

tidy_dataset4%>%
  count(word)%>%
  arrange(desc(n))

#list = c("month","password","updat","make","pay","bill","call","friend","issu","sign","log","compani")
#tidy_dataset4 = tidy_dataset4%>%
#  filter(!(word%in%list))

#frequency1 = tidy_dataset4%>%
#  count(word)%>%
#  arrange(desc(n))%>%
#  mutate(proportion = (n/sum(n)*100))%>%
#  filter(proportion>=0.3)


#word cloud to show words after the stemming
set.seed(1234)
wordcloud(words = frequency1$word, freq = frequency1$n, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35,scale=c(3.5,0.25),
          colors=brewer.pal(8, "Dark2"))

#figPath = system.file("download.png",package = "wordcloud2")
#library(wordcloud2)
#wordcloud2(data = frequency1[,c(1,2)], figPath = "download.png", size = 0.5,color = "skyblue")
#wordcloud2(data = frequency1, size = 0.7, shape = 'rhombus')

#Document - by term matrix
tidy_tdm = tidy_dataset4%>%
  count(word,word)%>%
  cast_dtm(word,word,n)

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
#install.packages("RColorBrewer")
library(RColorBrewer)
#install.packages("wordcloud2")
library(wordcloud2)

get_sentiments("bing") %>%
  distinct(sentiment)

get_sentiments('nrc') %>%
  distinct(sentiment)

#Count of positive and negative comments
tidy_dataset4 %>%
  inner_join(get_sentiments("bing"))%>%
  count(sentiment) %>%
  spread(sentiment,n,fill = 0)%>%
  mutate(diffsent = positive-negative)

#positive = tidy_dataset4 %>%
#  inner_join(get_sentiments("bing"))%>%
#  filter(sentiment == "positive")


#wordcloud(positive[,2],
#          max.words = 100,
#          random.order=FALSE,
#          rot.per=0.30,
#          use.r.layout=FALSE,
#          colors=brewer.pal(9, "Greens"))

#Count of different sentiments such as joy and sadness, Trust and fear
nrc_joysad = get_sentiments('nrc') %>%
  filter(sentiment=='joy'|
           sentiment =='sadness')

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
    slice(1:10,60:70))

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

nrc_trstfear = get_sentiments('nrc') %>%
  filter(sentiment == 'trust' |
           sentiment == 'fear')

nrow(nrc_trstfear)

(tweet_trstfear = tidy_dataset4 %>%
    inner_join(nrc_trstfear) %>%
    count(word, sentiment) %>%
    spread(sentiment, n, fill = 0) %>%
    mutate(trustworthy = trust - fear, linenumber = row_number()) %>%
    arrange(desc(trustworthy)))

(tweet_trstfear = tidy_dataset4 %>%
    inner_join(nrc_trstfear) %>%
    count(word, sentiment) %>%
    spread(sentiment, n, fill = 0) %>%
    mutate(trustworthy = trust - fear, linenumber = row_number()) %>%
    arrange(desc(trustworthy)) %>%
    slice(1:10,107:116))

#Plot to show the trust and fear
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

Merger_tweets %>%
  filter(str_detect(Text1, 'analyst|Analyst')) %>%
  select(Text1)

library(reshape2)

tidy_dataset4 %>%
  inner_join(nrc_trstfear) %>%
  count(word, sentiment) %>%
  slice(1:10,107:116)%>%
  acast(word~sentiment, value.var='n',fill=0) %>%
  comparison.cloud(colors=c('gray30','gray70'))


#Parts of speech Recognition

ud_model = udpipe_download_model(language = "english")

tidy_post1 = tidy_dataset4 %>%
  select(word)

ud_model = udpipe_load_model(ud_model$file_model)

x = as.data.frame(udpipe_annotate(ud_model, x = tidy_post1$word))

post_stats = txt_freq(x$upos)

post_stats$key = factor(post_stats$key, levels = rev(post_stats$key))

ggplot(post_stats, aes(x=key, y=as.factor(freq), fill=key)) +
  coord_flip() +
  theme_light(base_size = 15) +
  labs(
    x='Frequency',
    y='',
    title='UPOS (Universal Parts of Speech)'
  ) +
  theme(
    legend.position = 'none',
    panel.grid = element_blank(),
    axis.title = element_text(size = 10),
    axis.text.x = element_text(size = 10),
    axis.text.y = element_text(size = 10),
    title = element_text(size = 13)
  ) +
  geom_col() +
  scale_fill_grey()

#Nouns in the text
noun_stats = subset(x, upos %in% c("NOUN"))

noun_stats2 = txt_freq(noun_stats$token)

noun_stats2$key = factor(noun_stats2$key, levels = rev(noun_stats2$key))

noun_stats2 %>%
  slice(1:20) %>%
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


#Adjectives in the text
adjstats = subset(x, upos %in% c("ADJ"))

adjstats2 = txt_freq(adjstats$token)

adjstats2$key = factor(adjstats2$key, levels = rev(adjstats2$key))

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

#Verbs in the text
verbstats = subset(x, upos %in% c("VERB"))

verbstats2 = txt_freq(verbstats$token)

verbstats2$key = factor(verbstats2$key, levels = rev(verbstats2$key))

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

