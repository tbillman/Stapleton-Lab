#setting up a function to extract efficiency data
library(qpcR)
efdat <- function(dat, fluor, eftype) {
  final = numeric()
  for (x in fluor) {
    ft<-pcrfit(data = dat , fluo = x, model = l4)
    ef<- efficiency(ft, plot = FALSE, type = eftype)
    final = c(final,ef[[eftype]])
  }
  return(final)
}
fcpD1 = efdat(f517,fluof,"cpD1")
hcpD1 = efdat(h517,fluoh,"cpD1")
fcpD2 = efdat(f517,fluof,"cpD2")
hcpD2 = efdat(h517,fluoh,"cpD2")

values= c(rep(300000,5),
          rep(30000,5),
          rep(3000,5),
          rep(300,5),
          rep(30,5),
          rep(3,5),
          rep(0,5))
#cpD1 plots
famframe = data.frame(PoI = fcpD1, Treatment = values)
hexframe = data.frame(PoI = hcpD1, Treatment = values)
plot(x = famframe[,2], y = famframe[,1], log = "x",xlab = "Treatment Level", ylab = "PoI Cycle", main = "FAM Main Trials")
plot(x = hexframe[,2], y = hexframe[,1], log = "x",xlab = "Treatment Level", ylab = "PoI Cycle", main = "HEX Main Trials")

#cpD2 plots
famframe = data.frame(PoI = fcpD2, Treatment = values)
hexframe = data.frame(PoI = hcpD2, Treatment = values)
plot(x = famframe[,2], y = famframe[,1], log = "x",xlab = "Treatment Level", ylab = "PoI Cycle", main = "FAM Main Trials")
plot(x = hexframe[,2], y = hexframe[,1], log = "x",xlab = "Treatment Level", ylab = "PoI Cycle", main = "HEX Main Trials")

# #now with multiplex data
# fluom <- c(12,13,24,25,36,37,48,49,60,61,72,73,84,85,86:94,96,97)
# values<- c(3000,3000,300,300,30,30,3,3,3000,3000,300,300,30,30,3000,300,30,3,rep(0,5),3,3)
# hexmcpD1 = efdat(h517,fluom,"cpD1")
# fammcpD1 = efdat(f517,fluom,"cpD1")
# fammframe = data.frame(PoI = fammcpD1, Treatment = values)
# hexmframe = data.frame(PoI = hexmcpD1, Treatment = values)
# plot(x = fammframe[,2], y = fammframe[,1], log = "x",xlab = "Treatment Level", ylab = "PoI Cycle", main = "FAM Main Trials")
# plot(x = hexmframe[,2], y = hexmframe[,1], log = "x",xlab = "Treatment Level", ylab = "PoI Cycle", main = "HEX Main Trials")
# #trying without the NTC data
# fluom <- c(12,13,24,25,36,37,48,49,60,61,72,73,84,85,86:89,96,97)
# values<- c(3000,3000,300,300,30,30,3,3,3000,3000,300,300,30,30,3000,300,30,3,3,3)
# hexmcpD1 = efdat(h517,fluom,"cpD1")
# fammcpD1 = efdat(f517,fluom,"cpD1")
# fammframe = data.frame(PoI = fammcpD1, Treatment = values)
# hexmframe = data.frame(PoI = hexmcpD1, Treatment = values)
# plot(x = fammframe[,2], y = fammframe[,1], log = "x",xlab = "Treatment Level", ylab = "PoI Cycle", main = "FAM Multiplex w/ Treatment")
# plot(x = hexmframe[,2], y = hexmframe[,1], log = "x",xlab = "Treatment Level", ylab = "PoI Cycle", main = "HEX Multiplex w/ Treatment")
# #seems that col 85 (G12) has a curve that can't be fit
plot(x = f517[,1], y = f517[,85])
#now without 85, but with NTC
fluom <- c(12,13,24,25,36,37,48,49,60,61,72,73,84,86:94,96,97)
values<- c(3000,3000,300,300,30,30,3,3,3000,3000,300,300,30,3000,300,30,3,rep(0,5),3,3)
hexmcpD1 = efdat(h517,fluom,"cpD1")
fammcpD1 = efdat(f517,fluom,"cpD1")
fammframe = data.frame(PoI = fammcpD1, Treatment = values)
hexmframe = data.frame(PoI = hexmcpD1, Treatment = values)
plot(x = fammframe[,2], y = fammframe[,1], log = "x",xlab = "Treatment Level", ylab = "PoI Cycle", main = "FAM Multiplex")
plot(x = hexmframe[,2], y = hexmframe[,1], log = "x",xlab = "Treatment Level", ylab = "PoI Cycle", main = "HEX Multiplex")
#also checkin cpD2
fluom <- c(12,13,24,25,36,37,48,49,60,61,72,73,84,86:94,96,97)
values<- c(3000,3000,300,300,30,30,3,3,3000,3000,300,300,30,3000,300,30,3,rep(0,5),3,3)
hexmcpD1 = efdat(h517,fluom,"cpD2")
fammcpD1 = efdat(f517,fluom,"cpD2")
fammframe = data.frame(PoI = fammcpD1, Treatment = values)
hexmframe = data.frame(PoI = hexmcpD1, Treatment = values)
plot(x = fammframe[,2], y = fammframe[,1], log = "x",xlab = "Treatment Level", ylab = "PoI Cycle", main = "FAM Multiplex")
plot(x = hexmframe[,2], y = hexmframe[,1], log = "x",xlab = "Treatment Level", ylab = "PoI Cycle", main = "HEX Multiplex")


#new 627 data
f627 <- read.csv(file = "f627.csv", header = TRUE, sep = ",")
h627<-  read.csv(file = "h627.csv", header = TRUE, sep = ",")
#Generally what we want to use
#A8 is a FAM NTC 
#   use f627[,9]
mdl<-pcrfit(f627,1,9,l4)
efficiency(mdl)
#    looks like last half of curve (sqrt looking)
#A9 is also
#   use f627[,10]
mdl<-pcrfit(f627,1,10,l4)
efficiency(mdl)
#    looks like above curve
#B2 is a 1:10 FAM: HEX multiplex
#   use f627[,15] and h627[,15]
mdl<-pcrfit(f627,1,15,l4)
efficiency(mdl)
#     fam looks like first half of curve (exponential section)
mdl<-pcrfit(h627,1,15,l4)
efficiency(mdl)
#     hex looks the same, but has cpD1,cpD2 < 40
#C2 is a 1:100 multiplex
#   use f627[,27] and h627[,27]
mdl<-pcrfit(f627,1,27,l4)
efficiency(mdl)
#    fam looks like start up, level off, then exponential cpD1/D2= 40
mdl<-pcrfit(h627,1,27,l4)
efficiency(mdl)
#    hex looks very exponental, but with cpD1/D2 < 40
#B5 is the same as B2
#   use f627[,18] and h627[,18]
mdl<-pcrfit(f627,1,18,l4)
efficiency(mdl)
#     fam looks the same as C2
mdl<-pcrfit(h627,1,18,l4)
efficiency(mdl)
#     hex looks like C2
#D7 is .03 copies of FAM
#   use f627[,44]
mdl<-pcrfit(f627,1,44,l4)
efficiency(mdl)
#     just starts taking off, CpD1/D2 = 40

