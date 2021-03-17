setwd("C:/lab/") #windows
#install.packages("library")
library(raster)
p224r63 <- brick("p224r63_1988_masked.grd")
brick("p224r63_1988_masked.grd")
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



