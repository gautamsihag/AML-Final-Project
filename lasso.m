cd('~/Desktop')
T = readtable('data.csv');

X = table2array(T(:,4:end));
Y = table2array(T(:,3));

[B FitInfo] = lasso(X,Y)

lassoPlot(B,FitInfo)