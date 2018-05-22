install.packages('GAS')
library(GAS)

dane <- read.table(file = "C:/Users/Patrycja/Desktop/ZarzadzanieRyzykiem_zadanie4/dane.txt")
VaR95 <- dane <- read.table(file = "C:/Users/Patrycja/Desktop/ZarzadzanieRyzykiem_zadanie4/VaR95.txt")
VaR99 <- read.table(file = "C:/Users/Patrycja/Desktop/ZarzadzanieRyzykiem_zadanie4/VaR99.txt")

dane <- as.numeric(unlist(dannn))
VaR95 <- dane <- as.numeric(unlist(VaR95))

BacktestVaR(dane, VaR95, 0.05)