function [Aisle,num,pas] = Enter(Aisle,num,pas,layout)
%
% Enter      If the element of the aisle at the entrance to the plane was 
% unoccupied, another passenger was extracted from the passenger vector and 
% fed into the aisle vector.
%
% USAGE:  [Aisle,num,pas] = Enter(Aisle,num,pas,plan,layout)
%        Aisle = aisle vector
%        num = queue out of the plane
%        pas = passenger vector
%        layout = loyout of the plane
%
% zhou lvwen: zhou.lv.wen@gmail.com

if ~isempty(num)
    % Find the nearest aisles, and choose one of them random 
    dist = abs(pas(num(1)).col-layout.aisle);
    I = find(dist==min(dist));
    index = randperm(length(I));
    
    % if the first position of aisle is empty, then allow one passenger enter.
    if ~isempty(I)&&Aisle(1,I(index(1)))==0; 
        Aisle(1,I(index(1)))=num(1);
        pas(num(1)).aisle=I(index(1));
        num(1)=[];      
    end
end