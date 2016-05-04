function [ imgout] = removefilter2(imgin,bplot)
%Notes:
%On utilise fft et non fft2 -> probleme ?

%Wiener pourrait marcher...

% Ote d'une image la tâche periodique issu de la lumiere de fond passant
% par le reseau.
% On passe par Fourier et enleve les pics voulus grâce à une multiplication par
% (1 - hypergaussienne)
%Pour l'instant on enleve toujours les même fréquences (pics), mais elles
%pourraient dependre du reglage et doivent etre localises avec moyhor et
%un seuillage/ recherche d'extrema.

%Entrees:
%   imgin: Cela va peut etre vous surprendre mais img signifie 'image'
%   et in "d'entrée"
% bplot: mettre 1 si vous souhaitez visualiser ce qui se passe
%Sortie:
%   imgout : Accrochez vous, c'est l'image de sortie une fois la tache du
%   reseau otee.

%Parametres:
%L'utilisateur peut choisir les fréquences lui même ou laisser le programme
%trouver les pics, Pour la recherche de pic le programme pourra aussi se débarasser des pics proches
%du centre selon plusieurs méthodes, car c'est là que le bruit prédomine.
%Mettez une variance élevée pour enlever les pics de façon plus
%conséquente.


% nitermax=100; %iterations max pour le while (do_not_search_freq = 0)


do_not_search_freq=1; %mettre 1 pour un choix predeterminé des fréquences à enlever (sans passer par leur recherche)
npicmax=14;  %4ordresup+ 8*ordre1 + 1*pic central / %correspond au nombre de pics à enlever
emoy=20; %epaisseur utilisee pour la moyenne horizontale
k=6; %puissance des hypergaussiennes (plus k est élevée, plus le filtre ressemble à un rectangle)
%doit etre paire ?

%Si do_not_search_freq=1:
    s=4; %ecart type des hyperg
    my_f=1; %1 => Rentrez vos fréquences vous même dans F:
    if(my_f) F=[54 107 161 214 268 321];  %le programme supprime les pics à +f et -f, et ignore npicmax
    %si my_f=0 : le logiciel prend les frequences de façon linéaire, il
        %faut que npicmax soit pair.
        deltaf=53.5;  %ecart supposé entre les fréquences
        offsetf=0; %(pas encore pris en compte dans le programme)

%Si do_not_search_freq=0:

  %Si vous voulez ignorer les frequences proches de 0:

    %Choix 1: application d'une hypergaussienne annulant les valeurs vers 0:
     ignore=0;   %Booléen: choisir ou non d'ignorer les frequences trop proche de 0
     signore=1.5; %ecart type de l'hypergaussienne servant a ignorer les frequences inferieures à '30' ou autre (pour la detection des pics)
    
     %Choix 2: Recherche d'un trop de fréquences puis on enleve ce qui est sous
    %'throwunder'. On active le choix 2 si throwunder!=0
     throwunder=0;    %On ne garde pas les fréquences sous cette valeur
     reachnpicmax=1;  %Voulez vous atteindre un nombre exact npicmax de frequences ? (le programme va alors augmenter throwunder)

     
     %On peut choisir 1 ET 2

  %Si vous n'ignorez pas les frequences proches de 0, le programme risque de trouver
  %des extremums locaux peu pertinents.
    

if (~exist('imgin','var'));
imgin=bin2mat('D:\FarView\Exs interferogrammes\0000122.2Ddbl');
'Removefilter: Utilisation de limage par defaut 0000122.2Ddbl'
end
if (exist('bplot','var'))
    bplot=1-(bplot==0);
else
    bplot=0;
end
[x,y]=size(imgin);

%on va enlever les grilles du reseau dues au fond: passement par fourier et
%application d'une hypergaussienne verticale

                                    if(bplot)
                                        subplot(2,2,1)
                                        imshow2(imgin);
                                        title('image originale');
                                    end
imgf=fft(imgin);


% La moyenne nous indique les pic de frequence
%on supr la frequence a -268 et 268 par exemple

%Utilsation des frequences de l'user dans F, ou creation:
if(do_not_search_freq)
    %Frequence indiquees par l'user
    
    if(my_f==0) %le programme doit chercher les fréquences de façon linéaire
        F=zeros(npicmax/2,1);
        for(i=1:npicmax/2)
            F(i,1)=offsetf+i*deltaf;
        end
    end 
    %Ici, on a les frequences des pics qu'il faut enlever, dans F, donnes
    %par l'user
    
