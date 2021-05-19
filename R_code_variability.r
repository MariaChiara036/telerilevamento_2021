setwd("C:/lab")
library(raster)
library(RStoolbox)
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
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvisd5, col=clsd)
#PCA
sentpca<-rasterPCA(sent)
plot(sentpca$map)
summary(sentpca$model)
#prima PC spiega il 67%della variabilità principale
