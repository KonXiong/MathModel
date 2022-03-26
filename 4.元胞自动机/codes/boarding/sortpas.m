function num = sortpas(numseat,plan,layout,type)
%
% sortpas     sort passenger queue. Various strategies for boarding were
% tested by changing the order in which passengers entered the plane.
%
% USAGE:  num = sortpas(numseat,plan,layout,type)
%        numseat = number of seats
%        plan = seating plan 
%        layout =  layout of the plane
%        type = boarding strategy type
%
% zhou lvwen: zhou.lv.wen@gmail.com

[r, c] = size(plan);
[x, y] = meshgrid(1:c,1:r);
distback = zeros(r,c);
distaisle = zeros(r,c);

for i = 1:r
    for j = 1:c
        distback(i,j) = abs(y(i,j)-y(r,j))+1;
        distaisle(i,j) = min(abs(x(i,j) - layout.aisle));
    end
end
distback =  ceil(distback /(max(max( distback))/3));
distaisle = round(distaisle/(max(max(distaisle))/2));
distback(plan<=0)=0;
distaisle(plan<=0)=0;

maxi = max(max(distback));
maxj = max(max(distaisle));

num = [];

switch type
    case 'random'
        num = randperm(numseat);
        
    case 'back_to_front'
        for i = 1:maxi
            numi = plan(distback==i);
            numi = numi(randperm(length(numi))); 
            num = [num;numi];
        end
        
    case 'front_to_back'
        for i = maxi:-1:1
            numi = plan(distback==i);
            numi = numi(randperm(length(numi))); 
            num = [num;numi];
        end
        
    case 'window_first'
        for j = maxj:-1:1
            numi = plan(distaisle==j);
            numi = numi(randperm(length(numi))); 
            num = [num;numi];
        end
        
    case 'reverse_pyramid'
        for j = maxj:-1:1
            for i = 1:maxi
                numi = plan(distback==i&distaisle==j);
                numi = numi(randperm(length(numi))); 
                num = [num;numi];
            end
        end
        
    case 'block'
        for i = 1:maxi
            for j = maxj:-1:1
                numi = plan(distback==i&distaisle==j);
                numi = numi(randperm(length(numi))); 
                num = [num;numi];
            end
        end
end
