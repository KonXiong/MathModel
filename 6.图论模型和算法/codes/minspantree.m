w = [ 0   4  inf  5  inf  3          % w(i,j)表示顶点i和j间的边权
      4   0   5  inf  3   3
     inf  5   0   5   3  inf
      5  inf  5   0   2   4
     inf  3   3   2   0   1
      3   3  inf  4   1   0];

W = sparse(w);                       % 将满矩阵转化为稀疏矩阵
[ST, pred] = graphminspantree(W);
