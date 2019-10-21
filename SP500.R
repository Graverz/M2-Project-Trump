library(tidyverse)
library(lubridate)
library(readr)
library(mice)

SP500 <- read_csv("https://github.com/Graverz/M2-Project-Trump/blob/master/SP500.csv", col_types = cols(SP500 = col_number()))
SP500$DATE <- as_date(SP500$DATE)
SP500$Year <- year(SP500$DATE)

#Data imputation
Imputation <- mice(SP500, m=5, maxit = 50, method = 'pmm', seed = 500)
SP500 <- complete(Imputation,1)

SP500$Procent <- (SP500$SP500-lag(SP500$SP500))/lag(SP500$SP500)*100
SP500 <- SP500 %>% filter(Year==2017 | Year==2018)  

hist(SP500$Procent)
