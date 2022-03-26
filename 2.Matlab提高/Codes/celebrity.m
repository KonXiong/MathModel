% Find PageRank of network by finding dominant evec
%
% reference: http://en.wikipedia.org/wiki/PageRank
%            http://sites.davidson.edu/mathmovement/celebrity-networking/
%
% 
%      _       _       _             _
%     | (1-d)/N |     | l11, ..., l1n |
% R = |   ...   | + d | ..., ..., ... | R     % R = c + d * L*D * R
%     |_(1-d)/N_|     |_ln1, ..., lnn_|       % R = (I - d * L*D )\c
%
% zhou lvwen: zhou.lv.wen@gmail.com
% 

clear;clc

d = 0.85;  % damping factor

name = {'bill', 'ellen', 'jimmy', 'kim', 'paula', 'ryan'}; % celebrities
[bil, ell, jim, kim, pau, rya] = deal(1,2,3,4,5,6);        % id

n = length(name); % number of celebrities

L = zeros(n);
% if user j follows user i, then L(i,j) = 1
L(bil, [rya, ell]) = 1;
L(jim, [rya, pau, ell]) = 1;
L(kim, [jim, rya, ell]) = 1;
L(pau, [rya, ell])=1;
L(rya, [bil, jim, kim, pau, ell]) = 1;
L(ell, [jim, rya]) = 1;

% ot = out-degree, in = in-degree
ot = sum(L,1); in = sum(L,2); 

k = find(ot~=0);
D = sparse(k,k,1./ot(k),n,n);

c = (1-d)/n*ones(n,1);
I = eye(n);

R = (I - d*L*D)\c