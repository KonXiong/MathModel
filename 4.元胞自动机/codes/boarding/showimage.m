function showimage(Aisle,plane,layout)
%
% showimage     Show the image 
%
% USAGE:  showimage(Aisle,plane,layout)
%        Aisle = aisle vector
%        plane = plane
%        layout =  layout of the plane
%
% zhou lvwen: zhou.lv.wen@gmail.com

[x,y] = size(plane);
numAisle = size(Aisle,2);
Plane = zeros(2*x,y);

Plane(1:2:2*x,:)=plane;
Plane(2:2:2*x,:)=plane;
Plane(:,layout.aisle) = Aisle;

% adjust the color
Plane=Plane/(max(max(Plane))+50);
Plane(Plane==0)=1;
imagesc(cat(3,Plane,Plane,Plane))


