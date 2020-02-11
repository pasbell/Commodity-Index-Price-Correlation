install.packages("quantmod")
library(quantmod)




#uploading Data sets
CrudeOil <- read.csv("Crude Oil WTI Futures Historical Data.csv")
DowJones <- read.csv("Dow Jones Industrial Average Historical Data.csv")
Gold <- read.csv("Gold Futures Historical Data.csv")


CrudeOilOpen <- as.numeric(CrudeOil$Open)
CrudeOilClose <- as.numeric(CrudeOil$Price)
DowJonesOpen <- as.numeric(DowJones$Open)
DowJonesClose <- as.numeric(DowJones$Price)
GoldOpen <- as.numeric(Gold$Open)
GoldClose <- as.numeric(Gold$Price)


#Calculate Daily Log Returns For Each Data Set
CrudeOilLogReturns <- log(CrudeOilOpen/CrudeOilClose)
DowJonesLogReturns <- log(DowJonesOpen/DowJonesClose)
GoldLogReturns <- log(GoldOpen/GoldClose)

test <- t.test(CrudeOilLogReturns, DowJonesLogReturns)
test$estimate["mean of x"]




#Histogram of log returns for each data set
CrudeOilHist <- hist(CrudeOilLogReturns, breaks = sqrt(500), main = "Crude Oil Returns for 2 Years", xlab = "Log Returns", ylab = "frequency")
DowJonesHist <- hist(DowJonesLogReturns, breaks = sqrt(500), main = "Dow Jones Returns for 2 Years", xlab = "Log Returns", ylab = "frequency")
GoldHist <- hist(GoldLogReturns, breaks =sqrt(500), main = "Gold Returns for 2 Years", xlab = "Log Returns", ylab = "frequency")


#Normal Probability Plots
CrudeOilNorm <- qqnorm(CrudeOilLogReturns, main = "Normal Q-Q Plot for Crude Oil", pch = 16, cex = .5)
qqline(CrudeOilLogReturns)
DowJoneslNorm <- qqnorm(DowJonesLogReturns, main = "Normal Q-Q Plot for Dow Jones", pch = 16, cex = .5)
qqline(DowJonesLogReturns)
GoldNorm <- qqnorm(GoldLogReturns, main = "Normal Q-Q Plot for Gold", pch = 16, cex = .5)
qqline(GoldLogReturns)


#Confidence Intervals for mean and variance of each data set

#CrudeOil
COmean <- mean(CrudeOilLogReturns)
COs <- sd(CrudeOilLogReturns)
COn <- nrow(CrudeOil)

COerror <- qt(0.95, df=COn-1)*COs/sqrt(COn)
COmeanLI <- COmean - COerror
COmeanRI <- COmean + COerror

COvarLI <- ((COn-1)*(COs^2))/(qchisq(0.025, df=COn-1, lower.tail = FALSE))
COvarRI <- ((COn-1)*(COs^2))/(qchisq(0.975, df=COn-1, lower.tail = FALSE))


CrudeOilData <- c(COmean, COs, COmeanLI, COmeanRI, COvarLI, COvarRI)

#dowjones
DJmean <- mean(DowJonesLogReturns)
DJs <- sd(DowJonesLogReturns)
DJn <- nrow(DowJones)

DJerror <- qt(0.95, df=DJn-1)*DJs/sqrt(DJn)
DJmeanLI <- DJmean - DJerror
DJmeanRI <- DJmean + DJerror

DJvarLI <- ((DJn-1)*(DJs^2))/(qchisq(0.025, df=DJn-1, lower.tail = FALSE))
DJvarRI <- ((DJn-1)*(DJs^2))/(qchisq(0.975, df=DJn-1, lower.tail = FALSE))

DowJonesData <- c(DJmean, DJs, DJmeanLI, DJmeanRI, DJvarLI, DJvarRI)

#Gold
Gmean <- mean(GoldLogReturns)
Gs <- sd(GoldLogReturns)
Gn <- nrow(Gold)

