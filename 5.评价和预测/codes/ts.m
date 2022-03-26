y = [533.8 574.6 606.9 649.8  705.1, ...  
     772.0 816.4 892.7 963.9 1015.1];
m = length(y);
n = 4;
c = cumsum(y);
yhat = ( c(n:end)-[0 c(1:end-n)] )/n;
S = norm(yhat(1:end-1) - y(n+1:end))/sqrt(m-n)