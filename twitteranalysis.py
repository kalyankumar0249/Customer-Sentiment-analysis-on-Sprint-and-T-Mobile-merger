#Sentiment analysis on the T-mobile sprint merger user comment data scraped from Twitter

import os
import pandas as pd
import numpy as np
import requests
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import nltk
import regex as re
from nltk.stem import PorterStemmer
import wordcloud
import matplotlib.pyplot as plt
from wordcloud import WordCloud, STOPWORDS
#nltk.download('punkt')
#nltk.download('averaged_perceptron_tagger')
#nltk.download('maxent_ne_chunker')
#nltk.download('words')

from nltk import word_tokenize, pos_tag, ne_chunk
from nltk.chunk import conlltags2tree, tree2conlltags

#upload the data
os.getcwd()

os.chdir('D:\\MSIS(R and Python)\\Project')

merger_tweets = pd.read_table('cleanfile2.csv', sep = ',')
merger_tweets.head()
textbank = merger_tweets.tweet.str.cat(sep=' ')

#tokenizing the words
post1 = pos_tag(word_tokenize(textbank))
print(post1)

tree1 = ne_chunk(post1)
print(tree1)

entityp = []
entityo = []
entityg = []
entitydesc = []

#named entity recognition for person, organization, geographical location
for x in str(tree1).split('\n'):
    if 'PERSON' in x:
        entityp.append(x)
    elif 'ORGANIZATION' in x:
        entityo.append(x)
    elif 'GPE' in x or 'GSP' in x:
        entityg.append(x)
    elif '/NN' in x:
        entitydesc.append(x)

entityp
entityo
entityg
entitydesc

iob_tag = tree2conlltags(tree1)
print(iob_tag)

entityp1 = re.sub(r'/NNP','', str(entityp))
entityp1 = re.sub(r'/NNPS','', entityp1)
entityp1 = re.sub(r'/JJ','', entityp1)
entityp1 = re.sub(r'GPE','', entityp1)
entityp1 = re.sub(r'PERSON','', entityp1)
entityp1 = re.sub(r'NN','', entityp1)
from PIL import Image
from os import path
#To make word cloud in the shape of twitter symbol. The png is just a black and white twitter icon
#named entity - person
d = path.dirname(__file__) if "__file__" in locals() else os.getcwd()
person_mask = np.array(Image.open(path.join(d, "download (1).png")))
stopwords = set(STOPWORDS)
wordcloud = WordCloud(
       background_color='white',
       stopwords=stopwords,
       max_words=500,
       mask = person_mask,
       max_font_size=40, 
       scale=3,
   ).generate(str(entityp1))

plt.figure(1, figsize=(12, 12))
plt.axis('off')
   
plt.imshow(wordcloud)
plt.show()

#named entity - Organization
entityo1 = re.sub(r'/NNP','', str(entityo))
entityo1 = re.sub(r'/NNPS','', entityo1)
entityo1 = re.sub(r'/JJ','', entityo1)
entityo1 = re.sub(r'GPE','', entityo1)
entityo1 = re.sub(r'ORGANIZATION','', entityo1)
organization_mask = np.array(Image.open(path.join(d, "download (1).png")))
stopwords = set(STOPWORDS)
wordcloud = WordCloud(
       background_color='white',
       stopwords=stopwords,
       max_words=200,
       max_font_size=40,
       mask = organization_mask,
       scale=3,
   ).generate(str(entityo1))

plt.figure(1, figsize=(12, 12))
plt.axis('off')
   
plt.imshow(wordcloud)
plt.show()

#named entity - Geographical location
entityg1 = re.sub(r'/NNP','', str(entityg))
entityg1 = re.sub(r'/NNPS','', entityg1)
entityg1 = re.sub(r'/JJ','', entityg1)
entityg1 = re.sub(r'GPE','', entityg1)
entityg1 = re.sub(r'GSP','', entityg1)
entityg1 = re.sub(r'/NN','', entityg1)
geography_mask = np.array(Image.open(path.join(d, "download.png")))
stopwords = set(STOPWORDS)
wordcloud = WordCloud(
       background_color='white',
       stopwords=stopwords,
       max_words=200,
       max_font_size=40,
       mask = geography_mask,
       scale=3,
   ).generate(str(entityg1))

plt.figure(1, figsize=(12, 12))
plt.axis('off')
   
plt.imshow(wordcloud)
plt.show()



import nltk

# download the stopwords dictionary if you have not already

#nltk.download('stopwords')

from nltk import word_tokenize, sent_tokenize

from nltk.corpus import stopwords

from nltk.stem import LancasterStemmer, WordNetLemmatizer, PorterStemmer

merger_tweets.columns

merger_tweets.rename(columns={'tweet': 'tweettext'}, inplace=True)

merger_tweets['tweettext'] = merger_tweets['tweettext'].apply(lambda x: " ".join(x.lower() for x in x.split()))

