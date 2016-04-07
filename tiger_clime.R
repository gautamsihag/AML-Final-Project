library(flare)

#### Turn command line arguments on
args <- commandArgs(TRUE)

#### Read in the data table
data <- read.csv(args[1],header=TRUE)
data[,1] <- NULL
data[,2] <- NULL
data <- as.matrix(data)

#### Use the TIGER algorithm to estimate the sparse precision matrix
results <- sugm(data, method =args[2])
plot(results)

#### Choose graph with maximal sparsity and plot the results
sparsity <- results$sparsity
ind <- which.max(sparsity)
sugm.plot(results$path[[ind]])
