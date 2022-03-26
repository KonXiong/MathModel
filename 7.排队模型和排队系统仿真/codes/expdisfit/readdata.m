function secs = readdata(file)
% READDATE read time/times data from specified　file
% fmt = time/times

fid = fopen(file,'r');
tline = fgetl(fid);
secs = [];
while ischar(tline)
    tline = fgetl(fid);
    if ~ischar(tline)||strcmp(tline(1),'%'); continue; end
    sec = time2sec(tline);
    secs = [secs; sec];
end
fclose(fid);

% -------------------------------------------------------------------------

function sec = time2sec(s)
% TIME2SEC converts time string to seconds number
% time string format: 'mm:ss' or 'mm:ss.0'
if strcmp(s,'break'); sec = NaN; return; end
data = regexp(s, ':', 'split');
[mm,ss] = data{:};
sec = str2num(mm)*60 + str2num(ss);
