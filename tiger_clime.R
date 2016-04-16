library(flare)

#### Turn command line arguments on
args <- commandArgs(TRUE)

#### Read in the data table
x <- read.csv(args[1],sep=",")
x <- na.omit(x)
dates <- x$V1
x[,1] <- NULL

print(x)

#### Use the TIGER algorithm to estimate the sparse precision matrix
results <- sugm(as.matrix(x), method =args[2])
plot(results)

#### Choose graph with maximal sparsity and plot the results
sparsity <- results$sparsity
ind <- which.max(sparsity)
sugm.plot(results$path[[ind]])

