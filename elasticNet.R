library(glmnet)
library(ADMM)

args <- commandArgs(TRUE)

x <- read.csv(args[1],header=TRUE)
x$Date <- Lag(x$Date,1)
x$GDP <- Lag(x$GDP,1)
x <- na.omit(x)

y <- x$GDP

x$GDP <- NULL

fit <- glmnet(x,y)

fit <- glmnet(x, y, alpha = 0.5)
out_glmnet <- coef(fit, s = exp(-2), exact = TRUE)
out_admm <- admm_enet(x, y)$penalty(exp(-2), alpha = 0.5)$fit()
data.frame(glmnet = as.numeric(out_glmnet),
           admm = as.numeric(out_admm$beta))

