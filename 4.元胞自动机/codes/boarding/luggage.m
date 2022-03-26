function [Aisle,pas] = luggage(Aisle,pas,LuggageDelay)
%
% luggage      When a passenger gets to the row of his/her allocated seat, 
% he/she must stow his hand-luggage. Since this takes time during which he 
% obstructs the smooth motion of other passengers through the aisle, a rule 
% was implemented that these passengers block the aisle for 5 time steps.
%
% USAGE:  [Aisle,pas] = luggage(Aisle,pas,LuggageDely)
%        Aisle = aisle vector
%        pas = passenger vector
%        LuggageDely = time delays for luggage stowing.
%
% zhou lvwen: zhou.lv.wen@gmail.com

[x,y] = find(Aisle>0);
for i = 1:length(x)
    numi = Aisle(x(i),y(i));
    row = ceil(x(i)/2);
    
    % if he/she had reached the row of his/her allocated seat
    if pas(numi).row == row 
        pas(numi).tdelay = pas(numi).tdelay + 1; % add time step
        if  pas(numi).tdelay > LuggageDelay % if the stow process ended.
             Aisle(x(i),y(i)) = 0;
        end
    end
end