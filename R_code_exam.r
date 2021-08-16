#Deforestation in Spiny Thicket in Madagascar
#1.Time series
#2.Land cover
#3.NDVI
setwd("C:/lab/")
library(raster)
library(rasterVis)
library(gridExtra)
libarary(ggplot2)
#installo i pacchetti che mi permetteranno di utilizzare le varie funzioni
f1973<-raster("forest1973.png")
f1998<-raster("forest1998.png")
f2021<-raster("forest2021.png")
#importato le immagini satellitari necessarie su R
f1973<-brick("forest1973.png")
f1998<-brick("forest1998.png")
f2021<-brick("forest2021.png")


#1.TIME SERIES...................................................................................
#creo una lista contente le 3 immagini usato un pattern comune a tutte, che in questo caso è "forest"
forest<-list.files(pattern="forest")
forest
#[1] "forest1973.png" "forest1998.png" "forest2021.png"
#importo con funzione l apply la lista forst su raster, lapplymi fa applicare funzione raster a tutta la lista forest
import<-lapply(forest,raster)
#taglio le immagini 1998 e 2021 con l'estensione della 1973 per farle apparire tutte con la stessa extent
#PRIMO TENTATIVO DI RITAGLIO DI IMMAGINI
#f1998_2 <- crop(f1998, extent(f1973))
#f2021_2 <- crop(f2021, extent(f1973))
#definisco le sottosezioni di import in modo da avere le stesse extent su tutte e 3 e usare un unico argomento che è import
import[[2]] <- crop(import[[2]], extent(extent(import[[1]])))
import[[3]] <- crop(import[[3]], extent(extent(import[[1]])))
import
#uso funzione stack che mi crea un oggetto singolo che mi sovrappone tutte e 3 le immagini
Tgr<-stack(import)
# plot dell'oggetto che rappresenta tutte le immagini sovrapposte
plot(Tgr)
plotRGB(TGr,1,2,3, stretch="Lin")
plotRGB?? plotRGB(f1973,r=1,g=2,b=3,stretch="lin")
plotRGB(f1998,r=1,g=2,b=3,stretch="lin")
plotRGB(f2021,r=1,g=2,b=3,stretch="lin")

#2.LAND COVER .....................................................................................
#2.1Unsuperclass
#creo una visuale dell'immagine del 1973 dividendo i pixel in 3 macroclassi con la funzione unsuperclass, classificazione non supervisionata
forunsup<-unsuperClass(f1973,nClasses=3)
plot(forunsup$map)
#faccio la medesima cosa per l'immagine del 1998
forunsup1998<-unsuperClass(f1998, nClasses=3)
plot(forunsup1998$map)
#idem per il 2021
forunsup20213<-unsuperClass(f2021,nClasses=3)
plot(forunsup20213$map)

#2.2Frequenze..........................................................................................
#creo le frequenze delle immagini create prima tramite unsuperclass così posso verificare la dimensione dei pixel per ogni classe
freq(forunsup$map)
     value  count
[1,]     1  34180 # classe 1 acque
[2,]     2 722963 # classe 2 foreste
[3,]     3 153857 #classe 3 coltivi
> s1<-34180+722963+153857
> s1
[1] 911000 #somma tot pixel
#creo le proporzioni per assegnare le percentuali ad ogni classe
> prop1<-freq(forunsup$map)/s1
> prop1
            value      count
[1,] 1.097695e-06 0.03751921 #4% acque bianco 
[2,] 2.195390e-06 0.79359276 #79% foresta giallo 
[3,] 3.293085e-06 0.16888804 #17% coltivi, formaz erbose verde
#frequenze per l'immagine del 1998 con le modalità usate per l'immagine del 1973
freq(forunsup1998$map)
     value  count
[1,]     1 272130 # classe 1 coltivi bianco
[2,]     2  29277 #classe 2 acqua giallo
[3,]     3 610593 #classe 3 foresta verde
s2<-272130+29277+610593
s2
[1] 912000 #tot pixel
#proporzioni per creare le percentuali anche per l'immagine del 1998
prop2<-freq(forunsup1998$map)/s2
prop2
            value      count
[1,] 1.096491e-06 0.29838816 #30% coltivi bianco
[2,] 2.192982e-06 0.03210197 #3% acqua giallo
[3,] 3.289474e-06 0.66950987 #67% foresta verde
#frequenze per l'immagine del 2021
freq(forunsup20213$map)
    value  count
[1,]     1 407324 #classe 1 coltivi bianco
[2,]     2 371609 #classe 2 foresta giallo
[3,]     3 133067 #classe 3 acqua verde
s3<-407324+371609+133067
s3
[1] 912000
#proporzioni per il 2021
prop3<-freq(forunsup20213$map)/s3
prop3
            value     count
[1,] 1.096491e-06 0.4466272 #45% coltivi bianco
[2,] 2.192982e-06 0.4074660 #41% foresta giallo
[3,] 3.289474e-06 0.1459068 #16% acqua verde
...............................................................................
cover<-c("Forest", "Agriculture","Water")
percentage_1973<-c(79.35,16.88,3.75)
percentage_1998<-c(66.95,29.83,3.21)
percentage_2021<-c(40.74,44.66,14.59)
percentages<-data.frame(cover, percentage_1973,percentage_1998,percentage_2021)
percentages
        cover percentage_1973 percentage_1998 percentage_2021
1      Forest           79.35           66.95           40.74
2 Agriculture           16.88           29.83           44.66
3       Water            3.75            3.21           14.59
ggplot(percentages,aes(x=cover,y=percentage_1973,color=cover))+geom_bar(stat="identity", fill="white")
ggplot(percentages,aes(x=cover,y=percentage_1998,color=cover))+geom_bar(stat="identity", fill="white")
ggplot(percentages,aes(x=cover,y=percentage_2021,color=cover))+geom_bar(stat="identity", fill="white")
g1<-ggplot(percentages,aes(x=cover,y=percentage_1973,color=cover))+geom_bar(stat="identity", fill="white")
g2<-ggplot(percentages,aes(x=cover,y=percentage_1998,color=cover))+geom_bar(stat="identity", fill="white")
g3<-ggplot(percentages,aes(x=cover,y=percentage_2021,color=cover))+geom_bar(stat="identity", fill="white")
#diamo un nome ad ogni grafico per inserirlo in un grafico più grande unificante tutti e 3
grid.arrange(g1,g2,g3,nrow=1)
#grafico raggruppa tutte e 3 le immagini

#3.NDVI





