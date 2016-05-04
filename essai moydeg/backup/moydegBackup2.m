function [ moy ] = moydegBackup2(img,d,n,pasx,pasy,plot)
% Renvoie les moyennes verticales d'une image, en suivant un pas, en prenant les pixels sur un angle de d degrés (par
% rapport à la verticale) . l'angle est inférieur à 90°
%angle <0 : /===/      angle>0   \===\  
% On pondère 4 pixels par leur éloignement à la droite ideale, en dx+dy
%On pourrait peut etre raisonner avec un barycentre, a voir si le calcul
%est aussi rapide
% On parcourt l'image normalement à la droite, appliquant n autour de son centre vertical

%A FAIRE
%Check barycentre
%problemes n eleves
% taille de moyenne ? depend de la var "taille"


%ENTREES:
% img: image
% d : angle en DEGRE par rapport à la verticale (sens ). -90°<d<90°
% n: nombre de valeurs pondérées utilisées dans le calcul de chaque moyenne 
%pasx: pas de sampling des echantillons des moyennes, vaut 1 si non renseigné
%pasy: pas entre chaque colonne correspondant a une moyenne , vaut 1 si non renseigné
% plot: si plot a une valeur non nulle ou non NULL, la fonction affichera le chemin parcouru

% SORTIES/
% moy: vecteur des moyennes "verticales" suivant l'angle
    %taille: round((y-1)/pasy+0.5)

% A cause de l'angle on ne peut calculer la moyenne en chaque pixel de
% l'image, on aura un vecteur allant de 0 à une taille inférieure à y.
% (y taille horizontale)

%on regarde ce que l'utilisateur a renseigné
if (exist('plot','var'))
    plot=1-(plot==0);
else
    plot=0;
end

if (exist('pasx','var'))
else
    pasx=1;
end



if (exist('pasy','var'))
    pasy=pasy;
else
    pasy=1;
end



%calcul des paramètres
[x,y]=size(img); %x vertical et y horizontal
t=tand(d); %inverse de la pente de la droite


Valeurs=zeros(n,y); %enregistre les valeurs parcourues
moy=zeros(round((y-1)/pasy+0.5),1);      % Moy vert
% moy=zeros((y=taille-1-mod(y-1,pasy)),1);
departx=round(x/2-n/2+0.5);
moyY=1; %colonne de la moyenne


