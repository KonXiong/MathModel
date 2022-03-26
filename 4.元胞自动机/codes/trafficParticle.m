function carpost=trafficParticle()
% This the main script of traffic simulation using particles. Car velocity 
% depends on density seen by driver.
% 
% zhou.lv.wen@gmail.com

[wall, xlim,tlim,carpos, vmax, tmax] = trafficase('accident');
wall = inf;

ncar = length(carpos);
carlength = .4;
dt = .1;
time = 0;
t = 0;
carpost = carpos;

% plot initial data:
density = calculatedensity(carpos, wall, carlength);
h = plots(carpos, wall, time, t, tmax, xlim, density, carpost);

for t = 0:dt:tmax
    time = [time; t];
    
    % compute density and velocity of each car:
    density = calculatedensity(carpos, wall, carlength);
    velocity = calculatevelocity(density, vmax);
    
    if t<3*tmax/5; velocity(end-20)=0; end
    
    % move each car based on velocity (forward Euler):
    carpos = carpos + velocity*dt;
    carpost = [carpost; carpos];  % array of locations to plot path
    plots(carpos, wall, time,t, tlim, xlim, density, carpost,h);
end;

% ------------------------------------------------------------------------

function h = plots(carpos, wall, time, t, tmax, xlim, density, carpost, h)
% data to draw one little car:
xcar0 = [-.2 .2 .2 .05 .05 -.05 -.05 -.2 -.2];
ycar0 = [  0  0 .1 .1  .2   .2   .1   .1   0];
ncar = length(carpos);

if nargin==8
    axes('position',[.1 .1 .8 .7]);
    for i=1:ncar
        % draw cars
        xcar = xcar0 + carpos(i);
        ycar = ycar0 ;
        h.car(i) = plot(xcar,ycar);
        hold on
        h.x(i) = plot(carpost(:,i), time-t, 'red');
    end
    
    % plot wall
    plot([wall  wall], [-tmax,2], 'r')
    axis([xlim  -tmax 2]);
    hold off
    % plot density
    axes('position',[.1 .85 .8 .1]);
    h.rho = plot(carpos, density,'.k')
    
    title(['density at time ', num2str(time)])
    axis([xlim   -.1 1.1])
else
    for i = 1:ncar
        xcar = xcar0 + carpos(i);
        set(h.car(i),'xdata',xcar);
        set(h.x(i),'xdata', carpost(:,i), 'ydata',time-t);
    end
    set(h.rho,'xdata',carpos, 'ydata',density)
end
drawnow
pause(0.01)


% ------------------------------------------------------------------------

function density = calculatedensity(carpos, wall, carlength)
% compute density and velocity of each car
%
%                      length of car
% rho/rho_max  = ---------------------------
%                  distance between cars
%
density = carlength ./ diff([carpos,wall]);

% ------------------------------------------------------------------------

function velocity = calculatevelocity(density, vmax)
% nonlinear equation if velocity depends on density:
% v = vmax (1- rho)
%

velocity = vmax * (1 - density);
velocity = max(velocity, 0);



% ------------------------------------------------------------------------

function [wall, xlim, tlim,carpos, vmax, tmax] = trafficase(casename)
% Choose an example and un-comment:

switch casename
    case 'red light'  % Example 1
        % traffic hitting wall and shock wave:
        wall = 6;
        xlim = [-10 11];
        tlim = [-16 2];
        carpos = -25:1:5;
        vmax = 1.5;
        tmax = 25
    case 'accident'
        wall = 6;
        xlim = [-10 11];
        tlim = [-16 2];
        carpos = [-34:2:0 1:0.4:10];
        vmax = 1.5;
        tmax = 20
    case 'green light'% Example 2
        % rarefaction wave when the light turns green:
        wall = 100;
        xlim = [-10 10];
        tlim = [-10 2];
        carpos = -20:.4:0;
        vmax = 1.0;
        tmax = 15;
    otherwise          % Example 3
        % local congestion giving a shock followed by rarefaction:
        % (also try this data with velocity = 1 below to see linear advection)
        wall = 100;
        %carpos = [-40:2:1 1.5:.5:2.5 3:2:12];
        carpos = [-50:2:-1 -.5:.5:2.5 3:2:32];
        %carpos = [-47:4:-3 -2.5:.5:2.5 3:4:43];
        xlim = [-20 40];
        tlim = [-50 2];
        vmax = 1.5;
        tmax = 30;
end