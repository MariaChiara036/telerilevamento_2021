setwd("C:/lab/") #windows
#install.packages("library")
library(raster)
p224r63 <- brick("p224r63_1988_masked.grd")
brick("p224r63_1988_masked.grd")
#funz. brick importa l'immagine
class      : RasterBrick 
dimensions : 1499, 2967, 4447533, 7  (nrow, ncol, ncell, nlayers)
resolution : 30, 30  (x, y)
extent     : 579765, 668775, -522705, -477735  (xmin, xmax, ymin, ymax)
crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs 
source     : C:/lab/p224r63_1988_masked.grd 
names      :       B1_sre,       B2_sre,       B3_sre,       B4_sre,       B5_sre,        B6_bt,       B7_sre 
min values : 4.070954e-03, 8.173777e-03, 4.615846e-03, 1.300000e-02, 4.567942e-03, 2.947000e+02, 0.000000e+00 
max values :   0.08496003,   0.17020000,   0.21908860,   0.54999932,   0.45184137, 305.20000000,   0.49681378 
plot(p224r63)
#inserimento immagine satellitare
#colour change
cl<-colorRampPalette(c("black", "grey", "light grey"))(100)
plot(p224r63, col=cl)
#ricarico l'immagine con la palette da me scelta, la funzione plot possiede due argomenti: l'immagine e i colori che sono dettati dalla funzione precedente
#colour change -> new
cl<-colorRampPalette(c("black", "yellow", "blue", "aquamarine"))(100)
plot(p224r63, col=cl)
#day 3
#b1 banda blu;b2 banda verde;b3 banda rosso;b4 infrarosso vicino;b5 infrarosso medio;b6 infrarosso termico;b7 infrarosso medio; sre=spectral reflectance
#funzione dev.off() pulisce la finestra grafica
plot(p224r63$B1_sre)
#funzione per plottare solo la banda del blu
cls <- colorRampPalette(c("red","pink","orange","purple")) (200)
plot(p224r63$B1_sre, col=cls)
plot(p224r63$B2_sre)
#plottato la banda del verde
par(mfrow=c(1,2))
#tramite questa funzione posso visualizzare nel grafico due bande in particolare, possibile scegliere il tipo di visualizzazione in n.di righe e colonne
plot(p224r63$B1_sre)
plot(p224r63$B2_sre)
#cosi visualizzo i due plot su una riga e due colonne
par(fmrow=c(2,1))
#visualizzazione su due righe e una colonna
plot(p224r63$B1_sre)
plot(p224r63$B2_sre)
#visualizzazione grafico come da riga 40
par(mfrow=c(4,1))
plot(p224r63$B1_sre)
plot(p224r63$B2_sre)
plot(p224r63$B3_sre)
plot(p224r63$B4_sre)
par(mfrow=c(2,2))
#visualizzazione quadrata
 plot(p224r63$B4_sre)
 plot(p224r63$B3_sre)
 plot(p224r63$B2_sre)
 plot(p224r63$B1_sre)
clb <- colorRampPalette(c("dark blue","blue","light blue")) (100)
plot(p224r63$B1_sre, col=clb)
#cambio la palette solo per la banda del blu, specificando che l'argomento per il colore di questa banda è clb
clg <- colorRampPalette(c("dark green","green","light green")) (100)
plot(p224r63$B2_sre, col=clg)
#cambio la palette solo per il verde, argomento specifico clg
clr <- colorRampPalette(c("dark red","red","pink")) (100)
 plot(p224r63$B3_sre, col=clr)
#palette per il rosso, clr
clnir <- colorRampPalette(c("red","orange","yellow")) (100)
plot(p224r63$B4_sre, col=clnir)
#palette per il vicino infrarosso individuata con clnir
#col comando plot mi carica ogni volta ciò che io ho impostato



