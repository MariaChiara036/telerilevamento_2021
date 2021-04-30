library(raster)
setwd("C:/lab/")
defor1<-brick("defor1.jpg")
defor2<-brick("defor2.jpg")
#b1=NIR, b2=red, b3=green
par(mfrow=c(2,1))
plotRGB(defor1, r=1,g=2,b=3, stretch="Lin")
plotRGB(defor2, r=1,g=2,b=3, stretch="Lin")
#indagare sulla salute dell'ambiente, es:colore fiume in base a quanto materiale solido è presente e quanto infrarosso assorbe l'acqua
dvi1 <- defor1$defor1.1 - defor1$defor1.2
plot(dv1)
cl <- colorRampPalette(c('darkblue','pink','red','black'))(100) 
# decido la palette di colori
plot(dvi1, col=cl, main="DVI at time 1")
#tempo 2
dvi2<-defor2$defor2.1 - defor2$defor2.2
plot(dvi2)
plot(dvi2, col=cl, main="DVI at time 2")
par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")
#plot con due immagini per due righe e 1 colonna
difdvi<-dvi1-dvi2
#intersezione tra le due mappe
cld <- colorRampPalette(c('blue','white','red'))(100) 
#ndvi (NIR-RED)/(NIR+RED)
ndvi misurare risoluz i  riascolatare
ndvi1<-(defor1$defor1.1-defor1$defor1.2)/(defor1$defor1.1+defor1$defor1.2)
plot(ndvi1, col=cl)
#oppure
ndvi1<-dvi1/(defor1$defor1.1+defor1$defor1.2)
ndvi2<-dvi2/(defor2$defor2.1+defor2$defor2.2)
plot(ndvi2, col=cl)
#RStoolbox spectral indices
vi<-spectralIndices(defor1, green=3, red=2, nir=1)
#calcola gli indici che usano queste bande e li associa
plot(vi, col=cl)
difdiv<-dvi1-dvi2
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(difndvi, col=cld)





