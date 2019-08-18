#sampling from data frame
raw_tweets[sample(nrow(raw_tweets), 3), ]

#sampling from single column
sample(raw_tweets$tweet_id, 50)

sample(raw_tweets$text, 20)


#histogram of all tweets
hist(raw_tweets$created_at, "month", col="blue", xlab="Date", main="Date Distribution", start.on.monday = TRUE)

#5 year tweets histogram
fiveyr_tweet <- subset(raw_tweets, created_at > as.Date("2011-12-31"))
fiveyr_tweet <- fiveyr_tweet[order(fiveyr_tweet$created_at),]

head(fiveyr_tweet$created_at, 5)
tail(fiveyr_tweet$created_at, 5)

hist(fiveyr_tweet$created_at, "month", col="blue", xlab="Date", main="Date Distribution", start.on.monday = TRUE)

#last 3 years histogram
threeyr <- subset(raw_tweets, created_at > as.Date("2014-12-31"))
threeyr <- threeyr[order(threeyr$created_at),]
hist(threeyr$created_at, "month", col="blue", xlab="Date", main="Date Distribution", start.on.monday = TRUE)
