#Scraping user comments data on Sprint from twitter

import twitter
import tweepy

apikey = 'G5QRq5GDOtpJ7CyyCyOzZby4p'

apisecretkey = 'B7uN3w3WbFmHznmeavBJthE6lMY8sf0RGJWYFpJ1tDTj11u3j6'

accesstok = '944975323744976896-4UQhwB6dXtWTIEgD5GjW02e5TjkHKYZ'

accesstoksec = 'g38CoTx5N2rJMarurL2Zyf9eqAtQ14ktOunRkvi0lIIzm'

 

twitconn = twitter.Api(consumer_key=apikey,

                       consumer_secret=apisecretkey,

                       access_token_key=accesstok,

                       access_token_secret=accesstoksec)

twitconn.VerifyCredentials()
tweet1 = twitconn.GetSearch(raw_query='q=from%3Asprintnews',count=10)
tweet1
tweet2 = twitconn.GetUserTimeline(screen_name='sprintnews', count=50)
tweet2

for item in tweet2:

    print(item.text) 

#tweet3 = twitconn.GetSearch(raw_query='q="%40BYUfootball"%20until%3A2019-08-10%20since%3A2019-08-01')

tweet3 = twitconn.GetSearch(raw_query='q=from%3ABYUfootball%20until%3A2019-09-27%20since%3A2019-09-17')
 
for item in tweet3:

    print(item.id, item.text)

import regex
    
import pandas as pd
tweet2 = twitconn.GetUserTimeline(screen_name='tableaupublic', count=10)
tweet2
tweet2 = twitconn.GetUserTimeline(screen_name = 'sprint',
                           count=200)
tweet4 = twitconn.GetSearch(raw_query='q=from%3Atableaupublic%20%23votd%20until%3A2019-10-07%20since%3A2019-10-03',count=20)
for item in tweet4:
    print(item.created_at)
for item in tweet4:
    print(item.retweet_count)
for item in tweet4:
    print(item.favorite_count)
for item in tweet2:
    print(item.text)
for item in tweet4:
    print(item.id)
for item in tweet4:
    print(item.media)
d = []
for item in tweet2:
    d.append((item.created_at,item.text))

df = pd.DataFrame(d, columns=('date','text'))
df[df['text'].str.match('.+ (Offers|Discount) [.]*')]

#question(1-d)

import tweepy
from tweepy import OAuthHandler
import json
import wget
 
consumer_key = 'G5QRq5GDOtpJ7CyyCyOzZby4p'
consumer_secret = 'B7uN3w3WbFmHznmeavBJthE6lMY8sf0RGJWYFpJ1tDTj11u3j6'
access_token = '944975323744976896-4UQhwB6dXtWTIEgD5GjW02e5TjkHKYZ'
access_secret = 'g38CoTx5N2rJMarurL2Zyf9eqAtQ14ktOunRkvi0lIIzm'


 
auth = OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_secret)
 
api = tweepy.API(auth)
tweets = api.user_timeline(screen_name = 'tableaupublic',
                           count=20)
media_files = set()
for status in tweets:
    media = status.entities.get('media', [])
    if(len(media) > 0):
        media_files.add(media[0]['media_url'])

for media_file in media_files:
    wget.download(media_file)


#Question2
tweets = twitconn.GetUserTimeline(screen_name = 'tableaupublic',
                           count=200,include_rts=False,
                           exclude_replies=True)
last_id = tweets[-1].id#obtaining the oldest tweet
 
while (True):
    more_tweets = twitconn.GetUserTimeline(screen_name='tableaupublic',
                                count=200,
                                include_rts=False,
                                exclude_replies=True,
                                max_id=last_id-1)
    if (len(more_tweets) == 0):#There are no more tweets
        break
    else:
      last_id = more_tweets[-1].id-1
      tweets = tweets + more_tweets



import twitter 
import tweepy
from tweepy.auth import OAuthHandler
import GetOldTweets3 as got

