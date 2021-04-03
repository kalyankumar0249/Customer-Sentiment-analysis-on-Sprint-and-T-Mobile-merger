#Merger tweets data from Twitter

import pandas as pd
import os

os.chdir('/Users/kalyan308/Desktop/Python data/pythonmerge')

import twint
c = twint.Config()

c.Search = "tmobilesprintmerger"
c.Since  = "2018-01-01"
c.Until  = "2019-11-30"
c.Store_csv=True
c.Output = 'Merger.csv'

twint.run.Search(c)

import twint
c = twint.Config()

c.Search = "sprinttmobilemerger"
c.Since  = "2018-01-01"
c.Until  = "2019-11-30"
c.Store_csv=True
c.Output = 'Merger1.csv'

twint.run.Search(c)

import twint
c = twint.Config()

c.Search = "sprintmerger"
c.Since  = "2018-01-01"
c.Until  = "2019-11-30"
c.Store_csv=True
c.Output = 'Merger2.csv'

twint.run.Search(c)

import twint
c = twint.Config()

c.Search = "tmobilemerger"
c.Since  = "2018-01-01"
c.Until  = "2019-11-30"
c.Store_csv=True
c.Output = 'Merger3.csv'

twint.run.Search(c)

#Import required modules/dependencies
import glob
extension = 'csv'
all_filenames = [i for i in glob.glob('*.{}'.format(extension))]

#Concatenating all the above created files
combined_csv = pd.concat([pd.read_csv(f) for f in all_filenames ])

#export to csv
combined_csv = pd.concat([pd.read_csv(f) for f in all_filenames ])
#export to csv
combined_csv.to_csv( "combined_csv.csv", index=False, encoding='utf-8-sig')

# Reading the dataset into a dataframe
df=pd.read_csv('combined_csv.csv')
df

#Cleaning the data to remove duplicates
df1=df.drop_duplicates(subset=None, keep='first', inplace=False)
df1

#Removing the variables not required
df2=df1.drop(columns=['conversation_id', 'photos', 'name', 'name','quote_url', 'video', 'near', 'geo',
                      'cashtags', 'retweet', 'retweet_id', 'reply_to', 'retweet_date', 'source', 'user_rt_id',
                      'user_rt'],axis=1)
df2

#Extracting year from date variable
df2['date'] = pd.to_datetime(df2['date'])
df2['year'] = df2['date'].dt.year
df2

#Exporting dataframe to csv file
export_csv = df2.to_csv (r'/Users/kalyan308/Desktop/Python data/pythonmerge/cleanfile2.csv', index = None, header=True)


