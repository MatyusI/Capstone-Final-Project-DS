## Loading the original data set 

blogs <- readLines("en_US.blogs.txt", encoding = "UTF-8", skipNul=TRUE) 
news <- readLines("en_US.news.txt", encoding = "UTF-8", skipNul=TRUE) 
twitter <- readLines("en_US.twitter.txt", encoding = "UTF-8", skipNul=TRUE) 


## Generating a random sapmle of all sources 

sTwitter <- sample(twitter, 20000) 
sNews <- sample(news, 20000) 
sBlogs <- sample(blogs, 20000) 
textS <- c(sTwitter,sNews,sBlogs) 

## Save sample 

## Building a clean corpus 

CorpusCon <- file("./NewTextS.txt") 
Corpus <- readLines(CorpusCon) 
close(CorpusCon) 


#### install.packages("NLP")
#### install.packages("tm")
#### install.packages("stringi")
#### install.packages("Snowballc")
#### install.packages("RWeka")
 
library("NLP")
library("tm")
library("stringi")
library("SnowballC")
library("RWeka")

## Build the corpus, and specify the source to be character vectors  
VCorpus <- Corpus(VectorSource(Corpus)) 
 
## 
rm(Corpus) 
 

## Make it work with the new tm package 
VCorpus<- tm_map(VCorpus, content_transformer(function(x)
            iconv(x, to="UTF-8", sub="byte"))) 
 
## Convert to lower case 

VCorpus <- stri_trans_tolower(VCorpus)

## remove punction, numbers, URLs, stop, profanity and stem wordson 
VCorpus <- Corpus(VectorSource(VCorpus))
VCorpus <- tm_map(VCorpus, content_transformer(removePunctuation))
VCorpus <- tm_map(VCorpus, content_transformer(removeNumbers))
toSpace <- content_transformer(function(x, pattern) gsub(pattern, " ", x))
VCorpus <- tm_map(VCorpus, toSpace, "(f|ht)tp(s?)://(.*)[.][a-z]+")
VCorpus <- tm_map(VCorpus, toSpace, "@[^\\s]+")
removeURL <- function(x) gsub("http[[:alnum:]]*", "", x)  
VCorpus <- tm_map(VCorpus, content_transformer(removeURL)) 
VCorpus <- tm_map(VCorpus, stripWhitespace) 
VCorpus <- tm_map(VCorpus, removeWords, stopwords("english")) 
profanityWords <- read.table("./profanityfilter.txt", header = FALSE)
VCorpus <- tm_map(VCorpus, removeWords, profanityWords) 
VCorpus <- tm_map(VCorpus, stemDocument) 
VCorpus <- tm_map(VCorpus, stripWhitespace) 
VCorpus <- tm_map(VCorpus, PlainTextDocument)


## Saving the final corpus 
saveRDS(VCorpus, file = "finalCorpus.Rds") 

## Budilding the n-grams 


finalCorpus <- readRDS("finalCorpus.Rds") 
finalCorpus <- VCorpus(VectorSource(finalCorpus))
finalCorpusDF <-data.frame(text=unlist(sapply(finalCorpus,`[`, "content")),  
                           stringsAsFactors = FALSE) 


## Building the tokenization function for the n-grams

ngramTokenizer <- function(theCorpus, ngramCount) { 
           ngramFunction <- RWeka::NGramTokenizer(theCorpus,
                                    RWeka::Weka_control(min = ngramCount, max = ngramCount,  
                            delimiters = " \\r\\n\\t.,;:\"()?!")) 
           ngramFunction <- data.frame(table(ngramFunction)) 
           ngramFunction <- ngramFunction[order(ngramFunction$Freq,  
                                    decreasing = TRUE),]
           colnames(ngramFunction) <- c("name","freq") 
           ngramFunction 
} 


monogram <- ngramTokenizer(finalCorpusDF, 1) 
monogram <- transform(monogram, String = as.character(String))
saveRDS(monogram, file = "monogram.Rds") 

bigram <- ngramTokenizer(finalCorpusDF, 2)
bigram <- transform(bigram, String = as.character(String))
saveRDS(bigram, file = "bigram.Rds") 

trigram <- ngramTokenizer(finalCorpusDF, 3) 
trigram <- transform(trigram, String = as.character(String))
saveRDS(trigram, file = "trigram.Rds") 

quadgram <- ngramTokenizer(finalCorpusDF, 4) 
quadgram <- transform(quadgram, String = as.character(String))
saveRDS(quadgram, file = "quadgram.Rds") 




