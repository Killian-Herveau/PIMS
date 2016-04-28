cal1=bin2mat('D:\FarView\Projet 2A\Calibration\STACK=0001_IM=00001_Z=000700.2Ddbl');
cal1=masque_rephase(cal1)
a=50;
b=71;

subplot(2,3,1)
imshow2(cal1(a:b,a:b))
title('image initiale')

hg=hgauss

