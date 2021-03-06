function [w, x,y, n, O] = road2graph(gtype, ifplot)
if nargin<1; 
    gtype = 'original'; ifplot = 'plot'; 
elseif nargin<2; 
    ifplot = 'plot';
end


nvil  = 35;   % number of villages
ntown = 18;   % number of towns
n = nvil + ntown;

ID = num2cell(nvil+1:nvil+ntown); % index of towns
[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R] = deal(ID{:});

%% coordinates of villages & towns for plot
x = [61.7 51.3 52.0 51.3 44.4 35.9 33.3 35.5 22.9 20.9 ... %  1-10
     18.9  9.4  9.1  1.6  0.0  8.2 13.9 15.1 21.1 26.1 ... % 11-20
     24.7 20.3 28.6 29.9 30.5 43.5 44.1 50.6 59.0 60.8 ... % 21-30
     64.4 68.9 68.1 75.1 78.5 67.2 65.2 58.4 45.9 28.6 ... % 31-35, A-E
     19.9 13.1  1.9  8.1 14.9 20.9 26.5 39.3 34.9 56.3 ... %  F- O
     50.5 56.2 61.1                                    ]'; %  P- R
 
y = [28.9 23.6 19.0  6.9 24.6 25.4 19.2 13.3 12.7  0.0 ... %  1-10
     19.2 11.8 24.3 26.7 39.7 47.2 45.9 35.6 28.3 33.6 ... % 11-20
     39.8 48.6 46.7 54.2 37.4 41.7 47.7 45.5 45.7 53.7 ... % 21-30
     45.8 50.5 40.5 36.5 42.7 34.2 25.9 20.9 15.9 15.3 ... % 31-35, A-E
      8.8 17.6 17.6 37.7 28.6 41.2 28.7 32.6 44.3 29.6 ... %  F- O
     35.9 50.8 38.8                                    ]'; %  P- R

%% distance matrix 
w = zeros(n);

w(1, A) = 10.3; w(1, B) =  5.9; w(1, C) = 11.2; w(1, O) =  6.0; 
w(2, 3) =  4.8; w(2, 5) =  8.3; w(2, O) =  9.2;
w(3, C) =  7.9; w(3, D) =  8.2;
w(4, 8) = 20.4; w(4, D) = 12.7;
w(5, 6) =  9.7; w(5, D) = 11.3; w(5, M) = 11.4;

w(6, 7) =  7.3; w(6, L) = 11.8; w(6, M) =  9.5;
w(7, D) = 15.1; w(7, E) =  7.2; w(7, L) = 14.5;
w(8, E) =  8.0;
w(9, E) =  7.8; w(9, F) =  5.6;
w(10,F) = 10.8;

w(11,E) = 14.2; w(11,G) =  6.8; w(11,J) = 13.2;
w(12,F) = 12.2; w(12,G) =  7.8; w(12,H) = 10.2;
w(13,14)=  8.6; w(13,G) =  8.6; w(13,I) = 16.4; w(13,J) = 9.8;
w(14,15)= 15.0; w(14,H) =  9.9;
w(15,I) =  8.8;

w(16,17)=  6.8; w(16,I) = 11.8;
w(17,22)=  6.7; w(17,K) =  9.8;
w(18,I) =  8.2; w(18,J) =  8.2; w(18,K) =  9.2;
w(19,20)=  9.3; w(19,J) =  8.1; w(19,L) =  7.2;
w(20,21)=  7.9; w(20,25)=  6.5; w(20,L) =  5.5;

w(21,23)=  9.1; w(21,25)=  7.8; w(21,K) =  4.1;
w(22,23)= 10.0; w(22,K) = 10.1;
w(23,24)=  8.9; w(23,N) =  7.9;
w(24,27)= 18.8; w(24,N) = 13.2;
w(25,M) = 12.0; w(25,N) =  8.8;

w(26,27)=  7.8; w(26,N) = 10.5; w(26,P) = 10.5;
w(27,28)=  7.9; 
w(28,P) = 12.1; w(28,Q) =  8.3;
w(29,P) = 15.2; w(29,Q) =  7.2; w(29,R) =  7.9;
w(30,32)= 10.3; w(30,Q) =  7.7;

w(31,32)=  8.1; w(31,33)=  7.3; w(31,R) =  9.2;
w(32,33)= 19.0; w(32,35)= 14.9;
w(33,35)= 20.3; w(33,A) =  7.4;
w(34,35)=  8.2; w(34,A) = 11.5; w(34,B) = 17.6;

w(A, B) = 12.2; w(A, R) =  8.8;
w(B, C) = 11.0; 
w(I, J) = 15.8;
w(C, O) = 11.5;
w(M, N) = 14.2; w(M, O) = 19.8;

w(O, P) = 10.1; w(O, R) = 12.9;

w = sparse(w'); % upper triangular matrix to lower trianglular matrix

%% plot graph
if strcmp(ifplot,'plot')
    [i,j] = find(w>0);
    plot([x(i),x(j)]', [y(i),y(j)]','o:b','linewidth',4);
end
%%
if strcmp(gtype,'complete')
   w = graphallshortestpaths(w, 'directed', false);
end
