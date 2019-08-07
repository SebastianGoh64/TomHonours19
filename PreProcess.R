library(tm)
library(dplyr)

#reading tweets as characters & convert date
#raw_tweets <- read.csv("Raw Data/tweets.csv", header = TRUE, colClasses = c("character", "character", "character", "character"))
raw_tweets <- read.csv("Raw Data/tweets.csv", header = TRUE, colClasses = c(rep("character",4)))
sum(is.na(df))

raw_tweets$created_at <- as.Date(raw_tweets$created_at)

sapply(raw_tweets, class)

#sampling from data frame
raw_tweets[sample(nrow(raw_tweets), 3), ]

#sampling from single column
sample(raw_tweets$tweet_id, 50)

#converting from data frame to corpus
tweetCorp <- Corpus(DataframeSource(raw_tweets))

#cleaning text
#removing non ASCII characters
clean_tweets <- gsub("[^\x01-\x7F]", "", raw_tweets$text)
#remove punctuation, stop words & URL
clean_tweets <- tm_map(clean_tweets, removePunctuation)

clean_tweets <- tm_map(clean_tweets, content_transformer(tolower))

clean_tweets <- tm_map(clean_tweets, removeWords, stopwords("english"))