file = 'ArrivalTimes.dat';
tchk = readdata(file);
dt = diff(tchk);        % time to duration
[mu, muci] = expfit(dt)
    

h = histfit(dt,8,'exponential');
xlabel('time [sec]'); ylabel('Frequency');
legend(h(2),['Exponential Fit: mu = ',num2str(mu)]);
 

