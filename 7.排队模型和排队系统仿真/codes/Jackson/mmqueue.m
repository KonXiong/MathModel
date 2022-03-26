function [L, Lq, Ls, W, Wq, Ws ] = mmqueue( s, lambda, mu, c )
% mmqueues Returns steady state variables of a M/M queue
%
% AUTHOR: Juan Felipe Imbett Jim�nez
% DATE: OCT 30 2013
% EMAIL: jf.imbett41@uniandes.edu.co
%
% Kendall Lee notation: M/M/s/GD/c/infty
% PARAMETERS:
% s: Number of servers
% c: capacity of the system (queue+service) if infinite c=-1
% lambda: single arrival rate (per entity)
% mu: single service rate (per server)
%
% RETURNS
%L: Average number of entities in the system
%Lq: Average number of entities in queue in the system
%Ls: Average number of entities in service in the system
%W: Average time spent by an entity in the system
%Wq: Average time spent in queue by an entity in the system
%Ws: Average time spent in service by an entity in the system
% 


%First case M/M/1


if s==1 && c==-1
    L=lambda/(mu-lambda);
    Ls=lambda/mu;
    Lq=L-Ls;
    W=L/lambda;
    Wq=Lq/lambda;
    Ws=Ls/lambda;
    
end

%Second case M/M/1/GD/c

if s==1 && c>0
   rho=lambda/mu;
    pi0=(1-rho)/(1-(rho)^(c+1));
    pic=pi0*((rho)^c);
    L=(rho*(1-(c+1)*(rho^c)+c*(rho^(c+1))))/((1-rho^(c+1))*(1-rho));
    W=L/(lambda*(1-pic));
    Ls=1-pi0;
    Lq=L-Ls;
    Wq=Lq/(lambda*(1-pic));
    Ws=Ls/(lambda*(1-pic));
end

%Third case M/M/s/GD/infty

if s>1 && c==-1
    rhos=lambda/(s*mu);
    p=pjs(s,rhos);
    Lq=p*rhos/(1-rhos);
    Wq=Lq/lambda;
    L=Lq+lambda/mu;
    W=L/lambda;
    Ws=1/mu;
    Ls=lambda/mu;
end

%Fourth case M/M/infty/GD/infty

if s==-1 && c==-1
    Lq=0;
    Ls=lambda/mu;
    L=Ls;
    Wq=0;
    Ws=1/mu;
    W=Ws;
end

% -------------------------------------------------------------------------

function [ p ] = pjs( s, rhos )
% pjs: Calculates P(j>=s) for a M/M/s/GD/infty/infty
% AUTHOR: Juan Felipe Imbett Jim�nez
% DATE: OCT 30 2013
% EMAIL: jf.imbett41@uniandes.edu.co  
%sumatory=0;

i = 0:s-1;
sumatory = sum( (s*rhos).^i./factorial(i) );
pi0 = 1/( sumatory + (s*rhos)^s/(factorial(s)*(1-rhos)) );
p = pi0*(s*rhos)^s/(factorial(s)*(1-rhos));