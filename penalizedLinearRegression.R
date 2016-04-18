library(glmnet)

args <- commandArgs(TRUE)

#### GDP and predictors
x <- read.csv(args[1],row.names=1)
y <- read.csv(args[2],row.names=1)

x <- tail(x,-1)


#### Regression logic
n_train <- floor(nrow(x) * 0.8)
trainx <- x[1:n_train,]
testx <- x[n_train:nrow(x),]
trainy <- y[1:n_train,]
testy <- y[n_train:nrow(x),]

cvres <- cv.glmnet(as.matrix(x),as.matrix(y),type.measure="mse",nfolds=3,alpha=args[3])

print(cvres)

fit <- glmnet(as.matrix(x),as.matrix(y),alpha=args[3],lambda=cvres$lambda.min)

plot(cvres)
plot(fit,xvar="lambda",label=TRUE)


