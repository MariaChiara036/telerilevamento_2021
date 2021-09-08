#Deforestazione del Parco Nazionale dell'Iguazù
#Viene eseguita un'analisi delle condizioni pre deforestazione partendo da un'immagine del 1973 catturata da Landsat 1 e confrontandosi successivamente con l'immagine
#del 2011 catturata da Landsat 5, dove il paesaggio è cambiato notevolemente

#CODICE......................................................................
#Il primo step su R è richiamare i pacchetti necessari per svolgere le analisi
#pacchetto attraverso cui è possibile eseguire le funzioni base di R come calcolare o analizzare dati, sia Raster che vettoriali.
library(raster)
#pacchetto RStoolbox permette analisi di monitoraggio come il calcolo degli indici spettrali, la classificazione non supervisionata
library(RStoolbox)
#pacchetto che permette di elaborare plot complessi e personalizzati come ggplot, utile nella manipolazione grafica
library(gridExtra)
#pacchetto rasterVis incrementa i metodi di visualizzazione delle immagini, ad esempio permette di elaborare levelplots
library(rasterVis)
#pacchetto ggplot è molto utile per fare plot personalizzati e complessi 
library(ggplot2)

#inserisco l'immagine su R come rasterBrick, ossia includendo tutti i vari layer dell'immagine(bande)
igu73<-brick("igu_1973.png")
#inserisco l'immagine su R come rasterBrick, ossia includendo tutti i vari layer dell'immagine(bande)
igu11<-brick("igu_2011.png")
#correzione extent
igu73<-crop(igu73,igu11)
#funzione par mi permette di plottare più immagini contemporaneamente scegliendo come disporle in base al numero di righe e di colonne da me scelto
par(mfrow=c(1,2))
#plot in RGB, ossia inserendo dei canali di colore rosso, verde e blu le bande delle mie immagini, in più la particolarità dello stretch mi discrimina meglio le differenze tra i pixel
plotRGB(igu73,2,3,1,stretch="lin")
plotRGB(igu11,1,2,3,stretch="lin")

#TIME SERIES...................................................................................
#Studio di time series è utile per confrontare due o più immagini nel corso degli anni

#creo una lista di files contente le due immagini così da applicare le funzioni in modo univoco direttamente sulla lista
#creo una lista contente le due immagini precedentemente caricate, R raccoglie dalla mia working directory tutti quei file che hanno come pattern comune "igu"
iguaz<-list.files(pattern="igu")
#applico alla mia lista la funzione raster tramite la funzione lapply
import<- lapply(iguaz, raster)
#correzione extent così le immagini hanno la stessa estensione
import[[1]]<- crop(import[[1]], extent(extent(import[[2]])))
#faccio uno stack di quello che ho ottenuto precedentemente
Ig<-stack(import)
#creo una palette di colori
cl <- colorRampPalette(c("darkgreen","green","yellow",
"white"))(100)
#funzione levelplot
levelplot(Ig,col.regions=cl main="Variazione della copertura forestale nel tempo", names.attr=c("1973","2011"))

#PCA/VARIABILITY...............................................................................
#Eseguo un'analisi delle componenti principali per vedere quale mi descrive meglio la variabilità
#Successivamente calcolo la deviazione standard della componente più rappresentativa in modo da visualizzare ancora di più dove si concentra la variabilità

#con la funzione rasterPCA eseguo un'analisi delle componenti principali dell'immagine del 1973
igu73PCA<-rasterPCA(igu73)
#carico il modello della PCA, estrapolato dalla PCA appena prodotta
summary(igu73PCA$model)
#Importance of components:
                           #Comp.1     Comp.2      Comp.3 Comp.4
