fid=fopen('STACK=0001_IM=00001_Z=000700.2Ddbl','r');
size=fread(fid,[1,2],'*ubit32','ieee-be');
img1=fread(fid,[120,120],'*float64','ieee-be');
fclose(fid);