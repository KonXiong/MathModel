% translate the qustion into polynomial fit,then we can use the
% polyfit fuction 
% P=x0*exp(r*t) => lnP = lnx0 + r * t
%                  \|/    \|/  \|/ \|/
%                   Y  =  a2  + a1* x
t = 1790:10:1900;
p = [ 3.9  5.3  7.2  9.6 12.9 ...
     17.1 23.2 31.4 38.6 50.2 ...
     62.9 76.0];
 
Y = log(p); X = t;
a = polyfit(X,Y,1);
x0 = exp(a(2)); r = a(1);
ti = 1790:1900;
pt= x0*exp(r*ti);

plot(t,p,'o',ti,pt,'m');
xlabel('Year');
ylabel('Population')
