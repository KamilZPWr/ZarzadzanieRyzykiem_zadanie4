install.packages('GAS')
library(GAS)

dane <- read.table(file = "C:/Users/Patrycja/Desktop/ZarzadzanieRyzykiem_zadanie4/dane.txt")
VaR95 <- read.table(file = "C:/Users/Patrycja/Desktop/ZarzadzanieRyzykiem_zadanie4/VaR95.txt")
VaR99 <- read.table(file = "C:/Users/Patrycja/Desktop/ZarzadzanieRyzykiem_zadanie4/VaR99.txt")

dane <- as.numeric(unlist(dane))
VaR95 <- as.numeric(unlist(VaR95))
VaR99 <- as.numeric(unlist(VaR99))

BacktestVaR(-dane, VaR95, 0.95)
BacktestVaR(-dane, VaR99, 0.01)
