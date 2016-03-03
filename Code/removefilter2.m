function [ imgout] = removefilter2(img,bplot)
%On utilise fft pour l'instant, modif a faire:
%utiliser fft2
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
nitermax=100; %iterations max pour le while (auto = 0)
npicmax=9;  %8 + pic central
auto=0; %mettre 1 pour un choix automatique des fréquences à enlever (sans passer par leur recherche)


if (~exist('img','var'));
img=bin2mat('D:\FarView\Exs interferogrammes\0000122.2Ddbl');
'Removefilter: Utilisation de limage par defaut 0000122.2Ddbl'
end
if (exist('bplot','var'))
    bplot=1-(bplot==0);
else
    bplot=0;
end

%on va enlever les grilles du reseau dues au fond: passement par fourier et
%application d'une hypergaussienne verticale

if(bplot)
    figure
    subplot(2,2,1)
    imshow2(img);
    title('image originale');
end
img=fft(img);

moy=moyhor(abs(img),5);
if(bplot)
    subplot(2,2,2);
    plot(moy)
    title('moy');
end
% La moyenne nous indique les pic de frequence:
%on supr la frequence a -268 et 268 par exemple (si auto=1)
    [x,y]=size(img);
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
    if(auto)    %on la cree a des frequences deja definies
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
    
    else %auto=0,  detection  des pics par le programme, normalement il y en a 8.
        
        %PREMIERE IDEE - MISE DE COTE:
            %on smooth jusqu'a n'en détecter que 8 ? pb que extrema va a
            %coté...
%             sm=1;
%         niter=0;
%         npics=npicmax+1;
%             while((npics>npicmax)&(niter<nitermax))
%                 smoy = smooth(moy,sm);
%                 [ymax2,imax2,ymin2,imin2] = extrema(smoy);
%                 sm=sm+200
%                 niter=niter+1;
%                 npics=length(imax2)
%             end
        %ici npics vaut 8 ou 7 ou 6... mais sous 8 quoi !
        %FIN.
            
        %DEUXIEME IDEE:
            %On smooth legerement et on choisit un seuil
            %adapte pour garder 8 points.
            
            %on va augmenter le seuil peu à peu jusqu'à garder 8 points ou
            %moins:
            moy=medfilt1(moy); %revient a smooth ?
            seuil=mean(moy);
        t=1:length(moy);
        smoy=smooth(moy,10); %leger smooth
        niter=1;%on realise en fait nitermax-1 iterations car on part de 1
        npics=npicmax+1;
        [ymax2,imax2,ymin2,imin2] = extrema(smoy);
        ytri=sort(ymax2);
        pas=5;  %combien d'extremums sautent-on 
        while((npics>npicmax)&(niter<nitermax))
            compte=0;
            for(pos=1:length(imax2))
                if(ytri(pos)>seuil)
                    compte=compte+1;
                end
            end
            npics=compte;
            seuil=ytri(niter*pas)+1;
            niter=niter+1;
        end
        %maintenant on atteint npicmax (on peut etre en dessous a cause du pas)
        %normalement on est pas au dessus.
        
        posi=(niter*pas-2*pas);
        pas=1;
        niter=0;
        yout=ymax2(ymax2>ytri(posi-pas))
        while((length(yout)<npicmax)&(niter<nitermax))
            yout=ymax2(ymax2>ytri(posi-pas));
            iout=imax2( smoy(imax2)>ytri(posi-pas) );
            length(yout)
            niter=niter+1;
            pas=pas+1;
        end
        %Peut tomber sur 10 au lieu de 9... pas normal...
        iout=imax2( smoy(imax2)>ytri(posi-pas+1) );
        figure
        plot(smoy)
        hold on
        size(t(iout))
        size(yout)
        plot(t(iout),yout,'r*')
        hold off
        
    end
        figure
    
    
    
    if(bplot)
        subplot(2,2,3)
        title('les filtres');
        imshow(G2+G+G3+G4+G5+G6+G7+G8);
    end
%     imshow2(1-G);
    img=img.*(1-G).*(1-G2).*(1-G3).*(1-G4).*(1-G5).*(1-G6).*(1-G7).*(1-G8);
    
if(bplot)
    subplot(2,2,4);
    moy=moyhor(abs(img),5);
    plot(moy);
    title('moy');
end
imgout=((ifft(img)));

if(bplot)
figure;
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