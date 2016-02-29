img1 = bin2mat('C:\Users\Briséis\Documents\MATLAB\Projet 2A\Calibration\STACK=0001_IM=00001_Z=000700.2Ddbl');
img1 = masque_rephase(img1);
%im=zeros(120,120);
% %% seuillage adaptatif
% im = zeros(120,120);
% for i=1:120
%     moyenne1 = moydeg(img1, -11.2, 1,i,i, 1, 1, 0);
%     moyenne2 = moydeg(img1, -78.8, 1, i, i, 1, 1, 0);
% %         figure;
% %         plot(moyenne);
%     x = [1:120];
%     p1 = fit_gauss(transpose(x), moyenne1);
%     p2 = fit_gauss(transpose(x), moyenne2);
%     
%     y1 = zeros(120,1);
%     y2 = zeros(120,1);
%     for j=1:120
%         y1(j) = p1(1) + p1(2)*exp(-(j-p1(3))^2/(2*p1(4)^2));    %c'est con ça !!
%         y2(j) = p2(1) + p2(2)*exp(-(j-p2(3))^2/(2*p2(4)^2));
%     end
%     %     figure;
%     %     plot(x,y);
%     for j=1:120
%         if img1(i,j)<y1(j)
%             if img1(i,j)<y2(j)
%                 im(i,j) = 0;
%             else 
%                 im(i,j) = 1;
%             end
%         else
%             if img1(i,j)<y2(j)
%                 im(i,j) = 1;
%             else
%                 im(i,j) = 1;
%             end
%            
%         end
%     end
%     
% end
% figure;
% imshow(im);%, 'DisplayRange',[min(im(:)) max(im(:))]);
% title('seuillage adap 1');
% %% autre seuillage adaptatif
% i=60;
% %moyenne = moydeg(img1, -11.2, 1,i,i, 1, 1, 0);
% %figure;
% %plot(moyenne);
% %title('truc');
% x = [1:120];
% y = zeros(120,1);
% im=zeros(120,120);
% for j=1:120
%     p = fit_gauss(transpose(x),img1(:,j));
%     for i=1:120
%         y(i) = p(1) + p(2)*exp(-(i-p(3))^2/(2*p(4)^2));
% 
% %figure;
% %plot(x,y);
% %title('truc2');
% 
% 
%         if img1(i,j)>=y(i)
%             im(i,j)=1;
%         end
%     end
% end
% figure;
% imshow(im, 'DisplayRange',[min(im(:)) max(im(:))]);
% title('seuillage adap 2');
% 
% %% seuillage dynamique + détection de contour
% img1(1,:)=0;
% img1(:,1)=0;
% for j=2:120
%     for i=2:120
%         DC = (img1(i,j)-img1(i-1,j))/2+(img1(i,j)-img1(i-1,j-1))/2;  % on fait la moyenne des pixels avant et après
%         %img1(i,j)
%         %-1*DC+(img1(i,j)+img1(i-1,j)+img1(i-1,j-1))/3
%         if img1(i,j)< -1*DC+(img1(i,j)+img1(i-1,j)+img1(i-1,j-1))/3
%             img1(i,j)=0;
%         else 
%             img1(i,j)=1;
%         end
%     end
% end
%     
% figure;
% imshow(img1);%, 'DisplayRange',[min(im(:)) max(im(:))]);
% title('seuillage dynamique');
% %%
% figure;
% plot(img1(60,:));
% moyenne = moydeg(img1, -11.2, 1,60,60, 1, 1, 0);
% figure;
% plot(moyenne);
% moyenne1 = moydeg(img1, 11.2, 1, 60, 60, 1, 1, 0);
% figure;
% plot(moyenne1);
%% seuillage adapatif avec fit_gauss2D
img1 = bin2mat('C:\Users\Briséis\Documents\MATLAB\Projet 2A\Calibration\STACK=0001_IM=00001_Z=000400.2Ddbl');
%size(img1)
%im = zeros(120, 120);
im = masque_rephase(img1);
p = fit_gauss2D(im);
im_seuil = zeros(120, 120);
comparaison = hgaussp(size(img1), [p(3), p(4)], p(2), p(5), p(1), 1);
for i=1:120
    for j=1:120
        if im(i,j)>=comparaison(i,j)+100
            im_seuil(i,j) = 1;
        end
    end
end

im_seuil = bwmorph(im_seuil, 'skel', Inf);
figure; 
imshow(im_seuil);
title('seuillage adap fit-gauss2D');

% %% seuillage adaptatif avec fit polynomial -> il est pas très adapté!
% im = zeros(120,120);
% x = zeros(14400,1);
% y = zeros(14400,1);
% z = zeros(14400,1);
% 
% for i=1:120
%     for j=1:120
%         x(i+120*(j-1))=i;       %on met j-1 pour ne pas commencer à x(121) ! (si j commence à 1)
%         y(i+120*(j-1))=j;
%         z(i+120*(j-1))=img1(i,j);
%     end
% end
% 
% comparaison = fit([x,y],z, 'poly45');
% for i=1:120
%     for j=1:120
%         if img1(i,j)>= comparaison(i,j)
%             im(i,j) = 1;
%         end
%     end
% end
% 
% figure;
% imshow2(im);%, 'DisplayRange',[min(im(:)) max(im(:))]);
% title('seuillage adap fit-polynome');