#Standard deviation     72.6780720 35.6010851 14.32043804      0
#Proportion of Variance  0.7819991  0.1876402  0.03036072      0 prima componente 78%, seconda 19%,terza 3%, quarta 0.
#Cumulative Proportion   0.7819991  0.9696393  1.00000000      1
#plot delle 4 componenti principali dell'immagine del 1973
plot(igu73PCA$map)
#semplifico dando alla prima componente un nome più veloce
pc1<-igu73PCA$map$PC1
#calcolo deviazione standard della prima componente, che in questo caso è quella che meglio descrive la variabilità dell'immagine.
#La deviazione standard indaga ulterioremente la variabilità, in questo caso la variabilità della PC1
#funzione focal permette di fare svariate statistiche, in questo caso viene calcolata la dev. standard. Il calcolo è effettuato su una matrice di 9 pixel totali
pc1sd<-focal(pc1, w=matrix(1/9, nrow=3,ncol=3), fun=sd)
#creo una palette di colori per il plot successivo
clsd <- colorRampPalette(c('blue','green','pink','magenta',
'orange','brown','red','yellow'))(100)
#plot della deviazione standard della PC1
plot(pc1sd,col=clsd)
#ggplot della dev.standard della PC1 usando la scala di colori viridis
ggplot()+ geom_raster(pc1sd, mapping = aes(x = x, y = y,
fill = layer))+scale_fill_viridis(option="magma")
#rasterPCA della seconda immagine
igu11PCA<-rasterPCA(igu11)
#modello di PCA 
summary(igu11PCA$model)
#Importance of components:
                           #Comp.1     Comp.2     Comp.3 Comp.4
#Standard deviation     86.0786339 62.6616126 13.4483248      0
#Proportion of Variance  0.6433635  0.3409328  0.0157037      0 prima componente 64%, seconda 34%, terza 2%, 0.
#Cumulative Proportion   0.6433635  0.9842963  1.0000000      1
#plot delle quattro componenti dell'immagine
plot(igu11PCA$map)
#semplifico dando un nome più veloce alla prima componente
pc1.<-igu11PCA$map$PC1
#calcolo deviazione standard della prima componente che in questo caso è la componente che più descrive la variabilità dell'immagine
#la deviazione standard in questo caso esalterà le differenze, anche in questo caso la matrice di pixel è di 9
pc1.sd<-focal(pc1., w=matrix(1/9, nrow=3,ncol=3), fun=sd)
#plot della deviazione standar della prima componente con la palette utilizzata per la deviazione standard del 1973
plot(pc1.sd,col=clsd)
#ggplot della dev.standard della PC1 con scala di colori viridis
ggplot()+ geom_raster(pc1.sd, mapping = aes(x = x, y = y, 
fill = layer))+scale_fill_viridis(option="magma")

#NDVI................................................................................
#L'indice NDVI è un indice molto utile per valutare la condizione della vegetazione. É molto utile in questo caso per sottolineare il suo mutamento in condizioni di deforestazione

#immagine 1973
#tramite la funzione spectralIndices R mi calcola tutti gli indici possibili ottenibili dalle bande che io inserisco per la mia immagine
vi<-spectralIndices(igu73,green=1,nir=2,red=3)
#plot di tutti gli indici
plot(vi)
#eseguo il plot in particolare solo dell'NDVI, estrapolandolo dall'argomento "vi"
plot(vi$NDVI,main="NDVI 1973")
#immagine 2011
#ripeto l'operazione eseguendo la funzione spectralIndices anche sull'immagine del 2011
vi2<-spectralIndices(igu11,swir2=1,nir=2,red=3)
#plot di tutti gli indici possibili
plot(vi2)
#eseguo il plot in particolare solo dell'NDVI, estrapolandolo dall'argomento "vi2"
plot(vi2$NDVI,main="NDVI 2011")

#LAND COVER..............................................................................
#Lo studio di copertura del suolo è utile per vedere com'è utilizzato il suolo e visualizzare le sue componenti.
#Su R si può comodamente utilizzare la classificazione non supervisionata per raggruppare pixel con valori simili di modo poi da assegnare delle categorie

