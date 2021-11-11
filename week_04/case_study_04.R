#GOAL: What is the full name (not the three letter code) of the 
#destination airport farthest from any of the NYC airports in the 
#flights table?



#load libraries
library(tidyverse)
library(nycflights13)

#view data
view(flights)
view(airports)



#filter low to high to find furthest destination
joined_flights_destination <- flights %>% 
  arrange(distance)

#looked at it
View(joined_flights_destination)

#slice takes just a part of the column
answer <- slice_max(joined_flights_destination, distance, n=1, with_ties=FALSE) %>%

#join the two columns, will return one connection (because of above)
left_join(y=airports, by=c("dest"="faa"))

answer
#print as single character value
farthest_airport<- select(answer, name)
farthest_airport
