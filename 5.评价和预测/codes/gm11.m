t0 = [1999:2003]';
X0 = [89, 99, 109, 120, 135]';
n = length(X0);
lambda = X0(1:n-1)./X0(2:n);
range = minmax(lambda')
exp([-2/(n+1), 2/(n+2)])
X1 = cumsum(X0);
Z1 = (X1(1:n-1)+X1(2:n))/2
B = [-Z1, ones(n-1,1)];
Y = X0(2:n);
u = B\Y; a = u(1); b = u(2);
k = 0:n+4;
xhat1 = (X0(1) - b/a).*exp(-a*k) + b/a;
xhat0 = [X0(1) diff(xhat1)]
plot(t0,X0,'o',t0(1)+k, xhat0,'-+')