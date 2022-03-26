filename = 'beltway.dat';
fid = fopen(filename,'r');
tline = fgetl(fid); tline = fgetl(fid);
DATA = [];
while ischar(tline)
    data = regexp(tline, ',', 'split')
    [date,lat,long] = data{:};
    time = datenum(date,'dd/mm/yyyy')
    lat  = str2num(lat); long = str2num(long);
    tline = fgetl(fid);
    DATA = [DATA; time lat long];
end
fclose(fid);

time = DATA(:,1)';
lat = DATA(:,2)';
long = DATA(:,3)';
n = length(time);


weights = ones(n,1);
x = long;                   y = lat;
xbar = x*weights;           ybar = y*weights;
xbar = xbar/n;              ybar = ybar/n;
xran = max(long)-min(long); yran = max(lat)-min(lat);
ran = max(xran,yran);
DELTA = 100;
dx = ((xbar + ran) - (xbar - ran))/DELTA;
dy = ((ybar + ran) - (ybar - ran))/DELTA;
x = (xbar - ran)-dx : dx : (xbar + ran)+dx;
y = (ybar - ran)-dy : dx : (ybar + ran)+dy;
[X,Y] = meshgrid(x,y);
P = zeros(size(X));
for j = 1:length(long)
     R = sqrt((X-long(j)).^2 + (Y-lat(j)).^2)
     P = P+exp(-R);
end
imagesc(x,y,P)
hold on
plot(long,lat,'k.','markersize',15);
axis image
