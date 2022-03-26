function Aisle = Advance(Aisle,pas)
%
% Advance     When a passenger was encountered in an element, a check was
% carried out whether anther passenger was present in the aisle element
% ahead of him/her. If theat element was unoccupied, the passenger moved
% into this aisle-element with the probablity (speed) associated with that
% individual.
%
% USAGE:  Aisle = Advance(Aisle,pas)
%        Aisle = aisle vector
%        pas = passenger vector
%
% zhou lvwen: zhou.lv.wen@gmail.com

[x,y] = size(Aisle);
for i = x*y-1:-1:1
    if (Aisle(i)>0)&&(Aisle(i+1)==0)&&...  % i element is ocupy and i+1 is empty
       (pas(Aisle(i)).speed>rand)&&...     % moved with the probablity (speed)
       (pas(Aisle(i)).tdelay==-1)           % not reach the row of his allocated seat.
        
        Aisle(i+1)=Aisle(i);
        Aisle(i)=0;
    end
end