#studio la copertura del suolo tramite la classificazione non supervisionata che mi classifica i pixel dell'immagine raggruppano insieme quelli che sono più simili tra loro.
Il fatto che sia non supervisionata significa che il training set è scelto in modo random da R
#scelto quante classi usare per la classificazione utilizzando la funzione "unsuperClass"
iguunsup1<-unsuperClass(igu73,nClasses=3)
#plotto la mia immagine classificata aggiungendo un titolo
plot(iguunsup1$map,main="1973")
# calcolo le frequenza, ossia la percentuale dei pixel per ogni classe
req(iguunsup1$map)
     value  count
#[1,]     1 576140
#[2,]     2 162311
#[3,]     3  39549
s1<-576140+162311+39549
prop1<-freq(iguunsup1$map)/s1
prop1
            value      count
#[1,] 1.285347e-06 0.74053985 #74 foresta bianco classe 1 in bianco nel grafico, rappresenta la porzione di suolo che è coperto da foresta
#[2,] 2.570694e-06 0.20862596 #21 coltivi giallo classe 2 in giallo nel grafico, rappresenta la porzione di suolo che è coperto da coltivi
#[3,] 3.856041e-06 0.05083419 #5 acqua verde classe 3 in verde nel grafico, rappresenta la porzione di suolo che è coperto da acqua
#calcolo 3 classi tramite la funzione "unsuperClass"
iguunsup2<-unsuperClass(igu11,nClasses=3)
plot(iguunsup2$map,main="2011")
#calcolo le frequenze per le classi nell'immagine 2011
freq(iguunsup2$map)
 value  count
#[1,]     1 273745
#[2,]     2 444362
#[3,]     3  59893
s2<-273745+444362+59893
prop2<-freq(iguunsup2$map)/s2
prop2
            value      count
#[1,] 1.285347e-06 0.351857330 #35 coltivi bianco classe 1 in bianco nel grafico, rappresenta la porzione di suolo che è coperto da coltivi
#[2,] 2.570694e-06 0.57115938 #57 foresta gialla classe 2 in giallo nel grafico, rappresenta la porzione di suolo che è coperto da foresta
#[3,] 3.856041e-06 0.07698329 #8 acqua verde classe 3 in verde nel grafico, rappresenta la porzione di suolo che è coperto da acqua
 
#dataframe
# nomino le classi di copertura
cover<-c("Forest", "Agriculture","Water")
#fisso i valori di percentuali di ogni classe e attribuisco un nome
percentages_73<-c(0.74,0.20,0.05)
percentages_11<-c(0.57,0.35,0.07)
#creo un dataframe, ossia una tabella dove i valori corrispondono alle 3 classi di copertura
percentages<-data.frame(cover, percentages_73,percentages_11)
percentages
        #cover percentages_73 percentages_11
#1      Forest           0.74           0.35
#2 Agriculture           0.20           0.57
#3       Water           0.05           0.07

#restituisco graficamente il dataframe tramite ggplot, creando un grafico a barre
#scelgo cosa posizionare sull'asse x ed y con il paramentro "aes" e il tipo di grafico con "geom_bar", infine tramite "ylim" decido la scala da utilizzare
ggplot(percentages,aes(x=cover,y=percentages_73,color=cover))+geom_bar(stat="identity", fill="white")+ylim(0,0.8)
ggplot(percentages,aes(x=cover,y=percentages_11,color=cover))+geom_bar(stat="identity", fill="white")+ylim(0,0.8)
#attribuisco un nome più semplice ai due grafici appena creati
p1<-ggplot(percentages,aes(x=cover,y=percentages_73,color=cover))+geom_bar(stat="identity", fill="white")+ ylim(0,0.8)
p2<-ggplot(percentages,aes(x=cover,y=percentages_11,color=cover))+geom_bar(stat="identity", fill="white")+ylim(0,0.8)
#tramite la funzione "grid.arrange" creo un grafico unendo i grafici a barre
grid.arrange(p1, p2, nrow=1)
