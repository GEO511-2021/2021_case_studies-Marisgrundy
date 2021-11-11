library(raster)
library(sp)
library(spData)
library(tidyverse)
library(sf)

#download world monthly climate data
data(world) 

#remove antarctica, prepare polygon

world_new <- filter(world, continent != "Antarctica")
world_sp <- as(world_new, "Spatial")

#prepare climate data

tmax_monthly <- getData(name = "worldclim", var="tmax", res=10)

#plot(tmax_monthly)

#convert to degree C???
gain(tmax_monthly) <- .1

#annual maximum temperature in each pixel of the raster
tmax_annual <- max(tmax_monthly)
#changing name to tmax
names(tmax_annual)<- "tmax"

#calculate maximum temperature observed in each country 
#(extract from raster to polygon)
max_temp <-raster::extract(tmax_annual, world_sp, fun=max, na.rm=T, small=T, sp=T) %>%
  st_as_sf()

#plot!

ggplot(max_temp) +
  geom_sf(aes(fill=tmax))+
scale_fill_viridis_c(name="Annual\nMaximum\nTemperature (C)")+
theme(legend.position = 'bottom')

#find hottest country in each continent
hottest_country<- max_temp %>%
  group_by(continent) %>%
  top_n(1, tmax)%>%
  select(name_long, continent, tmax) %>%
  arrange(desc(tmax))%>%
  st_set_geometry(NULL)

view(hottest_country)
