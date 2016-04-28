cal1=bin2mat('D:\FarView\Projet 2A\Calibration\STACK=0001_IM=00001_Z=000700.2Ddbl');
cal1=masque_rephase(cal1)
a=50;
b=71;

subplot(2,3,1)
imshow2(cal1(a:b,a:b))
title('image initiale')

subplot(2,3,2)
hg=hgaussp([120,120],[61,61],1,28,0,10);
hg2=hgaussp([120,120],[61,61],1,10,0,10);
imshow2(hg-hg2)
title('donuts hypergaussien')

