% img=bin2mat('D:\FarView\Exs interferogrammes\0000122.2Ddbl');
% img=removefilter2(img);
% imshow2(abs(img(200:400,200:400)))
% 
% title('image type')
cal1=bin2mat('D:\FarView\Projet 2A\Calibration\STACK=0001_IM=00001_Z=000700.2Ddbl');
% cal=double(imread('C:\Users\ADRIEN\Documents\Images\rickMorty\roue.jpg'));
% cal=cal(1:120,1:120,3);
% 
% cal2=((masque_rephase(cal)));
% subplot(1,2,1)
% imshow2(cal(a:b,a:b))
% subplot(1,2,2)
% imshow2(cal2(a:b,a:b))

% cal1=imdata(0,700);
subplot(2,2,1)
hcal=histodeg2(cal1,0.01,5,61,61,20,120);
title('Histogramme selon x')
subplot(2,2,3)
plot(1:120,hcal)
xlabel('position pixel')
ylabel('valeur pixel')
title('Histogramme selon x')

subplot(2,2,2)
hcal2=histodeg2(cal1,89.9,5,61,61,20,120);
title('Histogramme selon y')
subplot(2,2,4)
plot(1:120,hcal2)
xlabel('position pixel')
ylabel('valeur pixel')
title('Histogramme selon y')

% cal1=bin2mat('D:\FarView\Projet 2A\Calibration\STACK=0001_IM=00001_Z=000300.2Ddbl');
% cal2=bin2mat('D:\FarView\Projet 2A\Calibration\STACK=0000_IM=00001_Z=000700.2Ddbl');
% cal3=bin2mat('D:\FarView\Projet 2A\Calibration\STACK=0000_IM=00001_Z=000900.2Ddbl');
% cal4=bin2mat('D:\FarView\Projet 2A\Calibration\STACK=0000_IM=00001_Z=0001200.2Ddbl');
a=50;
b=70;


% mes=bin2mat('D:\FarView\Projet 2A\Mesures\STACK=0000_IM=00001_Z=000700.2Ddbl');
% % mes=abs(masque_rephase(mes));
% a=41;
% b=80;
% 
% subplot(1,2,1)
% 
% % mes=masque_rephase(mes);
% imshow2((hg3))
% 
% title('hypergaussienne ''donuts''')
% 
% % 
% % hist=histodeg2(mes,11.2,10,61,61,10,240);
% % subplot(2,2,3)
% % plot(hist)
% % title('histo mes ')
% % % subplot(1,2,2)
% % % imshow2(log(1+mes2))
% % % 
% % % subplot(1,2,1)
% % % imshow2(mes(a:b,a:b))
% % 
% % % mes=log(1+log(2+mes))
% % % mes=medfilt2(mes);
% mes2=mes.*(hg3);
% subplot(1,2,2)
% imshow2((mes2(a:b,a:b)))
% title('mesure.* hypergaussienne2')

% hist2=histodeg2(mes,11.2,10,61,61,10,240);
% title('mesure a 700nm, contrastee')
% subplot(2,2,4)
% plot(hist2)
% title('moy a 700nm, contrastee')
% mes2=imdata2(1,700,5);
% cal=imdata(0,700);

% % 
% % % img=bin2mat('D:\FarView\Exs interferogrammes\0000122.2Ddbl');
% % imshow2(cal(45:76,45:76))
% % % imshow2(mes(45:76,45:76))
% % 
% % title('Calibration à z=700nm')
% % xlabel('position x')
% % ylabel('position y')
% 
