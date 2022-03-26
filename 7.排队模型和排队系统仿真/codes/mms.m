function [tlea, twat, qlen] = mms(tarr, type, mus)
% MMS Stochastic simulation for M/M/c queue
%
% [tlea, twat, qlen] = mms(tarr, type, mus)
%     tarr = arrival time of customers
%     type = customer type parameters
%     mus  = serere rate of servers
%     tlea = leaving time of servers
%     twat = waiting time of servers
%     qlen = length of the queue (length of the waiting line) for customers
% 
% Zhou Lvwen: zhou.lv.wen@gmail.com
% January 21, 2017

narr = length(tarr);        % number of customers
nsvr = length(mus);         % number of servers

% last time at which a customer left a particular server
last = zeros(nsvr,1);

[tsta, tlea, twat, qlen] = deal(zeros(narr,1));

rndm = zeros(nsvr,narr);    % rndm(k,i) = service time for i-th customer
for k = 1:nsvr; rndm(k,:) = exprnd(mus(k)*type); end

for i = 1:narr
    % find booth service was/will be emptied soonest and record
    [minemp, ksvr(i)] = min(last); 
    
    % start time = max{arrival time, minemp}
    tsta(i) = max(tarr(i), minemp); 
    
    % severe time = exponential random number with mean parameter mu
    tsvr(i) = rndm(ksvr(i),i);
    
    % leaving time = start time + service time
    tlea(i) = tsta(i) + tsvr(i);
    
    % last time of k-th server = leaving time of i-th customer 
    last(ksvr(i)) = tlea(i);
    
    % waiting time = leaving time - arrival time
    twat(i) = tlea(i) - tarr(i);
    
    % queue length for i customer
    j = i - 1;
    while j>0 && tarr(i)<tlea(j)
        if ksvr(j)==ksvr(i); qlen(i) = qlen(i) + 1; end
        j = j - 1;
    end
end
