dracula<-gutenberg_download(345)

#use tidytext to unpack the words in the novel-works with dplyr

dracula_words<-dracula%>%
  unnest_tokens(word,text)

#Don't need to do stop words because they won't show up in the list of words
#that have been assigned sentiments

bing<-get_sentiments('bing')

#Take two data frames, dracula and bing, and join them through the common column

dracula_words<-inner_join(dracula_words,bing)

#Remove the gutenberg id column - dollar sign identifies the column

dracula_words$gutenberg_id<-NULL

dracula_words<-dracula_words%>%
  group_by(word)%>%
  summarize(freq=n(),sentiment=first(sentiment))

#Install tm, wordcloud, and wordcloud2

wordcloud(dracula_words$word,dracula_words$freq, min.freq = 5)

wordcloud2(dracula_words,fig='bat.jpg',size=.5,backgroundColor ='black')

#Load reshape2.  Break negative and positive column into two separate columns.  Word
#is rows, sentiment is column.

dracula_matrix<-acast(dracula_words,word~sentiment,value.var='freq',fill=0)

comparison.cloud(dracula_matrix,colors=c('black','green'))





