library(MASS)
library(Hmisc)

args <- commandArgs(TRUE)

#### GDP and predictors
x <- read.table(args[1],sep="\t")
x <- x[,colSums(is.na(x))<nrow(x)]
x <- na.omit(x)
x$V1 <- Lag(x$V1,1)
x <- na.omit(x)
dates <- x$V1
x$V1 <- NULL

#### Regression logic
fit <- lm.ridge(x$V12 ~ ., data=x,lambda=c(0.01,0.1,1,10,100))

predict(fit,test)

