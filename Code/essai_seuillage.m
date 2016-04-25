%img1 = bin2mat('..\..\Projet 2A\Calibration\STACK=0001_IM=00001_Z=000700.2Ddbl');
%img1 = masque_rephase(img1);
% im=zeros(120,120);
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
img1 = bin2mat('..\..\Projet 2A\Mesures\STACK=0000_IM=00065_Z=000400.2Ddbl');
% figure;
% imshow2(img1);
%size(img1)
im = zeros(120, 120);
% [centre pos] = max(img1(:));
% [x y] = ind2sub(size(img1), pos);
% for i=x-0:x+0
%     for j = y-0:y+0
%         img1(i,j) = 0;
%     end
% end
im2 = masque_rephase2(img1);
im = masque_rephase(img1);
figure;
imshow2(im);
% [centre pos] = max(img1(:));
% [x y] = ind2sub(size(img1), pos);
% for i=x-2:x+2
%     for j = y-2:y+2
%         im(i,j) = 0;
%     end
% end
% [centre pos] = max(img1(:));
% [x y] = ind2sub(size(img1), pos);
% for i=x-2:x+2
%     for j = y-1:y+1
%         img1(i,j) = 0;
%         %im(i,j) = 0;
%     end
% end
% [centre2 pos2] = max(im(:));
% [x2 y2] = ind2sub(size(im), pos2);
% % for i = x2-2:x2+2
% %     for j = y2-2:y2+2
% %         img1(i,j) = img1(x2,y2);
% %         im(i,j) = im(x2,y2);
% %     end
% % end
% img1(x,y) = img1(x2,y2);
% %im(x,y) = im(x2,y2);

% [x,y] = meshgrid(img1);
% x = x(:);
% y = y(:);

% fo = fitoptions('Method', 'NonLinearLeastSquares','Lower', [0,0],'Upper',[Inf,max(im)],'StartPoint',[1 1]);
% ft = fittype('a+exp((x-b)^2+(y-c)^2)/((2*d)^2)', 'options', fo)
% [curve2, gof2] = fit(im, z, ft)

% On remplace le pixel central par la moyenne des pixels
        % l'entourant
        moyenne = 0;
        for i=-1:1
            for j=-1:1
                moyenne = moyenne + img1(61+i,61+j);
            end
        end
        moyenne = (moyenne-img1(61,61))/8;
        img1(61,61) = moyenne;

poids = ones(1,120*120);
for i=60:61
    poids(1,i) = 0.05;

end

p = fit_gauss2D(im2,poids);
%p = fit_gauss2D(im2);
im_seuil = zeros(120, 120);
% [centre pos] = max(im(:));
% [x y] = ind2sub(size(im), pos);
% for i=x-2:x+2
%     for j = y-2:y+2
%         im(i,j) = 0;
%     end
% end
comparaison = hgaussp(size(img1), [p(3), p(4)], p(2), p(5), p(1), 1);

% Utilisation de extrema :
% a=mean(img1);
% plot(a)
% 
% t=1:120;
% 
% y2 = smooth(a,20);
% figure
% plot(t,y2)
% [ymax2,imax2,ymin2,imin2] = extrema(y2);
% hold on
% plot(t(imax2),ymax2,'r*',t(imin2),ymin2,'g*')
% hold off


figure;
imshow2(comparaison);

for i=1:120
    for j=1:120
        if im(i,j)>comparaison(i,j)
            im_seuil(i,j) = 1;
        else 
            im_seuil(i,j) = 0;
        end
    end
end


im_seuil = bwmorph(im_seuil, 'remove', Inf);
figure; 
imshow(im_seuil,'InitialMagnification','fit');
title('seuillage adap fit-gauss2D');

%Bw = edge(im_seuil, 'canny', [0.1 0.5],3);
%figure;
%imagesc(Bw);
[L,num] = bwlabel(im_seuil,8);

barycentre = zeros(2,num);
for ii=1:num
    
    im_seuil=(L==ii);
    [y,x] = find(im_seuil);
    barycentre(1,ii) = mean(x);
    barycentre(2,ii) = mean(y);
end;
figure(1);
line(barycentre(1,:), barycentre(2,:), 'LineStyle', 'none', 'Marker', '+', 'color', [1 0 0]);

for ii=1:num-1
    d(ii) = pdist([barycentre(1,ii),barycentre(2,ii);barycentre(1,ii+1), barycentre(2,ii+1)], 'euclidean');
    d(ii)
end;
% %% seuillage adaptatif avec fit polynomial -> il est pas très adapté!
% im = zeros(120,120);s
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