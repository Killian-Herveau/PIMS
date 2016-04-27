% img=bin2mat('D:\FarView\Exs interferogrammes\0000122.2Ddbl');
% img=removefilter2(img);
% imshow2(abs(img(200:400,200:400)))
% 
% title('image type')
% cal=bin2mat('D:\FarView\Projet 2A\Calibration\STACK=0001_IM=00001_Z=000700.2Ddbl');
% cal=double(imread('C:\Users\ADRIEN\Documents\Images\rickMorty\roue.jpg'));
% cal=cal(1:120,1:120,3);
% 
% cal2=((masque_rephase(cal)));
% subplot(1,2,1)
% imshow2(cal(a:b,a:b))
% subplot(1,2,2)
% imshow2(cal2(a:b,a:b))
% 
% 
% 
mes=bin2mat('D:\FarView\Projet 2A\Mesures\STACK=0000_IM=00001_Z=000700.2Ddbl');
% mes2=masque_rephase(mes);
a=41;
b=80;

subplot(1,2,1)
imshow2(log(1+mes(a:b,a:b)))
title('mesure a 700nm')
% subplot(1,2,2)
% imshow2(log(1+mes2))
% 
% subplot(1,2,1)
% imshow2(mes(a:b,a:b))
title('mesure a 700nm')
subplot(1,2,2)
imshow2(mes(a:b,a:b))
% mes2=imdata2(1,700,5);
% cal=imdata(0,700);
title('mesure a 700nm, contrastee')
% % 
% % % img=bin2mat('D:\FarView\Exs interferogrammes\0000122.2Ddbl');
% % imshow2(cal(45:76,45:76))
% % % imshow2(mes(45:76,45:76))
% % 
% % title('Calibration à z=700nm')
% % xlabel('position x')
% % ylabel('position y')
% 
