Case Study 06:Find Hottest Country in Each Continent
================
Maris Grundy
October 12, 2021

## Load Packages

``` r
library(raster)
library(sp)
library(spData)
library(tidyverse)
library(sf)
```

## Prepare Data

**Prepare climate data**

``` r
#download world monthly climate data
data(world) 

#remove antarctica, prepare polygon
world_new <- filter(world, continent != "Antarctica")
world_sp <- as(world_new, "Spatial")

#prepare climate data
tmax_monthly <- getData(name = "worldclim", var="tmax", res=10)

#plot(tmax_monthly)

#convert to correct degree C
gain(tmax_monthly) <- .1


#annual maximum temperature in each pixel of the raster
tmax_annual <- max(tmax_monthly)
#changing name to tmax
names(tmax_annual)<- "tmax"
```

**Prepare raster data**

``` r
#calculate maximum temperature observed in each country 
#(extract from raster to polygon)
max_temp <-raster::extract(tmax_annual, world_sp, fun=max, na.rm=T, small=T, sp=T) %>%
  st_as_sf()
```

## Plot!

``` r
#plot!
ggplot(max_temp) +
  geom_sf(aes(fill=tmax))+
scale_fill_viridis_c(name="Annual\nMaximum\nTemperature (C)")+
theme(legend.position = 'bottom')
```

<img src="case_study_06_files/figure-gfm/unnamed-chunk-4-1.png" style="display: block; margin: auto;" />

## Find Hottest Country in Each Continent

``` r
#find hottest country in each continent
hottest_country<- max_temp %>%
  group_by(continent) %>%
  top_n(1, tmax)%>%
  select(name_long, continent, tmax) %>%
  arrange(desc(tmax))%>%
  st_set_geometry(NULL)

hottest_country
```

    ## # A tibble: 7 x 3
    ## # Groups:   continent [7]
    ##   name_long                           continent                tmax
    ## * <chr>                               <chr>                   <dbl>
    ## 1 Algeria                             Africa                   48.9
    ## 2 Iran                                Asia                     46.7
    ## 3 United States                       North America            44.8
    ## 4 Australia                           Oceania                  41.8
    ## 5 Argentina                           South America            36.5
    ## 6 Spain                               Europe                   36.1
    ## 7 French Southern and Antarctic Lands Seven seas (open ocean)  11.8
