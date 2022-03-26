t = 86400/5+1; %number of 5 second periods in a day
lanes =6; %number of lanes, assume lanes <= booths
booths = 10; %number of booths... assume booths << cars

i = ceil(61565 * lanes/4); %number of cars... 61565 found through integration of the influx equation 
inrate = 0;
outrate = 0;
S=0;
A=0;
L=0;
B=0;
Start=0;
N=0;
E=0;
last=0;
L2=0;
L3=0;
S(1:i) = 0; %service duration time for car i
A(1:i) = 0; %arrival time of car i
L(1:i) = 0; %leaving time of car i
B(1:i) = 0; %tollbooth used by car i
Start(1:i) = 0; %service start time for car i
last(booths) = 0; %last time at which a car left a particular booth
inrate(1:t) = 0; %influx at time t
L2(1:t) = 0; %number of cars leaving tollbooths at time t
L3(1:t) = 0; %smoothed our version of L2
outrate(1:24) = 0; %rate of outflux
N(1:t) = 0; %number of cars in line at time t
h = linspace(0,24,17281); %indexing vector for each 5 second time period
a0 = 41.68;
a = [-16.38, -18.59, 3.572, 7.876, -0.5048, -2.97, 0.2518, 0.5785];
b = [12.53, 0.6307, -13.67, 0.4378, 6.93, 0.4869, -1.554, -0.5871];
omega = 0.2513; %all Fourier Coefficients
inrate = a0 * ones(size(h));
for n = 1:8
    inrate = inrate + a(n).*cos(n.*h.*omega) + b(n).*sin(n.*h.*omega);
end

inrate = inrate * lanes / 4; %scaling lanes by appropriate amount
A(1) = 12/inrate(1); %arrival time of car 1 in terms of inrate
for j = 2:i
    k = floor(A(j-1));
    if k == 0
       k = 1;
    end
    A(j) = A(j-1) + 12/inrate(k); %arrival time of car i in terms of inrate
end
mu = 2.4; %mean service duration time in 5-second periods
S = exprnd(mu,1,i); %service time as an exponential random variable

for j = 1:i
    for k = 1:booths
        if (last(k) == min(last))
           B(j) = k; %find booth that was/will be emptied soonest
        end
    end
    if A(j) > last(B(j)) % if there is an empty booth, then...
       Start(j) = A(j); % start right away
       L(j) = Start(j) + S(j);
       last(B(j)) = L(j);
    else %if not...
       Start(j) = last(B(j)); %start once the soonest one becomes available
       L(j) = Start(j) + S(j);
       last(B(j)) = L(j);
    end
end

for j = 1:i
    k = ceil(L(j));
    if k > t
       k = t;
    end
    for m = ceil(A(j)):k
        N(m) = N(m) + 1; %counts the number of people in line
    end
end
W = L - (A + S); %waiting time is line time - (arrival time + service time)
for k = 1:i
    if L(k) <= t
       L2(ceil(L(k))) = L2(ceil(L(k))) + 1; %creation of L2, outflux from tollbooths
    end
end
k = length(W);
for j = 1:i
    if W(j) == 0
       k = k-1;
    end
end
totalavgwait = sum(W)/i/12/60;
carsavgwait = sum(W)/k/12/60;
maxwait = max(W)/12/60;