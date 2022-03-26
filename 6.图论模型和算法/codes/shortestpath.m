%    a b c d e f
w = [0 0 0 0 0 0    % a
     2 0 0 0 0 0    % b
     3 6 0 0 0 0    % c
     0 5 0 0 0 0    % d
     0 3 1 1 0 0    % e
     0 0 0 2 4 0];  % f
W = sparse(w);      % 将满矩阵转化为稀疏矩阵
                    % 对于无向图,'Directed'属性设为0
[Dist,Path] = graphshortestpath(W, 1, 6,'Directed',0);
