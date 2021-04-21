#classification
library(raster)
library(RStoolbox)
setwd("C:/lab/")
solar<-brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
#importo immagine su R
solar
plotRGB(solar,1,2,3,stretch="Lin")
#plottaggio dell'immagine come l'ho scaricata
#unsupervised classification, utente non determina la classificazione
solare<-unsuperClass(solar,nClasses=3)
plot(solare$map)
solare<-unsuperClass(solar,nClasses=20)
#plot con 20 classi
plot(solare$map)
sun<-brick("Solar_Orbiter_s_high-resolution_view_of_the_Sun.png")
sun1<-unsuperClass(sun,nClasses=10)
plot(sun1$map)
