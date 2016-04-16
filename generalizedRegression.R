library(penalized)

args <- commandArgs(TRUE)

#### GDP and predictors
x <- read.table(args[1],sep="\t")
x <- x[,colSums(is.na(x))<nrow(x)]
x <- na.omit(x)
x$V1 <- Lag(x$V1,1)
dates <- x$V1
x$V1 <- NULL


#### Regression logic
