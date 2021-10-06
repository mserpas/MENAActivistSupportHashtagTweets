## Library Loads##
library(twitteR)
library(dplyr)
library(rtweet)
library(ggplot2)
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

dontexecute_fa <-search_tweets("#اعدام_نکنید",n=18000,include_rts = FALSE)
stopexeciran<-search_tweets("#StopExecutionsInIran",n=18000,include_rts = FALSE)
savenafid<-search_tweets("#savenafidafkari",n=18000,include_rts = FALSE)
stopexecnow<-search_tweets("#لغو ـ فوری ـ اعدام",n=18000,include_rts = FALSE)
freenasrin <-search_tweets("#freenasrin",n=18000,include_rts = FALSE)
freeloujain<-search_tweets("#freeloujain",n=18000,include_rts = FALSE)
savealaa<-search_tweets("#savealaa",n=18000,include_rts = FALSE)
freealaa_a<-search_tweets("#freealaa",n=18000,include_rts = FALSE)
freenarges<-search_tweets("#freenarges",n=18000,include_rts = FALSE)
freesanaa<-search_tweets("#freesanaa",n=18000,include_rts = FALSE)

#Activist Outcomes and Appending Related Hashtags#

##Don't Execute##

dontexecute<-bind_rows(dontexecute_fa,stopexeciran,stopexecnow,savenafid)

dontexecute<-dontexecute%>%
  mutate(
    status = "Veredict Halted",
    Sentence = "Death",
    arrestlengthyrs ="NA",
    timeservedyrs="NA",
    charges1= "Violence Against State",
    charges2="Murder",
    charges3="NA",
    activismtype= "Civil & Political Rights",
    country= "Iran"
  )

##Nasrin Sotoudeh## 

freenasrin<-freenasrin%>%
  mutate(
    status = "Sentenced",
    Sentence = "Imprisonment",
    arrestlengthyrs ="33",
    timeservedyrs="3",
    charges1= "Undisclosed",
    charges2="NA",
    charges3="NA",
    activismtype= "Women's Rights",
    country= "Iran"
  )

##Loujain Al-Hathloul##

freeloujain<-freeloujain%>%
  mutate(
    status = "Conditional Release",
    Sentence = "Imprisonment",
    arrestlengthyrs ="5.67",
    timeservedyrs="2.74",
    charges1= "Terrorism",
    charges2="NA",
    charges3="NA",
    activismtype= "Women's Rights",
    country= "Saudi Arabia"
  )

##Alaa Abd El-Fattah##

freealaa<-bind_rows(freealaa_a,savealaa)

freealaa<-freealaa%>%
  mutate(
    status = "In Custody",
    Sentence = "Awaiting Veredict",
    arrestlengthyrs ="NA",
    timeservedyrs="NA",
    charges1= "Assembly",
    charges2="NA",
    charges3="NA",
    activismtype= "Civil & Political Rights",
    country= "Egypt"
  )

##Narges Mohammadi##

freenarges<-freenarges%>%
  mutate(
    status = "Released",
    Sentence = "Imprisonment",
    arrestlengthyrs ="16",
    timeservedyrs="4",
    charges1= "Assembly",
    charges2="Anti-Government Propaganda",
    charges3="Collusion",
    activismtype= "Human Rights",
    country= "Iran"
  )

##Sanaa Seif## 

freesanaa<-freesanaa%>%
  mutate(
    status = "Sentenced",
    Sentence = "Imprisonment",
    arrestlengthyrs ="1.5",
    timeservedyrs=".5",
    charges1= "Misuse of Social Media",
    charges2="Spreading False Rumors",
    charges3="NA",
    activismtype= "Civil & Political Rights",
    country= "Egypt"
  )

#Final DataSet#

ActivistTweets<-bind_rows(freesanaa,freenarges,freealaa,freeloujain,freenasrin,dontexecute)

ActivistTweets = data.frame(lapply(ActivistTweets, as.character), stringsAsFactors=FALSE)

write.csv(ActivistTweets,"ActivistTweets20211005.csv")
