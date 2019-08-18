library(tm)
library(dplyr)

#reading tweets as characters & convert date
#raw_tweets <- read.csv("Raw Data/tweets.csv", header = TRUE, colClasses = c("character", "character", "character", "character"))
raw_tweets <- read.csv("Raw Data/tweets.csv", header = TRUE, colClasses = c(rep("character",4)))
sum(is.na(df))

raw_tweets$created_at <- as.Date(raw_tweets$created_at)

sapply(raw_tweets, class)

#transform data frame so it can be read by tm corpus command
raw_tweets <- raw_tweets[,c(1,4,2,3)]

raw_tweets <- rename(raw_tweets, doc_id = tweet_id)

sapply(raw_tweets, class)

#clean ASCII and URL

clean_tweet <- raw_tweets

clean_tweet$text <- gsub('http\\S+\\s*', '', clean_tweet$text)

clean_tweet$text <- gsub("[^\x01-\x7F]", '', clean_tweet$text)

#converting from data frame to corpus
tweetCorp <- Corpus(DataframeSource(clean_tweet))

inspect(tweetCorp[10])

#function to remove non ASCII characters & URL (not working)

#rm_URL <- content_transformer(function(x) 
 # {gsub('http\\S+\\s*', '', x)
  #gsub("http[[:alnum:][:punct:]]*", "", x)
  #gsub("[^\x01-\x7F]", '', x)
#})

#remove punctuation, stop words & URL

#tweetCorp <- tm_map(tweetCorp, rm_URL)

tweetCorp <- tm_map(tweetCorp, content_transformer(tolower))

tweetCorp <- tm_map(tweetCorp, removeWords, stopwords("english"))

tweetCorp <- tm_map(tweetCorp, removePunctuation)

tweetCorp <- tm_map(tweetCorp, stripWhitespace)

#think about the best way to deal with hashtags, specifically take them out?
#if don't take them out then you get weird words like criticalinfrastructure

inspect(tweetCorp[10])

clean_tweet <- data.frame(text = sapply(tweetCorp, as.character), stringsAsFactors = FALSE)

clean_tweet <- data.frame(doc_id = raw_tweets$doc_id, text = clean_tweet$text, user_name = raw_tweets$user_name, created_at = raw_tweets$created_at, stringsAsFactors = FALSE)

head(clean_tweet, 5)

sapply(clean_tweet, class)


#check immigration words

imm_words <- c("immig*", "islam*", "african gangs")

imm_sub <- sub_tweet %>% 
  filter(str_detect(payload, paste(strings, imm_words = "|")))

require(stringr)

raw_tweets %>%
  select(doc_id, text, user_name) %>%
  filter(str_detect(text, "immigr*")) %>%
  count(user_name) %>%
  arrange(desc(n)) %>%
  head(5)
