library(glmnet)
library(ADMM)
library(Hmisc)

args <- commandArgs(TRUE)

x <- read.csv(args[1],header=TRUE)
x$Date <- Lag(x$Date,1)
x$GDP <- Lag(x$GDP,1)
x <- na.omit(x)

y <- x$GDP

x$GDP <- NULL

fit <- glmnet(x,y)

fit <- glmnet(x, y)
out_glmnet <- coef(fit, s = exp(-2), exact = TRUE)
out_admm <- admm_lasso(x, y)$penalty(exp(-2))$fit()
out_paradmm <- admm_lasso(x, y)$penalty(exp(-2))$parallel()$fit()

data.frame(glmnet = as.numeric(out_glmnet),
           admm = as.numeric(out_admm$beta),
           paradmm = as.numeric(out_paradmm$beta))

