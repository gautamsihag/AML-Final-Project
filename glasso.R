library(igraph)

args <- commandArgs(TRUE)

x <- read.table("glasso_res.txt")
x <- as.matrix(x)

y <- read.table(args[1],header=TRUE,sep=",")
y[,1] <- NULL
names <- colnames(y)

colnames(x) <- names
rownames(x) <- names

print(length(names))

diag(x) <- 0

g <- graph.adjacency(x,weighted=TRUE,mode="lower")

sparsity <- list()
reg <- list()

for (i in seq(from=0,to=1,by=0.05)){
	temp <- graph.adjacency(x,weighted=TRUE,mode="lower")
        temp <- delete.edges(temp, E(temp)[ abs(weight) < i ])
	sparsity <- c(sparsity,ecount(temp))
	reg = c(reg, i)
}

plot(reg,sparsity,main="Number of Edges vs. Covariance Threshold",xlab="Covariance Threshold",ylab="Number of Edges",type="b")

g <- delete.edges(g, E(g)[ abs(weight) < 0.2 ])

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
