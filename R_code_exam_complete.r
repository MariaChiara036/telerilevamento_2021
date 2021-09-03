#Deforestazione del Parco Nazionale dell'Iguazù
#Viene eseguita un'analisi delle condizioni pre deforestazione partendo da un'immagine del 1973 catturata da Landsat 1 e confrontandosi successivamente con l'immagine
#del 2011 catturata da Landsat 5, dove il paesaggio è cambiato notevolemente

#CODICE......................................................................
#Il primo step su R è richiamare i pacchetti necessari per svolgere le analisi
#pacchetto attraverso cui è possibile eseguire le funzioni base di R come calcolare o analizzare dati, sia Raster che vettoriali.
library(raster)
#pacchetto RStoolbox permette di eseguire plot come levelplot e indagare la variabilità dei dati
library(RStoolbox)
#pacchetto gridExtra
library(gridExtra)
#pacchetto rasterVis permette
library(rasterVis)
#pacchetto ggplot è molto utile per fare plot personalizzati e complessi 
library(ggplot2)

#inserisco l'immagine su R come rasterLayer
igu73<-raster("igu_1973.png")
#inserisco l'immagine su R come rasterLayer
igu11<-raster("igu_2011.png")
#creo una lista contente le due immagini precedentemente caricate, R raccoglie dalla mia working directory tutti quei file che hanno come pattern comune "igu"
iguaz<-list.files(pattern="igu")
#applico alla mia lista la funzione raster
import<- lapply(iguaz, raster)
#correggo l'extent delle immagini per far sì che sia uguale per tutte e due
import[[1]]<- crop(import[[1]], extent(extent(import[[2]])))
#faccio uno stack di quello che ho ottenuto precedentemente
TGr<-stack(import)
#uso la funzione levelplot
levelplot(TGr, main="Deforestation in Iguazù National Park", names.attr=c("1973","2011"))
#eseguo la differenza tra le due immagini estrapolandole dal TGr tramite l'operatore "$"
diff<-TGr$igu_2011-TGr$igu_1973
diff
#eseguo un levelplot della differenza ottenuta, confrontando così le differenze tra le due immagini
levelplot(diff)

#spectralIndices..................................................

#immagine 1973
#tramite la funzione spectralIndices R mi calcola tutti gli indici possibili ottenibili dalle bande che io inserisco per la mia immagine
vi<-spectralIndices(igu73,green=1,nir=2,red=3)
plot(vi)
#plotto di tutti i miei indici in particolare l'NDVI
plot(vi$NDVI)
#immagine 2011
vi2<-spectralIndices(igu11,swir2=1,nir=2,red=3)
plot(vi2)
plot(vi2$NDVI)
#eseguo la differenza tra l'NDVI dell'anno 1973 e l'NDVI dell'anno 2011
diffndvi<-vi$NDVI-vi2$NDVI
plot(diffndvi)

#land cover..................................................................

#studio la copertura del suolo tramite la classificazione non supervisionata che mi classifica i pixel dell'immagine raggruppano insieme quelli che sono più simili tra loro.
Il fatto che sia non supervisionata significa che il training set è scelto in modo random da R
#scelto quante classi usare per la classificazione utilizzando la funzione "unsuperClass"
iguunsup1<-unsuperClass(igu73,nClasses=3)
#plotto la mia immagine classificata aggiungendo un titolo
plot(iguunsup1$map,main="1973")
# calcolo le frequenza, ossia la percentuale dei pixel per ogni classe
freq(iguunsup1$map)
       value  count
[1,]     1 576140
[2,]     2 162311
[3,]     3  39549
#calcolo la somma dei pixel
s1<-576140+162311+39549
#calcolo le proporzioni dei miei pixel in modo da ottenere le percentuali. Le ottenge dividendo le frequenze ottenute per il totale dei pixel
prop1<-freq(iguunsup1$map)/s1
prop1
      value      count
[1,] 1.285347e-06 0.74053985 #74 % classe 1 in bianco nel grafico, rappresenta la porzione di suolo che è coperto da foresta
[2,] 2.570694e-06 0.20862596 #21% classe 2 in giallo nel grafico, rappresenta la porzione di suolo che è coperto da coltivi
[3,] 3.856041e-06 0.05083419 #5% classe 3 in verde nel grafico, rappresenta la porzione di suolo che è coperto da acqua
#ripeto l'operazione per l'immagine del 2011
iguunsup2<-unsuperClass(igu11,nClasses=3)
plot(iguunsup2$map,main="2011")
freq(iguunsup2$map)
      value  count
[1,]     1 273745
[2,]     2 444362
[3,]     3  59893
#somma dei pixel
s2<-273745+444362+59893
#proporzioni per arrivare al valore percentuale di ogni classe 
prop2<-freq(iguunsup2$map)/s2
prop2
    value      count
[1,] 1.285347e-06 0.351857330 #35 classe 1 in bianco nel grafico, rappresenta la porzione di suolo che è coperto da coltivi
[2,] 2.570694e-06 0.57115938 #57 classe 2 in giallo nel grafico, rappresenta la porzione di suolo che è coperto da foresta
[3,] 3.856041e-06 0.07698329 #8 classe 3 in verde nel grafico, rappresenta la porzione di suolo che è coperto da acqua

#frequenze
# nomino le classi di copertura
cover<-c("Forest", "Agriculture","Water")
#fisso i valori di percentuali di ogni classe e attribuisco un nome
percentages_73<-c(0.72,0.21,0.06)
percentages_11<-c(0.56,0.35,0.07)
#creo un dataframe, ossia una tabella dove i valori corrispondono alle 3 classi di copertura
percentages<-data.frame(cover, percentages_73,percentages_11)
percentages
        cover percentages_73 percentages_11
1      Forest           0.72           0.56
2 Agriculture           0.21           0.35
3       Water           0.06           0.07

#restituisco graficamente il dataframe tramite ggplot, creando un istogramma
ggplot(percentages,aes(x=cover,y=percentages_73,color=cover))+geom_bar(stat="identity", fill="white")
ggplot(percentages,aes(x=cover,y=percentages_11,color=cover))+geom_bar(stat="identity", fill="white")
#attribuisco un nome più semplice ai due istogrammi appena creati
p1<-ggplot(percentages,aes(x=cover,y=percentages_73,color=cover))+geom_bar(stat="identity", fill="white")
p2<-ggplot(percentages,aes(x=cover,y=percentages_11,color=cover))+geom_bar(stat="identity", fill="white")
#tramite la funzione grid.arrange creo un grafico unendo i due istogrammi
grid.arrange(p1, p2, nrow=1) 
