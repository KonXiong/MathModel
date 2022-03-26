function [ L, Lq, Ls, W, Wq, Ws ] = jacksonNetwork( gamma, P , servers, mu)
% jacksonNetwork Returns steady state variables of a Jackson Network
%
% AUTHOR: Juan Felipe Imbett Jiménez
% DATE: OCT 30 2013
% EMAIL: jf.imbett41@uniandes.edu.co
%
%
% PARAMETERS:
% gamma= row vector with the external arrival rates organized
% P= Probability matrix between stations, rows do not need to sum to 1. 
% servers= row vector with the number of servers per station
% mu=row vector with the INDIVIDUAL service rate of each station. 
%
%
% RETURNS
%L: Average number of entities in the network
%Lq: Average number of entities in queue in the network
%Ls: Average number of entities in service in the network
%W: Average time spent by an entity in the network
%Wq: Average time spent in queue by an entity in the network
%Ws: Average time spent in service by an entity in the network
% 


[m,n]=size(P);
I=eye(m);
G=I-P;
%Determines the arrival rate for each station by a matrix operation
lambda=gamma*inv(G);

%Creates a vector with the variables of each station, these vector will
%save all the information. 
L1=ones(m,1); %L for each station
Lq1=ones(m,1); %Lq for each station
Ls1=ones(m,1); %Ls for each station
W1=ones(m,1); %W for each station
Wq1=ones(m,1); %Wq for each station
Ws1=ones(m,1); %Ws for each station

%The algorithm go station by station calculating L, Lq, Ls, W, Wq, Ws
for i=1:m
    [ LL, LLq, LLs, LW, LWq, LWs ]=mmqueue(servers(i),lambda(i),mu(i),-1);
    L1(i)=LL;
    Lq1(i)=LLq;
    Ls1(i)=LLs;
    W1(i)=LW;
    Wq1(i)=LWq;
    Ws1(i)=LWs;
end

L=sum(L1); % L= /sum L_i
Lq=sum(Lq1); % Lq= /sum Lq_i
Ls=sum(Ls1); % Ls= /sum Ls_i
r=sum(gamma); % External rates
W=L/r;
Wq=Lq/r; % Little
Ws=Ls/r; % Little
end