Gerror <- qt(0.95, df=Gn-1)*Gs/sqrt(Gn)
GmeanLI <- Gmean - Gerror
GmeanRI <- Gmean + Gerror

GvarLI <- ((Gn-1)*(Gs^2))/(qchisq(0.025, df=Gn-1, lower.tail = FALSE))
GvarRI <- ((Gn-1)*(Gs^2))/(qchisq(0.975, df=Gn-1, lower.tail = FALSE))

GoldData <- c(Gmean, Gs, GmeanLI, GmeanRI, GvarLI, GvarRI)


#Scatter Plots

plot(x=DowJonesLogReturns, y=CrudeOilLogReturns, main="Scatter Plot Crude Oil vs Dow Jones", pch = 16, cex = .5)
abline(lm(CrudeOilLogReturns ~ DowJonesLogReturns))
plot(x=DowJonesLogReturns, y=GoldLogReturns, main="Scatter Plot Gold vs Dow Jones", pch = 16, cex = .5)
abline(lm(GoldLogReturns ~ DowJonesLogReturns))
plot(x=GoldLogReturns, y=CrudeOilLogReturns, main="Scatter Plot Crude Oil vs Gold", pch = 16, cex = .5)
abline(lm(CrudeOilLogReturns ~ GoldLogReturns))
plot(x=CrudeOilLogReturns, y=DowJonesLogReturns, main="Scatter Plot Dow Jones vs Crude Oil", pch = 16, cex = .5)
abline(lm(DowJonesLogReturns ~ CrudeOilLogReturns))

#Correlation Between Data Sets
DJcorCO <-cor(DowJonesLogReturns, CrudeOilLogReturns)
DJcorG <- cor(DowJonesLogReturns, GoldLogReturns)
GcorCO <- cor(GoldLogReturns, CrudeOilLogReturns )


#independence

#Dow Jones vs Crude Oil
n <- seq(from = -0.2, to = 0.1, by = 0.1)
s <- seq(from = -0.05, to = 0.05, by = 0.005)
contigentcytableDJvsCO <- table(cut(DowJonesLogReturns, c(-Inf, n, Inf ) ), cut(CrudeOilLogReturns, c(-Inf, s, Inf )))
IDJvCO <- chisq.test(contigentcytableDJvsCO)
write.csv(contigentcytableDJvsCO, file = "contigentcytableDJvsCO.csv")

IDJvCO.values <- unname(c(DJcorCO, IDJvCO$statistic, IDJvCO$parameter,  IDJvCO$p.value))


#Crude Oil and Gold
a <- seq(from = -0.1, to = 0.1, by = 0.1)
b <- seq(from = -0.05, to = 0.05, by = 0.005)

contigentcytableCOvsG <- table(cut(GoldLogReturns, c(-Inf, a, Inf) ), cut(CrudeOilLogReturns, c(-Inf, b, Inf )))
ICOvG <- chisq.test(contigentcytableCOvsG)
write.csv(contigentcytableCOvsG, file = "contigentcytableCOvsG.csv")

ICOvG.values <- unname(c(GcorCO, ICOvG$statistic, ICOvG$parameter,  ICOvG$p.value))
contigentcytableCOvsG

#Dow jones and Gold
x <- seq(from = -0.4, to = 0.2, by = 0.1)
y <- seq(from = -0.2, to = 0.3, by = 0.1)
contigentcytableDJvsG <- table(cut(DowJonesLogReturns, c(-Inf, x, Inf ) ), cut(GoldLogReturns, c(-Inf, y, Inf )))
IDJvG <- chisq.test(contigentcytableDJvsG)
write.csv(contigentcytableDJvsG, file = "contigentcytableDJvsG.csv")

IDJvG.values <- unname(c(DJcorG, IDJvG$statistic, IDJvG$parameter,  IDJvG$p.value))




