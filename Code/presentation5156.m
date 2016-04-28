img1 = bin2mat('..\..\Projet 2A\Calibration\STACK=0001_IM=00001_Z=000300.2Ddbl');
figure;
imshow2(img1(40:80, 40:80));
title('Image de calibration');

img1=fftshift(fft2(img1));
figure;
imshow2(log(abs(1+img1)));
title('Transformée de Fourier de l''image');