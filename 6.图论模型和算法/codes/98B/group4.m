nvil  = 35;   % number of villages
ntown = 18;   % number of towns
n = nvil + ntown;
ngroup = 4;

ID = num2cell(nvil+1:nvil+ntown); % index of towns
[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R] = deal(ID{:});

[w, x,y] = road2graph('complete');

[ncomp, icomp] = roadtree('noplot');

igroup = zeros(n,1);
igroup(icomp==1|icomp==5) = 1;
igroup(icomp==2|icomp==6) = 2;
igroup(icomp==3|icomp==4) = 3;
%igroup(P) = 1;
igroup([11 12 13 14 19 20 25 M J L H G])=4;

[dist, nv, nt] = deal(zeros(ngroup,1));
color = {'r','m','b','c'};
for k = 1:ngroup
    i = find(igroup==k|igroup==0);
    nv(k) = sum( (i<=nvil) );  
    nt(k) = sum( (i> nvil) ) - 1;   
    wk = w(i,i);
    [order, dist(k)] = minhamiltonpath(wk);
    order = i(order);
    hold on
    plot(x(order([end 1:end])), y(order([end 1:end])), color{k}, 'linewidth',2);
end

time = 2*nt + nv + dist/35
tottime = sum(time)
maxtime = max(time)