#Build Linear Model
CO.lm = lm(CrudeOilLogReturns ~ DowJonesLogReturns)
Gold.lm = lm(GoldLogReturns ~ DowJonesLogReturns)
COvsGold.lm = lm(CrudeOilLogReturns ~ GoldLogReturns)
DJvsCO.lm = lm(DowJonesLogReturns ~ CrudeOilLogReturns)

COlmsummary <- summary(CO.lm)
Goldlmsummary <- summary(Gold.lm)
COvsGoldlmsummary <- summary(COvsGold.lm)
DJvsCOlmsummary <- summary(DJvsCO.lm)




#Hypothesis Testing, Null Nypothesis: B1 = 0

#Crude Oil vs Dow Jones
COlmcoeffs <- COlmsummary$coefficients
CO.B1.estimate <- COlmcoeffs["DowJonesLogReturns", "Estimate"]  
CO.B1.std.error <- COlmcoeffs["DowJonesLogReturns", "Std. Error"] 
CO.B1.tstat <- CO.B1.estimate/CO.B1.std.error
CO.tstat.pvalue <- 2*pt(-abs(CO.B1.tstat), df=(nrow(DowJones)-2))  # calc p Value
CO.fstat <- unname(COlmsummary$fstatistic[1])  # fstatistic
CO.f <- unname(summary(CO.lm)$fstatistic)  # parameters for model p-value calc
CO.f.pval <- unname(pf(CO.f[1], CO.f[2], CO.f[3], lower=FALSE))
COD.CO = summary(CO.lm)$r.squared
  
COvsDJdata <- c(CO.B1.estimate, CO.B1.std.error, CO.B1.tstat, CO.tstat.pvalue, CO.fstat, CO.f.pval, COD.CO)


#Gold vs Dow Jones

Goldlmcoeffs <- Goldlmsummary$coefficients
Gold.B1.estimate <- Goldlmcoeffs["DowJonesLogReturns", "Estimate"]  
Gold.B1.std.error <- Goldlmcoeffs["DowJonesLogReturns", "Std. Error"] 
Gold.B1.tstat <- Gold.B1.estimate/Gold.B1.std.error
Gold.tstat.pvalue <- 2*pt(-abs(Gold.B1.tstat), df=(nrow(Gold)-2))  # calc p Value
Gold.fstat <- unname(Goldlmsummary$fstatistic[1])  # fstatistic
Gold.f <- unname(summary(Gold.lm)$fstatistic)  # parameters for model p-value calc
Gold.f.pval <- unname(pf(Gold.f[1], Gold.f[2], Gold.f[3], lower=FALSE))
COD.Gold = summary(Gold.lm)$r.squared

GoldvsDJdata <- c(Gold.B1.estimate, Gold.B1.std.error, Gold.B1.tstat, Gold.tstat.pvalue, Gold.fstat, Gold.f.pval, COD.Gold) 


#Crude Oil vs Gold

COvsGoldlmcoeffs <- COvsGoldlmsummary$coefficients
COvsGold.B1.estimate <- COvsGoldlmcoeffs["GoldLogReturns", "Estimate"]  
COvsGold.B1.std.error <- COvsGoldlmcoeffs["GoldLogReturns", "Std. Error"] 
COvsGold.B1.tstat <- COvsGold.B1.estimate/COvsGold.B1.std.error
COvsGold.tstat.pvalue <- 2*pt(-abs(COvsGold.B1.tstat), df=(nrow(Gold)-2))  # calc p Value
COvsGold.fstat <- unname(COvsGoldlmsummary$fstatistic[1])  # fstatistic
COvsGold.f <- unname(summary(COvsGold.lm)$fstatistic)  # parameters for model p-value calc
COvsGold.f.pval <- unname(pf(COvsGold.f[1], COvsGold.f[2], COvsGold.f[3], lower=FALSE))
COD.COvsGold = summary(COvsGold.lm)$r.squared

COvsGolddata <- c(COvsGold.B1.estimate, COvsGold.B1.std.error, COvsGold.B1.tstat, COvsGold.tstat.pvalue, COvsGold.fstat, COvsGold.f.pval, COD.COvsGold) 

#Dow Jones vs Crude Oil

