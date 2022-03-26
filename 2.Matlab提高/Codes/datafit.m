x=[1,1.5,2,2.5,3]'; y=[0.9,1.7,2.2,2.6,3]';  

a = polyfit(x,y,1) 
xi = 1:0.1:3;
yi = polyval(a,xi);  
plot(x,y,'o',xi,yi); 


figure
p = fittype('a*x+b*sin(x)+c');
f = fit(x,y,p)  
plot(f,x,y); 
