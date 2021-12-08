## Library Loads##
library(twitteR)
library(dplyr)
library(rtweet)
library(tidytext)
library(rvest)
library(jsonlite)

##Twitter API Info##

appname <- "your_appname"
key <- "your_consumer_key"
secret <- "your_consumer_secret"
access_token <- "your_access_token"
access_secret <- "your_access_secret"

# Create Twitter Token#
twitter_token <- create_token(
  app = appname,
  consumer_key = key,
  consumer_secret = secret,
  access_token = access_token,
  access_secret = access_secret)

##Harvesting Hashtag Data##


freeloujain<-search_fullarchive("#freeloujain",n=1000,fromDate = 201801010000,toDate = 202110070000,env_name = "FullArchive",safedir = NULL,parse = TRUE, token = twitter_token)
freenarges<-search_fullarchive("#freenarges",n=1000,fromDate = 201801010000,toDate = 202110070000,env_name = "FullArchive",safedir = NULL,parse = TRUE, token = twitter_token) 
freenasrin<-search_fullarchive("#freenasrin",n=1000,fromDate = 202006010000,toDate = 202110070000,env_name = "FullArchive",safedir = NULL,parse = TRUE, token = twitter_token)   
freesanaa<-search_fullarchive("#freesanaa",n=1000,fromDate = 202006010000,toDate = 202110070000,env_name = "FullArchive",safedir = NULL,parse = TRUE, token = twitter_token)   


#Activist Outcomes and Appending Related Hashtags#


##Case 1: Nasrin Sotoudeh## 

freenasrin<-freenasrin%>%
  mutate(
    casecountry = "Iran",
    casename = "freenasrin",
    outcome ="unfavorable"
  )

##Case 2: Loujain Al-Hathloul##

freeloujain<-freeloujain%>%
  mutate(
    casecountry = "Saudi Arabia",
    casename = "freeloujain",
    outcome ="favorable"
  )

##Case 3: Narges Mohammadi##

freenarges<-bind_rows(freenarges_a,fa_freenarges)

freenarges<-freenarges%>%
  mutate(
    casecountry = "Iran",
    casename = "freenarges",
    outcome ="favorable"
  )

##Case 4: Sanaa Seif## 

freesanaa<-freesanaa%>%
  mutate(
    casecountry = "Egypt",
    casename = "freeSanaa",
    outcome ="unfavorable"
  )

#Final DataSet#

ActivistTweets<-bind_rows(freesanaa,freenarges,freeloujain,freenasrin)

ActivistTweets = data.frame(lapply(ActivistTweets, as.character), stringsAsFactors=FALSE)


write.csv(ActivistTweets,"ActivistTweetsDec2021.csv")

ActivistTweets<-read.csv("ActivistTweetsDec2021.csv")


