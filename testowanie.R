install.packages('GAS')
library(GAS)

dane <- read.table(file = "C:/Users/Patrycja/Desktop/ZarzadzanieRyzykiem_zadanie4/dane.txt")
VaR95 <- read.table(file = "C:/Users/Patrycja/Desktop/ZarzadzanieRyzykiem_zadanie4/VaR95.txt")
VaR99 <- read.table(file = "C:/Users/Patrycja/Desktop/ZarzadzanieRyzykiem_zadanie4/VaR99.txt")
dane_K1 <- read.table(file = "C:/Users/Patrycja/Desktop/ZarzadzanieRyzykiem_zadanie4/dane_W.txt")
VaR95_K1 <- read.table(file = "C:/Users/Patrycja/Desktop/ZarzadzanieRyzykiem_zadanie4/VaR95_W.txt")
VaR99_K1 <- read.table(file = "C:/Users/Patrycja/Desktop/ZarzadzanieRyzykiem_zadanie4/VaR99_W.txt")
dane_K2 <- read.table(file = "C:/Users/Patrycja/Desktop/ZarzadzanieRyzykiem_zadanie4/dane_W.txt")
VaR95_K2 <- read.table(file = "C:/Users/Patrycja/Desktop/ZarzadzanieRyzykiem_zadanie4/VaR95_W.txt")
VaR99_K2 <- read.table(file = "C:/Users/Patrycja/Desktop/ZarzadzanieRyzykiem_zadanie4/VaR99_W.txt")
dane_W <- read.table(file = "C:/Users/Patrycja/Desktop/ZarzadzanieRyzykiem_zadanie4/dane_W.txt")
VaR95_W <- read.table(file = "C:/Users/Patrycja/Desktop/ZarzadzanieRyzykiem_zadanie4/VaR95_W.txt")
VaR99_W <- read.table(file = "C:/Users/Patrycja/Desktop/ZarzadzanieRyzykiem_zadanie4/VaR99_W.txt")

dane <- as.numeric(unlist(dane))
VaR95 <- as.numeric(unlist(VaR95))
VaR99 <- as.numeric(unlist(VaR99))
dane_K1 <- as.numeric(unlist(dane_K1))
VaR95_K1 <- as.numeric(unlist(VaR95_K1))
VaR99_K1 <- as.numeric(unlist(VaR99_K1))
dane_K2 <- as.numeric(unlist(dane_K2))
VaR95_K2 <- as.numeric(unlist(VaR95_K2))
VaR99_K2 <- as.numeric(unlist(VaR99_K2))
dane_W <- as.numeric(unlist(dane_W))
VaR95_W <- as.numeric(unlist(VaR95_W))
VaR99_W <- as.numeric(unlist(VaR99_W))

BacktestVaR(dane, VaR95, 0.95)$LRuc
BacktestVaR(dane, VaR95, 0.95)$Lrcc
BacktestVaR(dane, VaR99, 0.99)$LRuc
BacktestVaR(dane, VaR99, 0.99)$LRcc
BacktestVaR(dane_K1, VaR95_K1, 0.95)$LRuc
BacktestVaR(dane_K1, VaR95_K1, 0.95)$Lrcc
BacktestVaR(dane_K1, VaR99_K1, 0.99)$LRuc
BacktestVaR(dane_K1, VaR99_K1, 0.99)$LRcc
BacktestVaR(dane_K2, VaR95_K2, 0.95)$LRuc
BacktestVaR(dane_K2, VaR95_K2, 0.95)$Lrcc
BacktestVaR(dane_K2, VaR99_K2, 0.99)$LRuc
BacktestVaR(dane_K2, VaR99_K2, 0.99)$LRcc
BacktestVaR(dane_W, VaR95_W, 0.95)$LRuc
BacktestVaR(dane_W, VaR95_W, 0.95)$Lrcc
BacktestVaR(dane_W, VaR99_W, 0.99)$LRuc
BacktestVaR(dane_W, VaR99_W, 0.99)$LRcc
