data("iris")
library(ggplot2)
petal_length_mean <- mean(iris$Petal.Length)

Plot1<-ggplot(data=iris, aes(Petal.Length))+ 
  geom_histogram(breaks=seq(0, 8, by=.5),
                 col= ("red"),
                 aes(fill=..count..)) +
  scale_fill_gradient("Count", low="red", high="green")+
  labs(title="Iris Petal Length", x="mean length", y="count")
print(Plot1)

png("First_Script.png")
print(Plot1)
dev.off()

