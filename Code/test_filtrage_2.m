img = bin2mat('C:\Users\Briséis\Documents\MATLAB\Projet 2A\Calibration\STACK=0001_IM=00001_Z=000100.2Ddbl');
img1 = bin2mat('C:\Users\Briséis\Documents\MATLAB\Projet 2A\Mesures\STACK=0000_IM=00001_Z=000100.2Ddbl');
% size=fread(fid,[1,2],'*ubit32','ieee-be'); %retourne [x,y]
% img=fread(fid,size,'*float64','ieee-be'); % donne la matrice de l'image
% size=fread(fid1,[1,2],'*ubit32','ieee-be'); %retourne [x,y]
% img1=fread(fid1,size,'*float64','ieee-be'); % donne la matrice de l'image
lambda = minEQM(img, img1, img);
y =  FiltreWiener (img, img1, lambda);
figure;
imagesc(y);
title(['sortie du filtre avec lambda= ', num2str( lambda )]);
figure;
imagesc(img);
figure;
imagesc(img1);
%imshow(image,'DisplayRange',[min(image(:)),max(image(:))]);

fclose(fid);