function [ncomp, icomp] = roadtree(ifplot)
if nargin<1; ifplot = 'plot'; end

[w, x,y, n, O] = road2graph('original', 'noplot');
[dist, path, pred] = graphshortestpath(w, O, 'directed', false);

I = setdiff(1:n, O);
J = pred(I);

tree = zeros(n);
for k = 1:length(I)
    i = I(k); j = J(k);
    tree(i,j) = w(i,j); tree(j,i) =w(j,i);
end

treeO = tree; treeO(:,O) = 0; treeO(O,:) = 0;

[ncomp, icomp] = graphconncomp(sparse(treeO),'directed',false);

if strcmp(ifplot,'plot')
    color = {'r','g','b','m','k','c'};
    for k = 1:length(I)
        i = I(k); j = J(k);
        plot([x(i),x(j)], [y(i),y(j)]',['o-', color{icomp(i)}])
        hold on
    end
end
