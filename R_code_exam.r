setwd("C:/lab/")
library(raster)
library()
library()
#installo i pacchetti che mi permetteranno di utilizzare le varie funzioni
f1973<-raster("forest1973.png")
f1998<-raster("forest1998.png")
f2021<-raster("forest2021.png")
#importato le immagini satellitari necessarie su R
forest<-list.files(pattern="forest")
#creato una lista contente le 3 immagini usato un pattern comune a tutte, che in questo caso è "forest"
forest
#[1] "forest1973.png" "forest1998.png" "forest2021.png"
#creato una lista di file delle 3 immagini così le funzioni verranno applicate in maniera univoca sulla lista
import<-lapply(forest,raster)
#importo con funzione l apply la lista forst su raster, lapplymi fa applicare funzione raster a tutta la lista forest
f1973<-brick("forest1973.png")
f1998<-brick("forest1998.png")
f2021<-brick("forest2021.png")
plotRGB?? plotRGB(f1973,r=1,g=2,b=3,stretch="lin")
> plotRGB(f1998,r=1,g=2,b=3,stretch="lin")
> plotRGB(f2021,r=1,g=2,b=3,stretch="lin")
#UNSUPERCLASS
#IMM 1973
forunsup<-unsuperClass(f1973,nClasses=3)
plot(forunsup$map)
#imm 1998
#imm 2021
forunsup20213<-unsuperClass(f2021,nClasses=3)
plot(forunsup20213$map)
forunsup1998<-unsuperClass(f1998, nClasses=3)
plot(forunsup1998$map)
#frequenze.................................................................................................................
 
freq(forunsup$map)
     value  count
[1,]     1  34180 # classe 1 acque
[2,]     2 722963 # classe 2 foreste
[3,]     3 153857 #classe 3 coltivi
> s1<-34180+722963+153857
> s1
[1] 911000 #somma tot pixel
> prop1<-freq(forunsup$map)/s1
> prop1
            value      count
[1,] 1.097695e-06 0.03751921 #4% acque bianco 
[2,] 2.195390e-06 0.79359276 #79% foresta giallo 
[3,] 3.293085e-06 0.16888804 #17% coltivi, formaz erbose verde

freq(forunsup1998$map)
     value  count
[1,]     1 272130 # classe 1 coltivi bianco
[2,]     2  29277 #classe 2 acqua giallo
[3,]     3 610593 #classe 3 foresta verde
> s2<-272130+29277+610593
> s2
[1] 912000 #tot pixel
> prop2<-freq(forunsup1998$map)/s2
> prop2
            value      count
[1,] 1.096491e-06 0.29838816 #30% coltivi bianco
[2,] 2.192982e-06 0.03210197 #3% acqua giallo
[3,] 3.289474e-06 0.66950987 #67% foresta verde

freq(forunsup20213$map)
    value  count
[1,]     1 407324 #classe 1 coltivi bianco
[2,]     2 371609 #classe 2 foresta giallo
[3,]     3 133067 #classe 3 acqua verde
> s3<-407324+371609+133067
> s3
[1] 912000
> prop3<-freq(forunsup20213$map)/s3
> prop3
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



