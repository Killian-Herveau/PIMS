function [ moy ] = moydeg(img,d,n,pas,plot)
% Renvoie les moyennes verticales d'une image, en prenant les pixels sur un angle de d degrés (par
% rapport à la verticale) . l'angle est inférieur à 90°
%angle <0 : /===/      angle>0   \===\  
% On pondère 4 pixels par leur éloignement à la droite ideale, la droite
% est tracee selon le pas renseigné.
% On parcourt l'image normalement à la droite, appliquant n autour de son centre vertical

%ENTREES:
% img: image
% d : angle en DEGRE par rapport à la verticale (sens ). -90°<d<90°
% n: nombre de valeurs pondérées utilisées dans le calcul de chaque moyenne 
% plot: si plot a une valeur non nulle ou non NULL, la fonction affichera le chemin parcouru

% SORTIES/
% moy: vecteur des moyennes "verticales" suivant l'angle

% A cause de l'angle on ne peut calculer la moyenne en chaque pixel de
% l'image, on aura un vecteur allant de 0 à une taille inférieure à y.
% (y taille horizontale)

if (exist('plot','var'))
    plot=1-(plot==0);
else
    plot=0;
end

%calcul des paramètres
[x,y]=size(img); %x vertical et y horizontal
t=tand(d); %inverse de la pente de la droite



Valeurs=zeros(n,y); %enregistre les valeurs parcourues
moy=zeros(y,1);      % Moy vert, ou zeros(taille), on laisse 'y' pour se rendre compte qu'on ne calcule pas tout.
departx=round(x/2-n/2+0.5);

%on reechantillonne la droite: 
pas=0.01; %pas d'échantillonnage de la droite



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
                for(j=1:taille) %on parcourt l'image horizontalement

                    for(X=departx:pas:departx+n-1) %on somme les intensités en partant du point exterieur bas
                        %La droite aura pour équation:
                        % Y(horizontal)=X(vertical)*t+j-departx*t
                        posy=X*t+j-departx*t;
                        xp=round(X+0.5);
                        xn=xp-1;
                        yp=round(posy+0.5);
                        yn=yp-1;
                        modx=mod(X,1);
                        mody=mod(posy,1);
                        moy(j)=moy(j)+...
                        (img(xn,yp)*(modx+1-mody)+...
                        img(xp,yp)*(2-modx-mody)+...
                        img(xp,yn)*(1-modx+mody)+...
                        img(xn,yn)*(modx+mody))/4; 
                        CHEMIN(xp,yp)=150;

                    end 
                    departx=departx-t; %décalage de la droite

                end 
            figure
            imshow2(CHEMIN) %Affiche le chemin parcouru pour calculer la
                %moyenne
            
            else
                for(j=1:taille) %on parcourt l'image horizontalement

                    for(X=departx:pas:departx+n-1) %on somme les intensités en partant du point exterieur bas
                        %La droite aura pour équation:
                        % Y(horizontal)=X(vertical)*t+j-departx*t
                        posy=X*t+j-departx*t;
                        xp=round(X+0.5);
                        xn=xp-1;
                        yp=round(posy+0.5);
                        yn=yp-1;
                        modx=mod(X,1);
                        mody=mod(posy,1);
                        moy(j)=moy(j)+...
                        (img(xn,yp)*(modx+1-mody)+...
                        img(xp,yp)*(2-modx-mody)+...
                        img(xp,yn)*(1-modx+mody)+...
                        img(xn,yn)*(modx+mody))/4; 
                        CHEMIN(xp,yp)=150;

                    end 
                    departx=departx-t; %décalage de la droite

                end 
            end
            moy=moy/(round((n-1)/pas+0.5));
        else
            error('n ou l"angle donne est trop grand')
        end
        
            
        
    elseif t<0
        taille2=-round(x/2-n/2)/t;
        taille1=y-round(-n*t+0.5);
        taille=min(taille1,taille2)
        
        if (taille>0)
            
            if (plot)  %on fait deux boucles differentes selon qu'on ai besoin de plot CHEMIN ou non
                %A part creer ou non CHEMIN les deux choix de if font la
                %même chose.
            CHEMIN=img;  % affiche le chemin parcouru (plot existe)
                for(j=1:taille) %on parcourt l'image horizontalement

                    for(X=departx:pas:departx+n-1) %on somme les intensités en partant du point exterieur bas
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
                    moy(j)=moy(j)+...
                        (img(xn,yp)*(modx+1-mody)+...
                        img(xp,yp)*(2-modx-mody)+...
                        img(xp,yn)*(1-modx+mody)+...
                        img(xn,yn)*(modx+mody))/4; 

                         CHEMIN(xp,yn,1)=150;
                        % enregistre le chemin parcouru (optionnel)

                    end 

                    departx=departx-t; %décalage de la droite
                end 
            figure
            imshow2(CHEMIN) %Affiche le chemin parcouru pour calculer la
                %moyenne
            else
                for(j=1:taille) %on parcourt l'image horizontalement

                    for(X=departx:pas:departx+n-1) %on somme les intensités en partant du point exterieur bas
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
                    moy(j)=moy(j)+...
                        (img(xn,yp)*(modx+1-mody)+...
                        img(xp,yp)*(2-modx-mody)+...
                        img(xp,yn)*(1-modx+mody)+...
                        img(xn,yn)*(modx+mody))/4; 

                         CHEMIN(xp,yn,1)=150;
                        % enregistre le chemin parcouru (optionnel)

                    end 

                    departx=departx-t; %décalage de la droite
                end 
            end
        moy=moy/(round((n-1)/pas+0.5));
        
        else
            error('n ou l"angle donne est trop grand')
        end
    else
        warning('langle etant nul on utilise moyvert');
        moy=moyvert(img,n);
    end
    
else
    error('n est plus grand que l image, prenez un n plus petit')
end

