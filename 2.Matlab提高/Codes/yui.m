subplot(3,1,1)
Yui = imread('Yui.jpg');
image(Yui);
axis image

subplot(3,1,2)
lip = Yui(242:266,255:279,:);
image(lip);
axis image


subplot(3,1,3)
procheilon = lip(12:13,12:13,:)
image(procheilon)
axis image

