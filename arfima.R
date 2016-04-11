library(forecast)

args <- commandArgs(TRUE)

#### GDP data
gdp <- read.table(args[1],sep=",",header=TRUE)
gdp <- gdp[,3] 

#### Split data into test and training sets
n_train <- floor(length(gdp) * 0.8)
train <- head(gdp,n=-1)
test <- tail(gdp,n=1) 

#### Auto fit ARFIMA model
fit <- arfima(ts(train,frequency=4))

#### Predict future values and check testing error
fcast <- forecast(fit,h=1)
pred <- fcast$fitted


err <- test - pred

print(pred)

print("MSE:")
print(sqrt(sum(err^2)))

