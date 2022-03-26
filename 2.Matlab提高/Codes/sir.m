function [t,y] = sir(tspan, y0)
if nargin ==0;
    beta = 0.01;
    gamma = 0.1;
    tspan = [0, 50];
    y0 = [99 1 0];
end
[t y] = ode45(@odesir,tspan,y0,[],beta,gamma);
plot(t, y)
xlabel('time')
ylabel('percent of the population')
legend('S', 'I', 'R')

% -------------------------------------------------------------------------

function dy = odesir(t, y, beta, gamma)
dy = [ -beta*y(1)*y(2);
        beta*y(1)*y(2) - gamma*y(2);
                         gamma*y(2)];