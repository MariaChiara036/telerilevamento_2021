setwd("C:/lab/")
library(raster)
library(RStoolbox)
install.packages("ggplot2")
library(ggplot2)
defor1<-brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
#immagine su piano cartesiano
defor2<-brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
par(mforw=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
#per parmfow con ggplot serve un'altra funzione
#multiframe con ggplot
install.packages("gridExtra")
library(girdExtra)
p1<-ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2<-ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow=2)
#immagini messe come se avessimo usato parmfrow

