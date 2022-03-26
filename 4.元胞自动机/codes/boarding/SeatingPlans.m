function [plane, numseat, layout] = SeatingPlans(type)
%
% SeatingPlans    Generate seating plan
%
% USAGE: [plane, numseat, layout] = SeatingPlans(type)
%        type = plane type;('Fokker-50','Boeing-737-400','Boeing-777-200')
%
% If type = 'Fokker-50', then
% plane = [       1  2    0    -1 -1 
%                 3  4    0     5  6
%                    . . . . . . 
%                47 48    0    49 50
%                51 52    0    53 54]
%
% layout.seat = [1  2          4  5 ]
% layout.aisle= [         3         ]
% numseat = 54
%
% zhou lvwen: zhou.lv.wen@gmail.com

switch type
    case 'Fokker-50'
        plan = [1:2 -1 -1 3:54];
        plan = reshape(plan,4,14)';
        layout.seat = [1:2 4:5];
        layout.aisle = 3;
    case 'Boeing-737-400'
        plan = [-1 -1 -1 1:153];
        plan = reshape(plan,6,26)';
        layout.seat = [1:3 5:7];
        layout.aisle = 4;
    case 'Boeing-777-200'
        plan1 = [-ones(6,1) reshape(1:42,7,6)' -ones(6,1)];
        plan2 = reshape(43:213,9,19)';
        plan3 = reshape([-1 -1 -1 214:216 -1 -1 -1 217:333 -1 334:340 -1],9,15)';
        plan =[plan1;plan2;plan3];
        layout.seat = [1:3 5:7 9:11];
        layout.aisle = [4 8];
end

plane(:,layout.seat) = plan;
numseat = max(max(plan));
