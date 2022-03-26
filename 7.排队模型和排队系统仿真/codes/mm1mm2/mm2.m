n = 100000; 
mu = 1; 
muB = 1.8;
tarr = cumsum(exprnd(mu,1,n));
tsrv = exprnd(muB,1,n);
tsta = zeros(1,n);
tlea = zeros(1,n);
twat = zeros(1,n);
last = [0 0];
for i = 2:n
    [minemp, k] = min(last);
    tsta(i) = max(tarr(i),minemp);
    tlea(i) = tsta(i) + tsrv(i);
    last(k) = tlea(i);
    twat(i) = tlea(i) - tarr(i);
end
hist(twat)
sum(twat)/n