else
    %Recherche auto des pics
    if(ignore)  %On enleve le pic central en 0 grace a une hypergaussienne
            Hyperg=zeros(x,y);
            for i=1:y
                for j=1:x
                    Hyperg(i,j)=1*exp(-(((i-x/2)^2)/(2*signore^(2*k))) );
                end
            end
%             Hyperg=hgaussp([x,y],[0,0],1,signore,0,5);    %pour fft2
            img2=fftshift(fftshift(imgf).*(1-Hyperg));    %on laisse l'image de mesure intacte
            %Est ce plus rapide de creer l'hyperg en haut et bas au lieu de
            %fftshift ?
            
        moy=moyhor((log(abs(img2)+1)),emoy);  %coupe de l'image sans le pic en 0
    else
        moy=moyhor(log(abs(imgf)+1),emoy);   %coupe de l'image avec le pic en zero
    end
                                    if(bplot)
                                        subplot(2,2,2);
                                        plot(moy)
                                        title('moy');
                                    end

    %on a maintenant 'moy' qui contient les pics interessants  
    t=1:length(moy);
%         smoy=smooth(moy,10); %leger smooth
    [ymax2,imax2,ymin2,imin2] = extrema(moy);  %renvoit les amplitude et les coords des extremas
    ytri=sort(ymax2);
    ly=length(ytri);    %=length(ymax2) %nombre de pics detectes

    if(ly-npicmax<=0)
        'Erreur removefilter: pas assez de maximums detectes'
        iout=NaN;
        yout=NaN;
    else
        if(throwunder)
            if(reachnpicmax)    %on fait varier throwunder pour obtenir npicmax frequences
                %on suppose que les pics sont symetriques, et donc en
                %nombre pair (pê faux...)
                imaxsort=sort(imax2);
                throwunder=(length(imaxsort)-npicmax)/2;
            end
            imax2=imax2( (imax2>throwunder)&(imax2<x-throwunder) );
        else
            iout=imax2(moy(imax2)>=ytri(ly-npicmax+1)); %on ne garde que le bon nombre de pics
        end
        
        
        
        F=iout;
        if(bplot)
            subplot(2,2,2);
            plot(moy)
            title('moy et detection frequences');
            hold on
            % plot(t(imax2),ymax2,'r*',t(imin2),ymin2,'g*')

            plot(t(iout),moy(iout),'r*')
            hold off
        end
    end
    %Ici on a les frequences des pics qu'il faut enlever, trouvee par le programme   
end
%Ici, on a les frequences des pics qu'il faut enlever, dans F
lf=length(F);
Gtot=zeros(x,y,2*lf); %va contenir les hypergaussiennes
% Gtot2=zeros(x,y);
%Creation des hypergaussiennes 'inversees' :
    for(ng=2:2:2*lf) 
        for i=1:y
                for j=1:x
%      Gtot2(i,j)=Gtot2(i,j)+2-exp(-(((i-F(ng/2))^2)^k/(2*s^(2*k))) )-exp(-(((i-(x-F(ng/2)))^2)^k/(2*s^(2*k))));
       Gtot(i,j,ng-1)=1-exp(-(((i-F(ng/2))^2)^k/(2*s^(2*k))) );
       Gtot(i,j,ng)=1-exp(-(((i-(x-F(ng/2)))^2)^k/(2*s^(2*k)))); 
                end
        end
    end
%     for(g=2:length(Gtot(1,1,:)))
%         Gtotsum2=Gtotsum2+Gtot(:,:,i);
%     end
    Gtotsum=sum(Gtot,3);
    maxg=max(max(Gtotsum));ming=min(min(Gtotsum));
    Gtotsum=(Gtotsum-ming)/(maxg-ming);
imgf=(imgf.*Gtotsum);   %TF sans les pics 
imgout=((ifft(imgf)));
F
                                if(bplot)
                                    subplot(2,2,3)
                                    title('les filtres');
                                    imshow2(Gtotsum)
                                end

                                if(bplot)
                                    
                                    subplot(2,2,4);                           
                                    moy=moyhor(log(abs(imgf)+1),emoy);
                                    plot(moy);
                                    title('moy apres filtrage');
                                end


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