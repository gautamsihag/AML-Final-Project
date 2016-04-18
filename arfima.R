library(forecast)

args <- commandArgs(TRUE)

#### GDP data
gdp <- read.table(args[1],sep=",",header=TRUE)
gdp <- gdp[,2]

#### Split data into test and training sets
n_train <- floor(length(gdp) * 0.8)
train <- gdp[1:n_train]
test <- gdp[n_train:length(gdp)]

#### Auto fit ARFIMA model
fit <- arfima(ts(train))

#### Predict future values and check testing error
fcast <- forecast(fit)
pred <- fcast$fitted

err <- test - pred[1:length(test)]

print("MSE:")
print(sqrt(sum(err^2)))

plot(fcast)
tsdisplay(residuals(fit),main="Residuals")
