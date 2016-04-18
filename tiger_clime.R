library(flare)

#### Helper for labels
radian.rescale <- function(x, start=0, direction=1) {
  c.rotate <- function(x) (x + start) %% (2 * pi) * direction
  c.rotate(scales::rescale(x, c(0, 2 * pi), range(x)))
}

#### Turn command line arguments on
args <- commandArgs(TRUE)

#### GDP and predictors
x <- read.csv(args[1],header=TRUE)
x[,1] <- NULL
names <- colnames(x)
x <- read.csv(args[1],skip=100)
x[,1] <- NULL
print(head(x))

#### Use the TIGER algorithm to estimate the sparse precision matrix
results <- sugm(as.matrix(x), method =args[2],standardize=TRUE)
plot(results)
#### Choose graph with maximal sparsity and plot the results
sparsity <- results$sparsity
ind <- which.max(sparsity)
sugm.plot(results$path[[ind]])

m <- results$path[[ind]]
rownames(m) <- names
colnames(m) <- names

g <- graph.adjacency(m,mode="undirected")


l <- layout.auto(g)

plot(g, layout=l, 
     edge.arrow.size=0.5, 
     vertex.label.cex=0.75, 
     vertex.label.family="Helvetica",
     vertex.label.font=2,
     vertex.shape="circle", 
     vertex.size=1, 
     vertex.label.color="black", 
     edge.width=0.75,
     vertex.label.dist=0.2)




