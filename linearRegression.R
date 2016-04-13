library(Hmisc)
library(TTR)
library(lubridate)

args <- commandArgs(TRUE)

#### GDP and predictors 
x <- read.table(args[1],sep="\t")
x <- x[,colSums(is.na(x))<nrow(x)]
x <- na.omit(x)
x$V1 <- Lag(x$V1,1)
dates <- x$V1
x$V1 <- NULL


#### Regression logic
n_train <- floor(nrow(x) * 0.8)
train <- x[1:n_train,]
test <- x[n_train:nrow(x),]

fit <- lm(V12 ~ ., data=x) 

p <- predict(fit,test)
err <- p - test$V12
print(err)
