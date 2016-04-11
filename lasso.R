library(Hmisc)
library(TTR)
library(lubridate)

args <- commandArgs(TRUE)

#### GDP and predictors 
data <- read.table(args[1],sep=",",header=TRUE)
colnames(data)[1] <- "Date"
colnames(data)[3] <- "GDP"
data[,2] <- NULL
data[,1] <- NULL
GDP <- data$GDP
data$GDP <- Lag(,1)
data$Date <- Lag(data$Date,22)
data <- na.omit(data)

#### Regression logic
train = head(data,n=-1)
test = tail(data,n=1)

fit_ols <- lm(GDP ~ ., data=data) 

p <- predict(fit,test)
err <- p-test$Close


summary(fit_ols)

#### TODO: Add Lasso regression
#### TODO: Add plots for fit lines
