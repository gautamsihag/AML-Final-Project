library(Hmisc)
library(TTR)
library(lubridate)

args <- commandArgs(TRUE)

#### GDP and predictors 
x <- read.table(args[1],sep="\t")
x$V1 <- Lag(x$V1,1)
x <- na.omit(x)
dates <- x$V1
x$V1 <- NULL


#### Regression logic
n_train <- floor(nrow(x) * 0.8)
train <- x[1:n_train,]
test <- x[n_train:nrow(x),]

fit <- lm(GDP ~ ., data=x) 

p <- predict(fit,test)
err <- p - test$V12
print(err)

plot(ts(GDP,freq=4))
abline(fit)
