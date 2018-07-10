# Tutorial for K-means clustering at the UKC 2018 Data Science Workshop
# Initially prepared by SY Park
# July 10, 2018

help(kmeans)

wine <- read.table("/Users/ndorphin1219/Desktop/wine.csv", header = TRUE, sep = ",")
head(wine)

set.seed(278613)          # set seed to generate reproducible results
wineK3 <- kmeans(x = wine, centers = 3)
wineK3

install.packages("useful")          # install useful package
require(useful)          # laod useful package
plot(wineK3, data = wine)
plot(wineK3, data = wine, class = "Cultivar")

set.seed(278613)
wineK3N25 <- kmeans(x = wine, centers = 3, nstart = 25)
wineK3$size          # see the cluster sizes with 1 start
wineK3N25$size          # see the cluster sizes with 25 starts

wineBest <- FitKMeans(wine, max.clusters=20, nstart=25, seed=278613)
wineBest
PlotHartigan(wineBest)

table(wine$Cultivar, wineK3N25$cluster)
plot(table(wine$Cultivar, wineK3N25$cluster),
  main="Confusion Matrix for Wine Clustering",
  xlab="Cultivar", ylab="Cluster")

require(cluster)
theGap <- clusGap(wine, FUNcluster = pam, K.max = 20)
gapDF <- as.data.frame(theGap$Tab) 
gapDF

# logW curves
require(ggplot2)
ggplot(gapDF, aes(x=1:nrow(gapDF))) +
       geom_line(aes(y=logW), color="blue") +
       geom_point(aes(y=logW), color="blue") +
       geom_line(aes(y=E.logW), color="green") +
       geom_point(aes(y=E.logW), color="green") +
       labs(x="Number of Clusters")

# gap curve
ggplot(gapDF, aes(x=1:nrow(gapDF))) +
       geom_line(aes(y=gap), color="red") +
       geom_point(aes(y=gap), color="red") +
       geom_errorbar(aes(ymin=gap-SE.sim, ymax=gap+SE.sim), color="red") +
       labs(x="Number of Clusters", y="Gap") 
