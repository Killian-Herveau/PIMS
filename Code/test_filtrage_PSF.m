fid = fopen('..\..\Projet 2A\Calibration\STACK=0001_IM=00001_Z=000300.2Ddbl','r');
fid1 = fopen('..\..\Projet 2A\Mesures\STACK=0000_IM=00197_Z=000700.2Ddbl','r');
size=fread(fid,[1,2],'*ubit32','ieee-be'); %retourne [x,y]
img=fread(fid,size,'*float64','ieee-be'); % donne la matrice de l'image
img1=fread(fid1,size,'*float64','ieee-be');
img1 = masque_rephase(img1);
img = masque_rephase(img);
p = find_the_gauss(img1);
y =  FiltreWiener ( hgaussp([120, 120], [61,61],p(2), p(5), p(1), 1), img1, 1);      % on applique le filtre à l'image avec une psf
y = fftshift(y);
figure;
imshow2(y);
title('Image de calibration filtrée par Wiener');
%imshow(image,'DisplayRange',[min(image(:)),max(image(:))]);
fclose(fid);