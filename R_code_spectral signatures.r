#R_code_spectral_signatures.r
#library(raster)
#library(rgdal)
#setwd("C:/lab/")
#defor2 <- brick("defor2.jpg") <- brick("defor2.jpg")
#defor2.1, defor2.2 and defor2.3
#NIR, red and green
#plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
#plotRGB(defor2, r=1, g=2, b=3, stretch="hist")
#click(defor2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")
#Cliccare dinamicamente firma spettrale di interesse!
     x     y  cell defor2.1 defor2.2 defor2.3
1 91.5 440.5 26621      204        8       22
      x     y   cell defor2.1 defor2.2 defor2.3
1 548.5 183.5 211347       59       69      131
#Definire righe e colonne del dataset
band <- c(1,2,3)
forest <- c(204,8,22)
water <- c(59,69,131)
spectralsignatures <- data.frame(band, forest, water)
#ggplot(spectrals, aes(x=band)) +
 geom_line(aes(y=forest), color="green")
#ggplot(spectrals, aes(x=band)) +
 geom_line(aes(y=forest), color="green") +
 geom_line(aes(y=water), color="blue") 
#Multitemporale
#defor1 <- brick("defor1.jpg")
#plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
#plotRGB(defor1, r=1, g=2, b=3, stretch="hist")
#Firme spettrali per defor1
#click(defor1, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")
#Creare outpot (impossbilitato per caricamento del percedente)
#La stessa operazione deve essere effettuata per defor2
#plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
#click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")
#Come creare il dataset per questi nuovi pixel?
#band <- c(1,2,3)
time1 <- c(223,11,33)
time2 <- c(197,163,151)
#spectralsignaturestemporal <- data.frame(band, time1, time2)
# plot the sepctral signatures
ggplot(spectrals, aes(x=band)) +
 geom_line(aes(y=time1), color="red") +
 geom_line(aes(y=time2), color="gray") +
 labs(x="band",y="reflectance")
# define the columns of the dataset:
band <- c(1,2,3)
time1 <- c(223,11,33)
time1p2 <- c(218,16,38)
time2 <- c(197,163,151)
time2p2 <- c(149.157,133)
 
spectralst <- data.frame(band, time1, time2, time1p2, time2p2)

# plot the sepctral signatures
ggplot(spectralst, aes(x=band)) +
 geom_line(aes(y=time1), color="red") +
 geom_line(aes(y=time1p2), color="red") +
 geom_line(aes(y=time2), color="gray") +
 geom_line(aes(y=time2p2), color="gray") +     #linetype="dot"
 labs(x="band",y="reflectance")
#random_points
#extract
#Effettuare la stessa procedura per una immagine dall'Earth Observatory
#MM <- brick("mangrove.jpg")
#plotRGB(MM, r=1, g=2, b=3, stretch="lin")
#click(MM, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")
#x     y   cell mangrove.1 mangrove.2 mangrove.3
1 206.5 287.5 138447          3         34         29
      x     y   cell mangrove.1 mangrove.2 mangrove.3
1 545.5 251.5 164706        183        142        112
      x     y   cell mangrove.1 mangrove.2 mangrove.3
1 438.5 188.5 209959        192        149        117
# define the columns of the dataset:
band <- c(1,2,3)
mangrove1 <- c(3,34,29)
mangrove2 <- c(183,142,112)
mangrove3 <- c(192,149,117)
mangrovespectralsignatures <- data.frame(band, mangrove1, mangrove2, mangrove3)
mangrovespectralsignatures
  band mangrove1 mangrove2 mangrove3
1    1         3       183       192
2    2        34       142       149
3    3        29       112       117
## plot the sepctral signatures
ggplot(mangrovespectralsignatures, aes(x=band)) +
 geom_line(aes(y=mangrove1), color="red") +
 geom_line(aes(y=mangrove2), color="red") +
 geom_line(aes(y=mangrove3), color="gray") +
 labs(x="band",y="reflectance")
