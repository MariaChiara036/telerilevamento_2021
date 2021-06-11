#R code complete-Telerilevamento
#Summary
#1.Remote sensing
#2.Time series
#3.Copernicus
#4.Knitr
#5.Multivariate analysis
#6.Classification
#7.Land cover
#8.Vegetation indices
#9.Variability

#...........................
#Remote sensing

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
plotRGB(p224r63, r=3, g=2, b=1, stretch="Lin")
#visualizzazione colori naturali, fuzione stretch per "distendere" le bande
plotRGB(p224r63,4,3,2, stretch="Lin")
#plot cambiando le bande, montate le bande infrarosso vicino, la verde e la rossa
#l'ordine è importante perchè ogni numero individua le bande red green blue
plotRGB(p224r63,3,4,2, stretch="Lin")= plotRGB(p224r63, r=3, g=4, b=2, stretch="Lin")
par(mfrow=c(2,2))
#multiframe 2x2
plotRGB(p224r63,3,2,4, stretch="Lin")
plotRGB(p224r63,3,4,2, stretch="Lin")
plotRGB(p224r63,4,3,2, stretch="Lin")
plotRGB(p224r63, r=3, g=2, b=1, stretch="Lin")
 pdf("pdf_giusto")
#salvo un pdf del mio grafico su R e viene salvato direttamente nella cartella lab che è la mia working directory
par(mfrow=c(2,2))
plotRGB(p224r63, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63,4,3,2, stretch="Lin")
plotRGB(p224r63,3,4,2, stretch="Lin")
plotRGB(p224r63,3,2,4, stretch="Lin")
dev.off()
#elimino la precedente finestra grafica e ripulisco per creare nuovi plot da zero
par(mfrow=c(3,1))
plotRGB(p224r63, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63,3,4,2, stretch="Lin")
plotRGB(p224r63,3,4,2, stretch="hist")
#funzione hist mi riporta colori falsati
install.packages("RStoolbox")
library(RStoolbox)
#installata la libreria RStoolbox
#richiamo la libreria raster e carico immagine p224r63_1988
library(raster)
setwd("C:/lab/")
p224r63_1988<-brick("p224r63_1988_masked.grd")
plot(p224r63_1988)
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
#plottato questa immagine dando queste bande da visualizzare
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
#qui vedo anche una banda dell'infrarosso(b4)
p224r63_2011<-brick("p224r63_2011_masked.grd")
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
#multiframe per le due immagini di Landsat
par(mfrow=c(2,2))
pdf("multitemp.pdf")
plotRGB(p224r63_1988,r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011,r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988,r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011,r=4, g=3, b=2, stretch="hist")
dev.off()
#salvato il pdf e ripulito finestra grafica

#...................................
#Time series

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
library(rasterVis)
levelplot(TGr)
#funz levelplot dentro la libreria rasterVis
levelplot(TGr$lst_2000)
#plot lst_2000
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
#cambio palette colori
levelplot(TGr, col.regions=cl)
#plot immagine con la palette prescelta
levelplot(TGr,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))
levelplot(TGr,col.regions=cl, main="LST variation in time", names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))
#immagine con scala di variazione sulle lst
meltlist<-list.files(pattern="melt")
#creo una lista coi dati melt
import<-lapply(meltlist, raster)
#applico funzione raster alla lista meltlist
melt<-stack(import)
#funzione stack a melt
levelplot(melt)
melt_amount<-melt$X2007annual_melt-melt$X1979annual_melt
#differenza immagine 2007 e 1979
clb <- colorRampPalette(c("blue","white","red"))(100)
plot(melt_amount, col=clb)
#plot dell'immagine che rappresenta la differenza dei ghiacci in ghiaccio sciolto tra i due anni, colore risultante è quanto ghiaccio si è sciolto tra i due estremi in anni
levelplot(melt_amount, col=clb)
#levelplot
install.packages("knitr")
#...............................
#Copernicus

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
veget<-aggregate(vegetation, fact=100)
#cambio la visualizzazione dell'insieme di pixel, livelli di pixel
plot(veget, col=cl)
#...........................................
#Knitr

