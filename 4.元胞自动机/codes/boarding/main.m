% main.m
% This is a main script to simulate the boarding process.
%
% Boarding step by step: A Cellular Automaton approach to optimising
% aircraft boarding time (Andreas Hafver, Chris Rohwer, Louise Viljoen)
%
% zhou lvwen: zhou.lv.wen@gmail.com

clear;clc
figure('name','Boarding-step by step','position',[300,50,400,600]);

LuggageDelay = 5; 
PassDelay = 2;

[plan,numseat,layout]=SeatingPlans('Boeing-777-200');
plane = zeros(size(plan));

num = sortpas(numseat,plan,layout,'reverse_pyramid');
pas = passenger(numseat,plan,num);

AisleLength = 2*size(plane,1);
AisleWidth = size(layout.aisle,2);
Aisle = zeros(AisleLength,AisleWidth);

t = 0;
flag = 0;
while ~flag 
    [Aisle,pas] = luggage(Aisle,pas,LuggageDelay);
    [pas,plane]=passseated(numseat,pas,LuggageDelay,PassDelay,plane,layout,t);
    [Aisle] = Advance(Aisle,pas);
    [Aisle,num,pas] = Enter(Aisle,num,pas,layout);
    t = t + 1;
    showimage(Aisle,plane,layout)
    set(xlabel(sprintf('Total time = %d',t)),'FontSize',16);
    drawnow
    
    flag = 1;
    for i = 1:numseat
        flag = flag&&pas(i).seattime;
    end
end


