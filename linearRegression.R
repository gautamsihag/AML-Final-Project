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


fit <- lm(trainy ~ ., data=trainx) 

p <- predict(fit,testx)
err <- p - testy
print(err)

plot(ts(y,freq=4))
plot(fit)

summary(fit)
