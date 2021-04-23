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
#correlazione di vaariabili a due a due