merger_tweets['tweettext'][2]

#removal of digits and unnecessary words
patterndigits = '\\b[0-9]+\\b'

merger_tweets['tweettext'] = merger_tweets['tweettext'].str.replace(patterndigits,'')

patternpunc = '[^\w\s]'

merger_tweets['tweettext'] = merger_tweets['tweettext'].str.replace(patternpunc,'')


merger_tweets['tweettext'][2]

stop = stopwords.words('english')

# Before removal of stopwords

merger_tweets['tweettext'][2]

merger_tweets['tweettext'] = merger_tweets['tweettext'].apply(lambda x: " ".join(x for x in x.split() if x not in stop))

# After removal of stopwords

merger_tweets['tweettext'][2]

network_names = ['sprint','tmobile','sprinttmobilemerger','tmobilesprintmerger','sprintmerger','tmobilemerger'] 

merger_tweets['tweettext'] = merger_tweets['tweettext'].apply(lambda x: " ".join(x for x in x.split() if x not in network_names))

porstem = PorterStemmer()

merger_tweets['tweettext'] = merger_tweets['tweettext'].apply(lambda x: " ".join([porstem.stem(word) for word in x.split()]))

merger_tweets['tweettext'][2]

from sklearn.feature_extraction.text import CountVectorizer

vectorizer = CountVectorizer()

tokens_data = pd.DataFrame(vectorizer.fit_transform(merger_tweets['tweettext']).toarray(), columns=vectorizer.get_feature_names())

from sklearn.feature_extraction.text import CountVectorizer

from sklearn.decomposition import LatentDirichletAllocation

from sklearn.feature_extraction.text import TfidfVectorizer

from sklearn.decomposition import NMF

 

from sklearn.model_selection import train_test_split

from sklearn.ensemble import RandomForestClassifier

from sklearn.metrics import classification_report, confusion_matrix, accuracy_score

#plot_size = plt.rcParams["figure.figsize"]

#print(plot_size[0])

#print(plot_size[1])


#plot_size[0] = 8

#plot_size[1] = 6

#plt.rcParams["figure.figsize"] = plot_size

#Creation of topics

vectorizer = CountVectorizer(max_df=0.8, min_df=4, stop_words='english')

doc_term_matrix = vectorizer.fit_transform(merger_tweets['tweettext'].values.astype('U'))

doc_term_matrix

LDA = LatentDirichletAllocation(n_components=5, random_state=35)

LDA.fit(doc_term_matrix)

first_topic = LDA.components_[0]

#first topic top words
top_topic_words = first_topic.argsort()[-10:]


for i in top_topic_words:

   print(vectorizer.get_feature_names()[i]) 


for i,topic in enumerate(LDA.components_):

   print(f'Top 10 words for topic #{i}:')

   print([vectorizer.get_feature_names()[i] for i in topic.argsort()[-10:]])

   print('\n')

#document term matrix
topic_values = LDA.transform(doc_term_matrix)

topic_values.shape

merger_tweets['topic'] = topic_values.argmax(axis=1)

merger_tweets.head()


tfidf_vect = TfidfVectorizer(max_df=0.8, min_df=5, stop_words='english')

doc_term_matrix2 = tfidf_vect.fit_transform(merger_tweets['tweettext'].values.astype('U'))

nmf = NMF(n_components=5, random_state=42)

nmf.fit(doc_term_matrix2)

first_topic = nmf.components_[0]

top_topic_words = first_topic.argsort()[-10:]

#Top 5 topics
for i in top_topic_words:

   print(tfidf_vect.get_feature_names()[i])



for i,topic in enumerate(nmf.components_):

   print(f'Top 10 words for topic #{i}:')

   print([tfidf_vect.get_feature_names()[i] for i in topic.argsort()[-10:]])

   print('\n')

 

topic_values2 = nmf.transform(doc_term_matrix2)

merger_tweets['topic2'] = topic_values2.argmax(axis=1)

merger_tweets.head()


features = merger_tweets['tweettext']

vectorizer = TfidfVectorizer (max_features=2500, min_df=7, max_df=0.8, stop_words=stop)

processed_features = vectorizer.fit_transform(features).toarray()

merger_tweets.head()

merger_tweets['sentiment'] = get_tweet_sentiment(merger_tweets.tweettext)

labels = merger_tweets['topic']

 
#Dividing the data into training and testing to find the accuracy percentage
X_train, X_test, y_train, y_test = train_test_split(processed_features, labels, test_size=0.2, random_state=0)

 

text_classifier = RandomForestClassifier(n_estimators=200, random_state=0)

text_classifier.fit(X_train, y_train)

predictions = text_classifier.predict(X_test)

print(confusion_matrix(y_test,predictions))

print(classification_report(y_test,predictions))

print(accuracy_score(y_test, predictions))