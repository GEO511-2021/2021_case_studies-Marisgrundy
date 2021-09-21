library(tidyverse)

# define the link to the data - you can try this in your browser too.  Note that the URL ends in .txt.
dataurl="https://data.giss.nasa.gov/tmp/gistemp/STATIONS/tmp_USW00014733_14_0_1/station.txt"

temp=read_table(dataurl,
                skip=3, #skip the first line which has column names
                na="999.90", # tell R that 999.90 means missing in this dataset
                col_names = c("YEAR","JAN","FEB","MAR", # define column names 
                              "APR","MAY","JUN","JUL",  
                              "AUG","SEP","OCT","NOV",  
                              "DEC","DJF","MAM","JJA",  
                              "SON","metANN"))
view(temp)

library(ggplot2)

p1<-ggplot(temp) +
  aes(x = YEAR, y = JJA) +
  geom_line (size = .5, colour = "#440154") +
  labs(x = "Year", y = "Mean Summer Temperatures (C)", 
       title="Mean Summer Temperatures in Buffalo, NY") +
  theme(plot.title=element_text(hjust=.5), axis.title.y = element_text(size = 12L, 
                                                                       face = "bold"), axis.title.x = element_text(size = 12L, face = "bold"))+
  geom_smooth(color= "#0000FF", fill= "#add8e6")+ 
  theme_minimal()

#png("Mean Summer Temperatures.png",res = 300)
p1
#dev.off()

ggsave("Mean Summer Temps.png", width=12, height=6)