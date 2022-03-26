function pas = passenger(numseat,plan,num)
%
% passenger      Generate vector of passenger which also contained the
% following information for each passenger:
%    1.passenger number       pas.num
%    2.seat number            pas.seat
%    3.walking speed          pas.speed
%    4.seated time            pas.seattime
%    5.luggage dely trace     pas.tdely
%    6.which aisle to enter   pas.aisle
%    7.row and col of seat    pas.row & pas.col 
%
% USAGE:  pas = passenger(numseat,plan)
%        numseat = number of seats
%        plan = seating plan
%
% zhou lvwen: zhou.lv.wen@gmail.com


seat = 1:numseat; 
for i = 1:numseat
    pas(i).num = num(i);
    pas(i).seat = seat(i);
    
    p = rand;
    pas(i).speed = 1-0.3*(p<0.12)-0.4*(p<0.02);
    pas(i).seattime = 0;
    pas(i).tdelay = -1; 
    pas(i).aisle = 0;
    
    [row,col] = find(pas(i).seat==plan);
    pas(i).row = row;
    pas(i).col = col;
end