library(spData)
library(sf)
library(tidyverse)
library(units)

#load 'world' data from spData package
data(world)  

# load 'states' boundaries from spData package
data(us_states)

#plot if desired
plot(world[1])  
#plot if desired
plot(us_states[1]) 

#filter just canada
canada_buffer<- world %>%
  filter(name_long=="Canada") %>%
  st_transform(crs ="+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs") %>%
  #st_centroid()%>%
  st_buffer(dist = 10000)

new_york <- us_states %>%
  filter(NAME=="New York") %>%
  st_transform(crs = "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs") 
  
intersection<- st_intersection(canada_buffer, new_york)  

  ggplot() +
    geom_sf(data = new_york)+
    geom_sf(data = intersection, fill = "red")
  
  st_area(intersection)%>%
set_units(km^2)  
