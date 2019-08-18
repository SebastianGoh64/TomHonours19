library(tm)
library(dplyr)

tweet_count <- as.data.frame(table(edit_tweet$user_name))

tweet_count <- tweet_count[order(tweet_count$Freq, decreasing = TRUE),]

#select top 20 tweeters 
sub_acc <- head(tweet_count, 20)
sub_acc <- sub_acc$Var1
sub_acc <- as.character(sub_acc)

sub_tweet <- filter(edit_tweet, user_name %in% c(sub_acc))

unique(sort(sub_tweet$user_name)) == unique(sort(sub_acc))

#converting from data frame to corpus
sub_Corp <- Corpus(DataframeSource(sub_tweet))

inspect(sub_Corp[10])

#remove punctuation, stop words & URL
sub_Corp <- tm_map(sub_Corp, removePunctuation)

sub_Corp <- tm_map(sub_Corp, content_transformer(tolower))

sub_Corp <- tm_map(sub_Corp, removeWords, stopwords("english"))

rm_URL <- function(x) 
  gsub('http\\S+\\s*', '', x)

sub_Corp <- tm_map(sub_Corp, rm_URL)

sub_Corp <- tm_map(sub_Corp, stripWhitespace)

inspect(sub_Corp[10])