#knitr
setwd("C:/lab/")
library(knitr)
stitch("R_Code_greenland.r.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
#caricato codice di time series tramite report tramite funzione knitr
#..........................................................................
#Multivaraiate analysis

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
#...............................................................
#Classification

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
gc<-brick("dolansprings_oli_2013088_canyon_lrg.jpg")
#caricamento immagine satellitare Gran Canyon
plotRGB(gc, r=1, g=2, b=3, stretch="Lin")
plotRGB(gc, r=1, g=2, b=3, stretch="hist")
gcc2<-unsuperClass(gc, nClasses=2)
plot(gcc2$map)
#plot mappa classi 2
gcc4<-unsuperClass(gc, ncClasses=4)
plot(gcc4$map)
#....................................................................
#Land cover

setwd("C:/lab/")
library(raster)
library(RStoolbox)
install.packages("ggplot2")
library(ggplot2)
defor1<-brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
#immagine su piano cartesiano
defor2<-brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
par(mforw=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
#per parmfow con ggplot serve un'altra funzione
#multiframe con ggplot
install.packages("gridExtra")
library(girdExtra)
p1<-ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2<-ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow=2)
#immagini messe come se avessimo usato parmfrow
#unsupervised classification
d1c<-unsuperClass(defor1, nClasses=2)
plot(d1c$map)
#classe1=foresta, classe2=zone agricole
#set.seed() svolge la medesima funzione
d1c<-unsuperClass(defor2, nClasses=2)
plot(defor2$map)
#Classe1=zone agricole, classe 2=foresta
d2c3<.unsuperClasse(defor2, nClasses=3)
plot(d2c3$map)
#frequenze
freq(d1c$map)
    value  count
[1,]     1 304962
[2,]     2  36330
s1<-304962+36330
s1
#somma dei pixel, quello totale è il totale dei pixel dell'immagine
[1] 341292
#frequenze sul totale
prop1<-freq(d1c$map)/s1
prop1
            value     count
[1,] 2.930042e-06 0.8935516 # 89%foresta
[2,] 5.860085e-06 0.1064484 # 11%agricolo

freq(d2c$map)
     value  count
[1,]     1 164523
[2,]     2 178203
s2<-164523+178203
s2
[1] 342726
prop2<-freq(d2c$map)/s2
prop2
            value     count
[1,] 2.917783e-06 0.4800424 #48%foresta
[2,] 5.835565e-06 0.5199576 #52%agricolo

#dataframe
#fattori, variabili categoriche
cover<-c("Forest", "Agriculture")
percent_1992<-c(89.35,10.64)
percent_2006<-c(48.00,51.99)
percentages<-data.frame(cover, percent_1992, percent_2006)
percentages
        cover percent_1992 percent_2006
1      Forest        89.35        48.00
2 Agriculture        10.64        51.99
library(ggplot2)
ggplot(percentages,aes(x=cover,y=percent_1992,color=cover))+geom_bar(stat="identity", fill="white")
ggplot(percentages,aes(x=cover,y=percent_2006,color=cover))+geom_bar(stat="identity", fill="white")
#asse x cover, y quale immagine scegliere, come strutturare grafico,scegliere tipo di grafico e riempimento
p1<- ggplot(percentages,aes(x=cover,y=percent_1992,color=cover))+geom_bar(stat="identity", fill="white")
p2<- ggplot(percentages,aes(x=cover,y=percent_2006,color=cover))+geom_bar(stat="identity", fill="white")
grid.arrange(p1, p2, nrow=1)
#.......................................................................
#Vegetation indices

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
#pacchetto rasterdiv
install.packages("rasterdiv")
library(rasterdiv)
plot(copNDVI)
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
plot(copNDVI)
library(rasterVis)
levelplot(copNDVI)
#livelli alti in punti dove abbondano foreste, valori bassi su deserti
#aria carica di vapore fa tornare acqua sulle chiome, aria scaricata da vapore acqueo è secca e si riversa verso terra in un'altra zona
#...................................................................................................
#Variability

setwd("C:/lab")
library(raster)
library(RStoolbox)
library(gridExtra)
library(ggplot2)
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
 #dev standard calcolata nella finestra dalle dimensioni da me scelta
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvisd5, col=clsd)
#PCA
sentpca<-rasterPCA(sent)
plot(sentpca$map)
summary(sentpca$model)
#prima PC spiega il 67%della variabilità principale
pc1 <- sentpca$map$PC1
#associato l'oggetto componente pc1 di sentpca ad un oggetto più semplice, pc1
pc1sd3<-focal(pc1, w=matrix(1/9, nrow=3,ncol=3), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(pc1sd3, col=clsd)
source("source_test_lezione.r")
source("source_ggplot.r")
#codice scaricato da una finestra e che mi riporta direttamente il calcolo su R
install.packages("viridis")
library(viridis)
       # dev standard per individuare qualsiasi variabilità ecologica, oppure discontinuità geomorfologica
ggplot()
geom.raster(pc1sd3, mapping = aes(x = x, y = y, fill = layer))+scale_fill_viridis(option="magma")

ggplot() +
geom_raster(pc1sd3, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis()  +
ggtitle("Standard deviation of PC1 by viridis colour scale")
#funzione con scala colore e titolo
 p1<-ggplot() +
geom_raster(pc1sd3, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option="inferno")  +
ggtitle("Standard deviation of PC1 by viridis colour scale")
p2<-ggplot() +
geom_raster(pc1sd3, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option="cividis")  +
ggtitle("Standard deviation of PC1 by viridis colour scale")
grid.arrange(p1, p2, nrow = 1)
#plot delle diverse immagini insieme
