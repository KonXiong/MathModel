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

