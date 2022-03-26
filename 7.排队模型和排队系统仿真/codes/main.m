n1 = 2;  n2 = 3; n3 = 3;
mu1 = 12; mu2 = 9; mu3 = 16;
muR = 10; muB = 13;

nR = ceil(24*3600/muR); nB = ceil(24*3600/muB);
tArrR = cumsum(exprnd(muR,nR,1));
tArrB = cumsum(exprnd(muB,nB,1)); 
tArr = [tArrR; tArrB];
type = [0.8*ones(nR,1); 1.2*ones(nB,1)];

[tLeaR, tWatR, qLenR] = mms(tArrR, ones(nR,1), mu1*ones(n1,1));
[tLeaB, tWatB, qLenB] = mms(tArrB, ones(nB,1), mu2*ones(n2,1));

[tArrG, order] = sort([tLeaR; tLeaB]);
[tLeaG, tWatG, qLenG] = mms(tArrG, type(order), mu3*ones(n3,1));
tLeaG(order) = tLeaG;
tWatG(order) = tWatG;
qLenG(order) = qLenG;


figure('position',[50,50,1200,600])
subplot(2,3,1); hist(qLenR); ylabel('Frequency'); 
xlabel('length of the waiting line'); title('Red')
subplot(2,3,4); hist(tWatR); ylabel('Frequency'); 
xlabel('waiting time'); title('Red')


subplot(2,3,2); hist(qLenB); ylabel('Frequency');
xlabel('length of the waiting line'); title('Blue')
subplot(2,3,5); hist(tWatB); ylabel('Frequency'); 
xlabel('waiting time'); title('Blue')

subplot(2,3,3); hist(qLenG); ylabel('Frequency');
xlabel('length of the waiting line'); title('Green')
subplot(2,3,6); hist(tWatG); ylabel('Frequency'); 
xlabel('waiting time'); title('Green')
