[w, x,y] = road2graph('complete', 'plot'); hold on

[order, totdist] = minhamiltonpath(w)

plot(x(order([end 1:end])), y(order([end 1:end])),'r-','linewidth',2)
