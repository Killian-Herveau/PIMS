% cal1=bin2mat('D:\FarView\Projet 2A\Calibration\STACK=0001_IM=00001_Z=000700.2Ddbl');
% cal1=masque_rephase(cal1)
% imshowf(fftshift(fft2(cal1)))
% 

im=imdata2('2A',80);
imshow2(abs(im))