if(n<x)
    if(t>0)
        %on fait attention à ne pas sortir de l'image par le cote:
        taille1=y-round(n*t+0.5);
        %on fait attention à ne pas sortir par en dessous ou au dessus:
        taille2=round((x/2-n/2)/t);
        taille=min(taille1,taille2);
        if (taille>0)
            if (plot)  %on fait deux boucles differentes selon qu'on ai besoin de plot CHEMIN ou non
                %A part creer ou non CHEMIN les deux choix de if font la
                %même chose.
            CHEMIN=img;  % affiche le chemin parcouru (plot existe)
                for(j=1:pasy:taille) %on parcourt l'image horizontalement
                       
                    for(X=departx:pasx:departx+n) %on somme les intensités en partant du point exterieur bas
                                                    %-1 necessaire apres le
                                                    %n ?
                        %La droite aura pour équation:
                        % Y(horizontal)=X(vertical)*t+j-departx*t
                        posy=X*t+j-departx*t;
                        xp=round(X+0.5);
                        xn=xp-1;
                        yp=round(posy+0.5);
                        yn=yp-1;
                        modx=mod(X,1);
                        mody=mod(posy,1);
                        moy(moyY)=moy(moyY)+...
                        (img(xn,yp)*(modx+1-mody)+...
                        img(xp,yp)*(2-modx-mody)+...
                        img(xp,yn)*(1-modx+mody)+...
                        img(xn,yn)*(modx+mody))/4; 
                        CHEMIN(xp,yp)=150;

                    end 
                    departx=departx-t*pasy; %décalage de la droite
                    moyY=moyY+1; %on calcule la prochaine moyenne

                end 
            figure
            imshow2(CHEMIN) %Affiche le chemin parcouru pour calculer la
                %moyenne
            
            else
                for(j=1:pasy:taille) %on parcourt l'image horizontalement
                       
                    for(X=departx:pasx:departx+n) %on somme les intensités en partant du point exterieur bas
                        %La droite aura pour équation:
                        % Y(horizontal)=X(vertical)*t+j-departx*t
                        posy=X*t+j-departx*t;
                        xp=round(X+0.5);
                        xn=xp-1;
                        yp=round(posy+0.5);
                        yn=yp-1;
                        modx=mod(X,1);
                        mody=mod(posy,1);
                        moy(moyY)=moy(moyY)+...
                        (img(xn,yp)*(modx+1-mody)+...
                        img(xp,yp)*(2-modx-mody)+...
                        img(xp,yn)*(1-modx+mody)+...
                        img(xn,yn)*(modx+mody))/4; 

                    end 
                    departx=departx-t*pasy; %décalage de la droite
                    moyY=moyY+1; %on calcule la prochaine moyenne

                end 
            end
            moy=moy/(round((n-1)/pasx+0.5));
        else
            error('n ou l"angle donne est trop grand')
        end
        
            
        
    elseif t<0
        taille2=-round((x/2-n/2)/t);
        taille1=y-round(-n*t+0.5);
        taille=min(taille1,taille2)
        
        if (taille>0)
            
            if (plot)  %on fait deux boucles differentes selon qu'on ai besoin de plot CHEMIN ou non
                %A part creer ou non CHEMIN les deux choix de if font la
                %même chose.
            CHEMIN=img;  % affiche le chemin parcouru (plot existe)
                for(j=1:pasy:taille) %on parcourt l'image horizontalement

                    for(X=departx:pasx:departx+n) %on somme les intensités en partant du point exterieur bas
                        %La droite aura pour équation:
                        % Y(horizontal)=(X(vertical)*t+j-departx*t
                    posy=X*t+j-departx*t-t*n;
                    xp=round(X+0.5);
                    xn=xp-1;
                    yp=round(posy+0.5);
                    yn=yp-1;
                    modx=mod(X,1);
                    mody=mod(posy,1);
                    %on pondere par les ecarts dx et dy (et non sqrt(dx²+dy²))
                    moy(moyY)=moy(moyY)+...
                        (img(xn,yp)*(modx+1-mody)+...
                        img(xp,yp)*(2-modx-mody)+...
                        img(xp,yn)*(1-modx+mody)+...
                        img(xn,yn)*(modx+mody))/4; 

                         CHEMIN(xp,yn)=150;
                        % enregistre le chemin parcouru (optionnel)

                    end 
                    moyY=moyY+1; %on calcule la prochaine moyenne
                    departx=departx-t*pasy; %décalage de la droite
                    
                end 
            figure
            imshow2(CHEMIN) %Affiche le chemin parcouru pour calculer la
                %moyenne
            else
                for(j=1:pasy:taille) %on parcourt l'image horizontalement

                    for(X=departx:pasx:departx+n) %on somme les intensités en partant du point exterieur bas
                        %La droite aura pour équation:
                        % Y(horizontal)=(X(vertical)*t+j-departx*t
                    posy=X*t+j-departx*t-t*n;
                    xp=round(X+0.5);
                    xn=xp-1;
                    yp=round(posy+0.5);
                    yn=yp-1;
                    modx=mod(X,1);
                    mody=mod(posy,1);
                    %on pondere par les ecarts dx et dy (et non sqrt(dx²+dy²))
                    moy(moyY)=moy(moyY)+...
                        (img(xn,yp)*(modx+1-mody)+...
                        img(xp,yp)*(2-modx-mody)+...
                        img(xp,yn)*(1-modx+mody)+...
                        img(xn,yn)*(modx+mody))/4; 

                         CHEMIN(xp,yn,1)=150;
                        % enregistre le chemin parcouru (optionnel)

                    end 
                    moyY=moyY+1; %on calcule la prochaine moyenne
                    departx=departx-t*pasy; %décalage de la droite
                end 
            end
        moy=moy/(round((n-1)/pasx+0.5));
        
        else
            error('n ou l"angle donne est trop grand')
        end
    elseif(t==0)
    warning('langle etant nul on utilise moyvert'); %cas t=0
    moy=moyvert(img,n);
    end
    
else
    error('n est plus grand que l image, prenez un n plus petit')
end

