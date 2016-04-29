cal1=bin2mat('D:\FarView\Projet 2A\Calibration\STACK=0001_IM=00001_Z=000700.2Ddbl');
cal1=masque_rephase(cal1);
a=50;
b=71;

subplot(2,3,1)
imshow2(cal1(a:b,a:b))
title('image initiale')

subplot(2,3,2)
hg=hgaussp([120,120],[61,61],1,13,0,10);
hg2=hgaussp([120,120],[61,61],1,2.2,0,10);
cal2=cal1.*(hg-hg2);
imshow2(cal2(a:b,a:b))
title('Selection "donuts"')

subplot(2,3,3)
% cal3=removegauss(cal1);
cal3=max(0,cal1-hgaussp([120,120],[61,61],max(max(cal1)),0.8,0,1));
imshow2(cal3(a:b,a:b))
title('Soustraction gaussienne')