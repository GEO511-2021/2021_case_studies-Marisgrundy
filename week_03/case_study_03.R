#install library(ggplot2), library(gapminder), library(dplr) to load packages
library(ggplot2)
library(gapminder)
library(dplyr)

str(gapminder)

#use filter() to remove "Kuwait" from the gapminder data
no_kuwait <- filter(gapminder, country!="Kuwait")

#Plot#1(first row of plots)
p1<- ggplot(no_kuwait, aes(x=lifeExp, y=gdpPercap, color=continent, size=pop/100000))+
  geom_point()+
  scale_y_continuous(trans= "sqrt")+
  facet_wrap(~year,nrow=1)+ 
  theme_bw()+
  labs(x="Life Expectancy", y= "GDP Per Capita", size=.5, color= "#228B22" )

p1
png("Case_Study 3.1")

#Prepare the data for the plot 2

gapminder_continent <- gapminder %>%
  group_by(continent, year) %>%
  summarize(gdpPercapweighted = weighted.mean(x = gdpPercap, w = pop), pop = sum(as.numeric(pop)))
  #summarize(gdpPercapweighted=weighted.mean(x=gdpPercap, y=pop, pop=sum(as.numeric(pop))))

#Plot #2 (the second row of plots)

p2<-ggplot(no_kuwait, aes(x=year, y=gdpPercap))+
  geom_line(aes(color=continent, group = country))+
  geom_point(aes(color=continent))+
  geom_line(gapminder_continent, mapping=aes(x=year, y=gdpPercapweighted))+
  geom_point(gapminder_continent, mapping=aes(x=year, y=gdpPercapweighted, size=pop))+
  scale_y_continuous(trans= "sqrt")+
  facet_wrap(~continent,nrow=1)+
  theme_bw()+
  labs(x= "Year", y = "GDP Per Capita")

p2
png("Case_Study 3.2")
  