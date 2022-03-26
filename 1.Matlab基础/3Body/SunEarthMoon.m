function SunEarthMoon
load planets;
[sun, earth, moon] = deal(18, 3, 25);
list = [sun, earth, moon]; % 12 24
G = 6.67e-11; %gravitational constant

dt = 24*3600;
N = length(list);
mass = mass(list);
position = position(list,:);
velocity = velocity(list,:);
h = plotplanets(position);

for t = 1:365
    plotplanets(position,h);
    force = zeros(N,3);
    for i = 1 : N
        Pi = position(i,:);
        Vi = velocity(i,:);
        Mi = mass(i);
        for j = (i+1):N; %the i+1 is in to create diagonal
            Mj = mass(j);
            Pj = position(j,:);
            dr =  Pj - Pi; 
            forceij = G*Mi*Mj./(norm(dr).^3).*dr;
            force(i,:) = force(i,:) + forceij;
            force(j,:) = force(j,:) - forceij;
        end;
    end
    velocity = velocity + force./repmat(mass,1,3)*dt;
    position = position + velocity*dt;
end 

% -------------------------------------------------------------------------

function h = plotplanets(pos,h)
scale = 50;
total_planets = size(pos,1);
[sun, earth, moon] = deal(1, 2, 3);
radius = [50, 30, 20];
marker = {'.r', 'b.','m.'};
pos(moon,:) = pos(earth,:) + scale*(pos(moon,:)-pos(earth,:));
if nargin==1
    hold on; axis image
    axis( [-2 2 -2 2]*1e11 );
    for i = 1:total_planets
        if any(i == [sun, earth, moon])
            h(i) = plot(pos(i,1),pos(i,2),marker{i},'markersize',radius(i));
            plot(pos(i,1), pos(i,2), marker{i}, 'markersize',5);
        else
            h(i) = plot(pos(i,1), pos(i,2), 'k.', 'markersize', 20);
            plot(pos(i,1), pos(i,2), 'k.', 'markersize',5);
        end
    end
else
    for i = 1:total_planets
        set(h(i), 'Xdata', pos(i,1)  , 'Ydata', pos(i,2)  )
        if any(i == [sun, earth, moon])
            plot(pos(i,1), pos(i,2), marker{i}, 'markersize',5);
        else
            plot(pos(i,1), pos(i,2), 'k.', 'markersize',5);
        end
    end
    drawnow
end