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
#unsupervised classification
d1c<-unsuperClass(defor1, nClasses=2)
plot(d1c$map)
#classe1=foresta, classe2=zone agricole
#set.seed() svolge la medesima funzione
d1c<-unsuperClass(defor2, nClasses=2)
plot(defor2$map)
#Classe1=zone agricole, classe 2=foresta
d2c3<.unsuperClasse(defor2, nClasses=3)
plot(d2c3$map)
#frequenze
freq(d1c$map)
    value  count
[1,]     1 304962
[2,]     2  36330
s1<-304962+36330
s1
#somma dei pixel, quello totale è il totale dei pixel dell'immagine
[1] 341292
#frequenze sul totale
prop1<-freq(d1c$map)/s1
prop1
            value     count
[1,] 2.930042e-06 0.8935516 # 89%foresta
[2,] 5.860085e-06 0.1064484 # 11%agricolo

freq(d2c$map)
     value  count
[1,]     1 164523
[2,]     2 178203
s2<-164523+178203
s2
[1] 342726
prop2<-freq(d2c$map)/s2
prop2
            value     count
[1,] 2.917783e-06 0.4800424 #48%foresta
[2,] 5.835565e-06 0.5199576 #52%agricolo

#dataframe
#fattori, variabili categoriche
cover<-c("Forest", "Agriculture")
percent_1992<-c(89.35,10.64)
percent_2006<-c(48.00,51.99)
percentages<-data.frame(cover, percent_1992, percent_2006)
percentages
        cover percent_1992 percent_2006
1      Forest        89.35        48.00
2 Agriculture        10.64        51.99
library(ggplot2)
ggplot(percentages,aes(x=cover,y=percent_1992,color=cover))+geom_bar(stat="identity", fill="white")
ggplot(percentages,aes(x=cover,y=percent_2006,color=cover))+geom_bar(stat="identity", fill="white")
#asse x cover, y quale immagine scegliere, come strutturare grafico,scegliere tipo di grafico e riempimento
p1<- ggplot(percentages,aes(x=cover,y=percent_1992,color=cover))+geom_bar(stat="identity", fill="white")
p2<- ggplot(percentages,aes(x=cover,y=percent_2006,color=cover))+geom_bar(stat="identity", fill="white")
grid.arrange(p1, p2, nrow=1) 



