#This helps to scrape user comments from Twitter on Sprint

install.packages('twitteR')
library(twitteR)
library(rlist)
consumer_key = "G5QRq5GDOtpJ7CyyCyOzZby4p"
consumer_secret = "B7uN3w3WbFmHznmeavBJthE6lMY8sf0RGJWYFpJ1tDTj11u3j6"
access_token = "944975323744976896-4UQhwB6dXtWTIEgD5GjW02e5TjkHKYZ"
access_secret = "g38CoTx5N2rJMarurL2Zyf9eqAtQ14ktOunRkvi0lIIzm"
setup_twitter_oauth(consumer_key,consumer_secret,access_token,access_secret)


Tweet = searchTwitter(searchString = 'from:sprintnews+discount')

Week_1 = searchTwitter('#sprintdiscount',since='2011-09-25',until='2019-10-02')
Week_1
Week_2 = searchTwitter('#datascience',since='2019-09-18',until='2019-10-02')
Week_2
Week_3 = searchTwitter('#data+science', since = '2019-09-11', until = '2019-10-02')
Week_3
Week_4 = searchTwitteR('#datascience', since='2019-09-04', until='2019-10-02')
Week_4

pythoncode = searchTwitteR('python+code', since = '2019-09-02', until = '2019-10-02', n = 20)
pythoncode[[17]]$created

Search = searchTwitteR(searchString = 'data+science-python')


Search_1 = searchTwitteR ('ggplot+ggplot2')
Search_1[[1]]$text

regex_1 = "(\\w+)[: #]+(ggplot|ggplot2) (\\w+) "
regex_2 = "(\\w+)\\s+(Datascience|datascience) (\\w+) "
regex_3 = "(\\w+)\\s+python (\\w+) "


for (i in 1:25){
  x = list.append(str_extract(Search_1[[i]]$text, regex_1))
  print(x)
}
for (i in 1:25){
  y = list.append(str_extract(Tweet[[i]]$text, regex_2))
  print(y)
}

for (i in 1:20) {
  z = list.append(str_extract(pythoncode[[i]]$text, regex_3))
  print(z)
}








