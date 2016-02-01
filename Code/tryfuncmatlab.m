img7878=bin2mat('Projet 2A\Mesures\STACK=0000_IM=00070_Z=000700.2Ddbl');
img=bin2mat('Projet 2A\Calibration\STACK=0001_IM=00001_Z=000700.2Ddbl');
[x,y]=size(img);
% figure;imshow2(img);title('img de base');
img=masque_rephase(img);
% img=img.*(1-hgaussp([x,y],[61,61],1,0.5,0,15));
figure;imshow2(img);title('img traitée');
 t=abs(fftshift(fft(moydeg(img,alpha,4,61,61))));
 
 plot(t);
D = bwdist(~t);
figure
plot(D);
title('Distance transform of ~img')
D = -D;
D(~t) = -Inf;
L = watershed(D);
figure;plot(L);