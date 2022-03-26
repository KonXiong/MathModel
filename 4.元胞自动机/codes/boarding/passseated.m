function [pas,plane]=passseated(numseat,pas,LuggageDelay,PassDelay,plane,layout,t)
%
% passseated      If a passenger reaches the row of his/her allocated seat, 
% a similar timepenalty is introduced, depending on how many seated people 
% he has to pass in this row until he reaches his seat. This is done to 
% allow for passengers moving out of their seats and into the row to permit 
%the given passenger to take his seat.
%
% USAGE:
% [pas,plane]=passseated(numseat,pas,LuggageDelay,PassDelay,plane,layout,t)
%        numseat = number of seat
%        pas = passenger vector
%        LuggageDelay = time delya for laggage stowing
%        PassDelay = time delya for pass seated people
%        plane = seating plan
%        layout = layout of the plane
%        t =  current time
%
% zhou lvwen: zhou.lv.wen@gmail.com

for j = 1:numseat
    
    % if the passenger have ended stowing laggage, but seated. 
    if pas(j).tdelay>LuggageDelay&&pas(j).seattime==0
        
        pas(j).tdelay = pas(j).tdelay +1; 
        
        rowp = pas(j).row;
        colp = pas(j).col;
        cola = layout.aisle(pas(j).aisle);
        % compute how may seated people want to pass.
        if colp<cola;
            passnum = sum(plane(colp:cola)>0);
        else
            passnum = sum(plane(cola:colp)>0);
        end
        
        % if the delay time expire 
        if pas(j).tdelay>LuggageDelay+PassDelay*passnum^2;
            plane(rowp,colp) = t;
            pas(j).seattime = t;
        end
    end
end