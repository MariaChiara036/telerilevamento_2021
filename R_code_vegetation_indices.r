library(raster)
setwd("C:/lab/")
defor1<-brick("defor1.jpg")
defor2<-brick("defor2.jpg")
#b1=NIR, b2=red, b3=green
par(mfrow=c(2,1))
plotRGB(defor1, r=1,g=2,b=3, stretch="Lin")
plotRGB(defor2, r=1,g=2,b=3, stretch="Lin")
#indagare sulla salute dell'ambiente, es:colore fiume in base a quanto materiale solido è presente e quanto infrarosso assorbe l'acqua

