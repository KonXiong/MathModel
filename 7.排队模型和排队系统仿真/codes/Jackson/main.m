%L: Average number of entities in the network
%Lq: Average number of entities in queue in the network
%Ls: Average number of entities in service in the network
%W: Average time spent by an entity in the network
%Wq: Average time spent in queue by an entity in the network
%Ws: Average time spent in service by an entity in the network

nsrv      =  [2     3      3];
lambda123 = [1/12  1/9  1/16];
lambdargb = [1/10  1/13    0];
P = [0 0 1; 0 0 1; 0 0 0];
[L,Lq,Ls,W,Wq,Ws] = jacksonNetwork(gamma,P,nsrv,mu)
