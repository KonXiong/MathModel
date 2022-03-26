type = 1;
nvil  = 35;   % number of villages
ntown = 18;   % number of towns
n = nvil + ntown;
ngroup = 3;

ID = num2cell(nvil+1:nvil+ntown); % index of towns
[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R] = deal(ID{:});

[w, x,y] = road2graph('complete', 'plot');

[ncomp, icomp] = roadtree('noplot');

igroup = zeros(n,1);
switch type
    case 1
        igroup(icomp==1) = 1; igroup(icomp==5) = 1;
        igroup(icomp==2) = 2; igroup(icomp==6) = 2;
        igroup(icomp==3) = 3; igroup(icomp==4) = 3;
    case 2
        igroup(icomp==1) = 1; igroup(icomp==4) = 1; igroup(icomp==5) = 1;
        igroup(icomp==2) = 2;
        igroup(icomp==3) = 3; igroup(icomp==6) = 3;
    case 3
        igroup(icomp==1) = 1; igroup(icomp==5) = 1; igroup(icomp==6) = 1;
        igroup(icomp==2) = 2;
        igroup(icomp==3) = 3; igroup(icomp==4) = 3;
        igroup([2 3 D 4])= 1;
    case 4
        igroup(icomp==1) = 1; igroup(icomp==4) = 1; igroup(icomp==5) = 1;
        igroup(icomp==2) = 2;
        igroup(icomp==3) = 3; igroup(icomp==6) = 3;
        igroup([15 18])  = 2;
        igroup([22 3 4 8 11 13 D G]) = 3;
end
 
dist = zeros(ngroup,1);
color = {'r','m','b'};
for k = 1:ngroup
    i = find(igroup==k|igroup==0);
    wk = w(i,i);
    [order, dist(k)] = minhamiltonpath(wk);
    order = i(order);
    hold on
    plot(x(order([end 1:end])), y(order([end 1:end])), color{k});
end

totdist = sum(dist)
mindist = max(dist)