import pandas as pd
import requests
apikey = 'G5QRq5GDOtpJ7CyyCyOzZby4p'
apisecretkey = 'B7uN3w3WbFmHznmeavBJthE6lMY8sf0RGJWYFpJ1tDTj11u3j6'
accesstok = '944975323744976896-4UQhwB6dXtWTIEgD5GjW02e5TjkHKYZ'
accesstoksec = 'g38CoTx5N2rJMarurL2Zyf9eqAtQ14ktOunRkvi0lIIzm'

twitconn = twitter.Api(consumer_key=apikey, consumer_secret=apisecretkey, access_token_key=accesstok, access_token_secret=accesstoksec)

twitconn.VerifyCredentials()

tweet1 = twitconn.GetSearch(raw_query='q=%23VOTD%20from%3Atableaupublic',count =30)



#tweet1 = twitconn.GetUserTimeline(screen_name='tableaupublic', until = '2019-08-13', since= '2019-08-01')
for item in tweet1:
    item.id

text= []

tweetCriteria = got.manager.TweetCriteria().setQuerySearch('#sprinttmobilemerger').setSince("2018-04-01").setUntil("2018-12-31").setMaxTweets(1000)
for i in range(0,len(got.manager.TweetManager.getTweets(tweetCriteria))):
    tweet = got.manager.TweetManager.getTweets(tweetCriteria)[i]
    print(tweet.text)


    text.append(tweet.text)

    retweet.append(tweet.retweets)
    date1.append(str(tweet.date))
    fav.append(tweet.favorites)


d={"Tweet":text,"Retweets":retweet,"Date":date1,"Favourites":fav}
Data_Frame = pd.DataFrame(d)
Data_Frame
api = tweepy.API(auth, wait_on_rate_limit=True)
import sys
screen_name='sprint'
replies=[] 
non_bmp_map = dict.fromkeys(range(0x10000, sys.maxunicode + 1), 0xfffd)  
for full_tweets in tweepy.Cursor(api.user_timeline,screen_name='sprint',timeout=999999).items(50):
  for tweet in tweepy.Cursor(api.search,q='to:'+screen_name,result_type='recent',timeout=999999).items(100):
    if hasattr(tweet, 'in_reply_to_status_id_str'):
      if (tweet.in_reply_to_status_id_str==full_tweets.id_str):
        replies.append(tweet.text)
  print("Tweet :",full_tweets.text.translate(non_bmp_map))
  for elements in replies:
       print("Replies :",elements)
  replies.clear()









CONSUMER_KEY = "<consumer key>"
CONSUMER_SECRET = "<consumer secret>"
OAUTH_TOKEN = "<application key>"
OAUTH_TOKEN_SECRET = "<application secret"

import Twython
consumer_key = 'G5QRq5GDOtpJ7CyyCyOzZby4p'
consumer_secret = 'B7uN3w3WbFmHznmeavBJthE6lMY8sf0RGJWYFpJ1tDTj11u3j6'
access_token = '944975323744976896-4UQhwB6dXtWTIEgD5GjW02e5TjkHKYZ'
access_secret = 'g38CoTx5N2rJMarurL2Zyf9eqAtQ14ktOunRkvi0lIIzm'
twitter = Twython(
    consumer_key, consumer_secret,
    access_token, access_secret)

tweet = twitter.show_status(id=849667487180259000)
print(tweet['text'])


auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_secret)
api = tweepy.API(auth)

tweet = api.get_status(848377839384760320)
print(tweet.text)


x = "220193"
x[4:6]

import pandas as pd
import numpy as np
df1 = {
    'State':['Arizona AZ','Georgia GG','Newyork NY','Indiana IN','Florida FL'],
   'Score1':[4523,4776,5545,7421,3121]}
 
df1 = pd.DataFrame(df1,columns=['State','Score1'])

df1.Score1[:-2]


s = substring(df1.Score1, 1, 2)