DJvsCOlmcoeffs <- DJvsCOlmsummary$coefficients
DJvsCO.B1.estimate <- DJvsCOlmcoeffs["CrudeOilLogReturns", "Estimate"]  
DJvsCO.B1.std.error <- DJvsCOlmcoeffs["CrudeOilLogReturns", "Std. Error"] 
DJvsCO.B1.tstat <- DJvsCO.B1.estimate/DJvsCO.B1.std.error
DJvsCO.tstat.pvalue <- 2*pt(-abs(DJvsCO.B1.tstat), df=(nrow(CrudeOil)-2))  # calc p Value
DJvsCO.fstat <- unname(DJvsCOlmsummary$fstatistic[1])  # fstatistic
DJvsCO.f <- unname(summary(DJvsCO.lm)$fstatistic)  # parameters for model p-value calc
DJvsCO.f.pval <- unname(pf(DJvsCO.f[1], DJvsCO.f[2], DJvsCO.f[3], lower=FALSE))
COD.DJvsCO = summary(DJvsCO.lm)$r.squared

DJvsCOdata <- c(DJvsCO.B1.estimate, DJvsCO.B1.std.error, DJvsCO.B1.tstat, DJvsCO.tstat.pvalue, DJvsCO.fstat, DJvsCO.f.pval, COD.DJvsCO) 

#Residuals
res.CO = resid(CO.lm)
res.Gold = resid(Gold.lm)
res.COvsGold = resid(COvsGold.lm)
res.DJvsCO = resid(DJvsCO.lm)
plot(DowJonesLogReturns, res.CO, ylab="Residuals", xlab="Dow Jones Log Returns", main="Crude Oil vs Dow Jones Residuals", pch = 16, cex = .5) 
plot(DowJonesLogReturns, res.Gold, ylab="Residuals", xlab="Dow Jones Log Returns", main="Gold Oil vs Dow Jones Residuals", pch = 16, cex = .5)
plot(GoldLogReturns, res.COvsGold, ylab="Residuals", xlab="Gold Log Returns", main="Crude Oil vs Gold Returns Residuals", pch = 16, cex = .5)
plot(CrudeOilLogReturns, res.DJvsCO, ylab="Residuals", xlab="Crude Oil Log Returns", main="Dow Jones vs Crude Oil Residuals", pch = 16, cex = .5)


#Summary of data
#Mean, StdDeviation, CI interval of mean and variance

meanvartbl <- matrix(c(DowJonesData, GoldData, CrudeOilData), ncol = 6, byrow = TRUE)
colnames(meanvartbl) <- c("Mean", "Standard Deviation", "Mean Left CI", "Mean Right CI", "Variance Left CI", "Variance Right CI")
rownames(meanvartbl) <- c("Dow Jones", "Gold", "Crude Oil")

#Independecence Values
Independencetbl <- matrix(c(IDJvCO.values, IDJvG.values, ICOvG.values), ncol = 4, byrow = TRUE)
colnames(Independencetbl) <- c("Correlation Coefficient", "X-Squared statistic", "Degrees of Freedom", "P-value")
rownames(Independencetbl) <- c("Crude oil vs Dow Jones", "Gold vs Dow Jones", "Crude Oil vs Gold")



#Linear Regression
lmtbl<- matrix(c(COvsDJdata, GoldvsDJdata, COvsGolddata, DJvsCOdata), ncol = 7, byrow = TRUE)
colnames(lmtbl) <- c("Slope Estimate", "Slope Std Error", "Slope t-statistic H1: B=0", "Slope pvalue", "F-statistic", "F-statistic pval", "Coefficient of Determination")
rownames(lmtbl) <- c("Crude oil vs Dow Jones", "Gold vs Dow Jones", "Crude Oil vs Gold", "Dow Jones vs Crude Oil")

write.csv(meanvartbl, file = "meanvartbl.csv")
write.csv(lmtbl, file = "lmtbl.csv")
write.csv(Independencetbl, file = "Independence.csv")

