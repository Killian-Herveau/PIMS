function [ imgout] = removefilter(img,bplot)
%On utilise fft2 pour l'instant, Dans ce removefilter on essaye fft2
%... mais du coup faut des gaussiennes pour enlever les trucs
%trouver automatiquement les pics à enlever pour le réseau.

% Ote d'une image la tâche periodique issu de la lumiere de fond passant
% par le reseau.
% On passe par Fourier et enleve les pics voulus grâce à une multiplication par
% une hypergaussienne
%Pour l'instant on enleve toujours les même fréquences (pics), mais elle
%spourraient dependre du reglage et doivent etre localises avec moyhor et
%un seuillage/ recherche d'extrema.

%Entrees:
%   img: Cela va peut etre vous surprendre mais img signifie 'image'
% bplot: mettre 1 si vous souhaitez visualiser un minimum  ce qui se passe
%Sortie:
%   imgout : Accrochez vous, c'est l'image de sortie une fois la tache du
%   reseau otee.
if (~exist('img','var'));
img=bin2mat('D:\FarView\Exs interferogrammes\0000122.2Ddbl');
'Removefilter: Utilisation de limage par defaut 0000122.2Ddbl'
end
if (exist('bplot','var'))
    bplot=1-(bplot==0);
else
    bplot=0;
end
    [x,y]=size(img);
%on va enlever les grilles du reseau dues au fond: passement par fourier et
%application d'une hypergaussienne verticale

if(bplot)
    figure
    subplot(2,2,1)
    imshow2(img);
    title('image originale');
end
img=fft2(img);

moy=moyhor(abs(img),x/2);
if(bplot)
    subplot(2,2,2);
%     plot(smooth(moy,15))
    imshowf(fftshift(img),1);
    
    
    title('moy');
end
% La moyenne nous indique les pic de frequence:
%on supr la frequence a -268 et 268.

    G=zeros(x,y);
    G2=G;
    G3=G;
    G4=G;
    G5=G;
    G6=G;
    G7=G;
    G8=G;
%     offset=min(min(img));
    s=1.15; %variance....
    k=10; %puissance de l'hypergaussienne
    %creation d'une gaussienne etalee verticalement
    for i=1:y
        for j=1:x
            %enlever la partie en j et l'offset?
%             G(i,j)=offset+a*exp(-(((i-268)^2)/(2*s^(2*k))) -(((j-10)^2)/(s*100)^(2*k)));
            G(i,j)=1*exp(-(((i-268)^2)/(2*s^(2*k))) );
            G2(i,j)=1*exp(-(((i-(x-268))^2)/(2*s^(2*k))));
            
            G3(i,j)=1*exp(-(((i-54)^2)/(2*s^(2*k))));
            G4(i,j)=1*exp(-(((i-(x-54))^2)/(2*s^(2*k))));
            
            G5(i,j)=1*exp(-(((i-108)^2)/(2*s^(2*k))));
            G6(i,j)=1*exp(-(((i-(x-108))^2)/(2*s^(2*k))));
            
            G7(i,j)=1*exp(-(((i-161)^2)/(2*s^(2*k))));
            G8(i,j)=1*exp(-(((i-(x-161))^2)/(2*s^(2*k))));
        end
    end
    if(bplot)
        subplot(2,2,3)
        title('les filtres');
        imshow2(G2+G+G3+G4+G5+G6+G7+G8);
    end
%     imshow2(1-G);
    img=img.*(1-G).*(1-G2).*(1-G3).*(1-G4).*(1-G5).*(1-G6).*(1-G7).*(1-G8);
    
% if(bplot)
%     subplot(2,2,4);
%     moy=moyhor(abs(img),x/2);
% %     plot(moy);
%     
%     title('moy');
% end
imgout=((ifft2(img)));

if(bplot)
subplot(2,2,4);
imshow2(real(imgout));
title('Image finale');
end


end


% [moy,pos]=moydeg_pos(img1,11.2,10,40,60,0.5,0.5,1);
% img=zeros(120*3,120*3);

% %affichage de pos:
% 
% for(i=1:length(pos))
%     for(j=1:length(img))
%         if(pos(i,1)~=0) img(pos(i,1),j)= (pos(i,2)==j);
%         end
%     end
% end 
    
% 
% figure
% 
% 
% d=[100,120];
% 
% img2=hgaussp(d,[35,30],5,5,1,1)+hgaussp(d,[80,70],3,6,0.5,1);
% imshow2(img2);
% figure
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