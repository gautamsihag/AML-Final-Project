library(flare)

#### Turn command line arguments on
args <- commandArgs(TRUE)

#### Read in the data table
data <- read.csv(args[1],header=TRUE)

#### Use the TIGER algorithm to estimate the sparse precision matrix
results <- sugm(data, method ="tiger")
plot(results)

#### Choose graph with maximal sparsity and plot the results

