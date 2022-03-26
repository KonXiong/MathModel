T=[0.5:1:23.5]';
influx=[15.44 15.32	15.16 19.9  47.09 89.95 ...  %  0.5- 5.5 hour
        105.9 85.52 54.68 43.11 40.16 40.85 ...  %  6.5-11.5 hour
        41.72 44.54	48.88 53.2  51.61 48.38 ...  % 12.5-17.5 hour
        39.72 30.51 29.48 26.82	21.21 17.22]';   % 18.5-23.5 hour
    
omega =2*pi/24; %all Fourier Coefficients
fc=zeros(24,8);
fs=zeros(24,8);
for n = 1:8
fc(:,n)=cos(n*omega*T);
fs(:,n)=sin(n*omega*T);
end
[B,BINT,R,RINT,STATS] = regress(influx,[ones(24,1),fc,fs],0.05);

t=0:0.01:24;
a0 = B(1);
a = B(2:9);
b = B(10:end);
inrate = a0 
for n = 1:8
inrate = inrate + a(n).*cos(n.*t.*omega) + b(n).*sin(n.*t.*omega);
end


subplot(1,2,1)

plot(t,inrate,'k')

xlim([0,24]);
set(gca,'xtick',[0:24/5:24]);
set(gca,'xticklabel','');
xlabel('t(hrs)')

ylabel('F_{in}(t)');
set(gca,'yticklabel',' ')
box on


subplot(1,2,2)

%===============================================================
inrate=round(inrate/24*3);
%===============================================================
plot(t,inrate,'k')
xlim([0,28]);
set(gca,'xtick',[0:28/4:28]);
set(gca,'xticklabel','');
xlabel('\tau(time steps)')

ylabel('F_{in}(\tau)');
set(gca,'yticklabel',' ')
box on
