n = 10; % 顶点数

% 给Andre, Betty, ..., Jane标号为1, 2, ..., 10.
Andre = 1; Betty = 2; Carol = 3; Dave  = 4; Ed    = 5;
Fanny = 6; Garth = 7; Hale  = 8; Ike   = 9; Jane  =10;

% 根据图构造邻接矩阵.
A = zeros(10);
A(Andre, [Betty, Carol,  Dave, Fanny]) = 1;
A(Betty, [Andre,  Dave,    Ed, Garth]) = 1;
A(Carol, [Andre,  Dave, Fanny]) = 1;
A( Dave, [Andre, Betty, Carol,    Ed, Fanny, Garth]) = 1;
A(   Ed, [Betty,  Dave, Garth]) = 1;
A(Fanny, [Andre, Carol,  Dave, Garth,  Hale]) = 1;
A(Garth, [Betty,  Dave,    Ed, Fanny,  Hale]) = 1;
A( Hale, [Fanny, Garth,   Ike]) = 1;
A(  Ike, [ Hale,  Jane]) = 1;
A( Jane, [  Ike]) = 1;

Cd = degrees(A)' /(n-1)   % 计算点度中心度并标准化.
Cc = closeness(A)*(n-1)   % 计算接近中心度并标准化.
