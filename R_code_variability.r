setwd("C:/lab")
library(raster)
library(RStoolbox)
library(gridExtra)
library(ggplot2)
sent<-brick("sentinel.png")
#nir=1, red=2, green=3
plotrRGB(sent, stretch="lin")
plotRGB(sent,2,1,3, stretch="lin")
nir<-sent$sentinel.1
red<-sent$sentinel.2
ndvi<-(nir-red/(nir+red)
cl <- colorRampPalette(c('black','white','red','magenta','green'))(100)
plot(ndvi, col=cl)
#funzione focal per calcolare le statistiche
ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(ndvisd3)
clsd<-colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvisd3, col=clsd)
#calcolo media
ndvimean3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvimean3, col=clsd)
#cambio finestra pixel, da 9 a 169
ndvisd13 <- focal(ndvi, w=matrix(1/169, nrow=13, ncol=13), fun=sd)
plot(ndvisd13)
ndvisd5 <- focal(ndvi, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
 #dev standard calcolata nella finestra dalle dimensioni da me scelta
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvisd5, col=clsd)
#PCA
sentpca<-rasterPCA(sent)
plot(sentpca$map)
summary(sentpca$model)
#prima PC spiega il 67%della variabilità principale
pc1 <- sentpca$map$PC1
#associato l'oggetto componente pc1 di sentpca ad un oggetto più semplice, pc1
pc1sd3<-focal(pc1, w=matrix(1/9, nrow=3,ncol=3), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(pc1sd3, col=clsd)
source("source_test_lezione.r")
source("source_ggplot.r")
#codice scaricato da una finestra e che mi riporta direttamente il calcolo su R
install.packages("viridis")
library(viridis)
       # dev standard per individuare qualsiasi variabilità ecologica, oppure discontinuità geomorfologica
ggplot()
geom.raster(pc1sd3, mapping = aes(x = x, y = y, fill = layer))+scale_fill_viridis(option="magma")

ggplot() +
geom_raster(pc1sd3, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis()  +
ggtitle("Standard deviation of PC1 by viridis colour scale")
#funzione con scala colore e titolo
 p1<-ggplot() +
geom_raster(pc1sd3, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option="inferno")  +
ggtitle("Standard deviation of PC1 by viridis colour scale")
p2<-ggplot() +
geom_raster(pc1sd3, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option="cividis")  +
ggtitle("Standard deviation of PC1 by viridis colour scale")
grid.arrange(p1, p2, nrow = 1)
#plot delle diverse immagini insieme
       





