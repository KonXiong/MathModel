n = 100000; 
mu = 1; muA = 0.9;
tarr = cumsum(exprnd(mu,1,n));
tsrv = exprnd(muA,1,n);
tsta = zeros(1,n);
tlea = zeros(1,n);
twat = zeros(1,n);
tsta(1) = tarr(1);
tlea(1) = tsta(1) + tsrv(1);
twtime(1) = tlea(1) - tarr(1);
for i = 2:n
    tsta(i) = max(tarr(i),tlea(i-1));
    tlea(i) = tsta(i) + tsrv(i);
    twat(i) = tlea(i) - tarr(i);
end
hist(twat)
sum(twat)/n
