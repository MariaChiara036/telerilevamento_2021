#multivariate analysis
library(raster)
library(Rstoolbox)
setwd("C:/lab/")
p224<-brick("p224r63_2011_masked.grd")
#inserito immagine
plot(p224)
#immagine con le sue 7 bande
plot(p224$B1_sre,p224$B2_sre,col="blue",pch=19,cex=2)
# considero solo due banda con alcuni parametri settati
pairs(p224)
#correlazione di vaariabili a due a due, valori restituiti dal plot rappresentano l'indice di Pearson
#analisi PCA impattante, ricampionare dato per rendere il lavoro più scorrevole
#aumentare la dimensione di ogni pixel dell'immagine, diminuendo la risoluzione
p224res<-aggregate(p224, fact=10)
par(mfrow=c(2,1))
plotRGB(p224, r=4,g=3,b=2, stretch="Lin")
plotRGB(p224res, r=4,g=3,b=2, stretch="Lin")
#confronto risoluzione tra le due immagini
p224res_pca<-rasterPCA(p224res)
#funzione PCA
summary(p224res$model)
#sommario generico p224res
plot(p224res_pca$map)
plotRGB(p224res_pca$map, r=1, g=2, b=3, stretch="Lin")
#utilizzate 3 componenti principali

