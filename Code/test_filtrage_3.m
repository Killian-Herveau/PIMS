for i=0:100:1300
    fid = fopen(name_Z('C:\Users\Briséis\Documents\MATLAB\Projet 2A\Calibration\STACK=0001_Im=00001_Z=',i) ,'r');
    fid1 = fopen(name_Z('C:\Users\Briséis\Documents\MATLAB\Projet 2A\Mesures\STACK=0000_Im=00070_Z=',i) ,'r');
    size=fread(fid,[1,2],'*ubit32','ieee-be'); %retourne [x,y]
    img=fread(fid,size,'*float64','ieee-be'); % donne la matrice de l'image
    size=fread(fid1,[1,2],'*ubit32','ieee-be'); %retourne [x,y]
    img1=fread(fid1,size,'*float64','ieee-be'); % donne la matrice de l'image
%     lambda = minEQM(img, img1, img);
%     y =  FiltreWiener (img, img1, lambda);
%     moy=0;
%     for j=1:120
%         for k=1:120
%             moy = moy+y(j,k);
%         end
%     end
%     moy = moy/(120*120);

%     figure;
%     colormap (jet);
%     imagesc(y);
%     colorbar;
%     [cmin,cmax] = caxis;
%     caxis([-0.03,0.03])
%     title(['sortie du filtre avec lambda= ', num2str( lambda ),' et éloigné de : ', num2str(i),  ' de moyenne : ', num2str(moy)]);
%     figure;
%     imagesc(img1-y);
figure;
imshow(img1, 'DisplayRange',[min(img1(:)) max(img1(:))]);
title(['mesure éloignée de : ', num2str(i)]);
    % figure;
    % imagesc(img);
    % figure;
    % imagesc(img1);
    %imshow(image,'DisplayRange',[min(image(:)),max(image(:))]);

    fclose(fid);
end


% fid = fopen(name_Z('C:\Users\Briséis\Documents\MATLAB\Projet 2A\Calibration\STACK=0001_Im=00001_Z=',700) ,'r');
% fid1 = fopen(name_Z('C:\Users\Briséis\Documents\MATLAB\Projet 2A\Mesures\STACK=0000_Im=00001_Z=',700) ,'r');
% size=fread(fid,[1,2],'*ubit32','ieee-be'); %retourne [x,y]
% img=fread(fid,size,'*float64','ieee-be'); % donne la matrice de l'image
% size=fread(fid1,[1,2],'*ubit32','ieee-be'); %retourne [x,y]
% img1=fread(fid1,size,'*float64','ieee-be'); % donne la matrice de l'image
% lambda = minEQM(img, img1, img);
% y =  FiltreWiener (img, img1, lambda);
% moy=0;
% for j=1:120
%     for k=1:120
%         moy = moy+y(j,k);
%     end
% end
% moy = moy/(120*120);
% figure;
% imagesc(y);
% colorbar;
% [cmin,camx] = caxis;
% caxis([-0.03,0.03])
% title(['sortie du filtre avec lambda= ', num2str( lambda ), ' de moyenne : ', num2str(moy)]);
% figure;
% imagesc(img1-y);
% % figure;
% % imagesc(img);
% % figure;
% % imagesc(img1);
% %imshow(image,'DisplayRange',[min(image(:)),max(image(:))]);
% 
% fclose(fid);