library(wordcloud)
library(tm)
reviews <- read.csv ("reviews.csv", stringsAsFactors=FALSE)

review_text <- paste(reviews$text, collapse=" ")
review_source <- VectorSource(review_text)

corpus <- Corpus(review_source)
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)

corpus <- tm_map(corpus, stripWhitespace)

corpus <- tm_map(corpus, removeWords, stopwords("english"))

dtm <- DocumentTermMatrix(corpus)
dtm2 <- as.matrix(dtm)
frequency <- colSums(dtm2)
frequency <- sort(frequency, decreasing=TRUE)

words <- names(frequency)
wordcloud(words[1:100], frequency[1:100])
