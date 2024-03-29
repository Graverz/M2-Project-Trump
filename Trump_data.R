
if (!require("pacman")) install.packages("pacman") # package for loading and checking packages :)
pacman::p_load(tidyverse, # Standard datasciewnce toolkid (dplyr, ggplot2 et al.)
               magrittr, # For advanced piping (%>% et al.)
               tidytext, # For text analysis
               tm,
               topicmodels,
               RJSONIO,
               lubridate
)

json_file17 <- fromJSON("//student.aau.dk/Users/jhhn14/Desktop/condensed_2017.json")
json_file18 <- fromJSON("//student.aau.dk/Users/jhhn14/Desktop/condensed_2018.json")

json_file17 <- lapply(json_file17, function(x) {
  x[sapply(x, is.null)] <- NA
  unlist(x)
})
json_file18 <- lapply(json_file18, function(x) {
  x[sapply(x, is.null)] <- NA
  unlist(x)
})

data17 <- do.call("rbind", json_file17) 
data18 <- do.call("rbind", json_file18) 

data <- rbind(data17,data18) %>% as.data.frame()

data$created_at <- data$created_at %>% as.character.Date()
data$text <- data$text %>%  as.character()

str(data)
data$day  <- str_sub(data$created_at,5, 10)
data$year <- str_sub(data$created_at,27)
#data$time <- str_sub(data$created_at, 12,19)
data$date <- str_c(data$day,data$year)  %>% mdy

trump_tweet <- data[,c("id_str","text","date")]


write.csv(trump_tweet, "Trump_tweets.csv")


