#knitr
setwd("C:/lab/")
library(knitr)
stitch("R_Code_greenland.r.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
#caricato codice di time series tramite report tramite funzione knitr











