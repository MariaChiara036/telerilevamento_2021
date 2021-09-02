#Visualizzazione copernicus
library(raster)
install.packages("ncdf4")
#installato nuovo pacchetto
setwd("C:/lab/")
vegetation<-raster()
vegetation<-raster("c_gls_FCOVER_199903030000_GLOBE_VGT_V1.4.1.nc")
#inserito immagine scaricata da copernicus
cl <- colorRampPalette(c('light blue','green','red','yellow'))(100)
#scelti i colori
plot(vegetation, col=cl)
#resampling
#ricampionamento dei pixel per rendere l'immagine più leggera così da velocizzare le operazioni su R
veget<-aggregate(vegetation, fact=100)
#cambio la visualizzazione dell'insieme di pixel, livelli di pixel
plot(veget, col=cl)


 
