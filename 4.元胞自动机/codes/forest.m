% simulate forest fire with cellular automata
% zhou lvwen: zhou.lv.wen@gmail.com
% August 15 2010 

n = 300;
Plight = 5e-6; 
Pgrowth = 1e-2;
UL = [n 1:n-1]; 
DR = [2:n 1];
veg=zeros(n,n);
imh = image(cat(3,veg,veg,veg));
% veg = empty=0 burning=1 green=2
for i=1:3000
    %nearby fires?
    sum =            (veg(UL,:)==1) + ...
        (veg(:,UL)==1)     +      (veg(:,DR)==1) + ...
                     (veg(DR,:)==1);

    veg = 2*(veg==2) - ...
          ( (veg==2) & (sum>0 | (rand(n,n)<Plight)) ) + ...
          2*((veg==0) & rand(n,n)<Pgrowth) ;
     
    set(imh, 'cdata', cat(3,(veg==1),(veg==2),zeros(n)) )
    drawnow
end