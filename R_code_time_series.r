#Time series analysis
#Greenland increase of temperature
#Data and code from Emanuela Cosma
library(raster)
setwd("C:/lab/greenland")
#lst land surface temperature
lst_2000<-raster("lst_2000.tif")
#importato il primo dataset dalla libreria raster
plot(lst_2000)
#plottato questo oggetto
lst_2005<-raster("lst_2005.tif")
plot(lst_2005)
lst_2010<-raster("lst_2010.tif")
lst_2015<-raster("lst_2015.tif")
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)
#list of files
list.files()
#lista del contenuto di greenland contenente argomento comune lst
rlist<-list.files(pattern="lst")
rlist
#lista degli oggetti di greenland 
import<- lapply(rlist, raster)
#importo con funzione l apply la lista rlist su raster, lapplymi fa applicare funzione raster a tutta la lista rlist
TGr<-stack(import)
#posso fare plot di tutto subito
plot(TGr)
plotRGB(TGr,1,2,3, stretch="Lin")
#plot di un'imagine dove si sovrappongono tre immagini(2000,2005,2010)
#se ho più valori ad esempio di blu ho valori più alti dell'immagine 2010
plotRGB(TGr,2,3,4, stretch="Lin")
#plot con 2005,2010,2015 nel rosso la 2005 nel verde 2010 e nel blu 2015



