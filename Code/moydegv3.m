function [ moy ] = moydegv3(img,d,n)
% Renvoie les moyennes d'une image, en prenant les pixels sur un angle de d degrés (par
% rapport à la verticale) . l'angle est inférieur à 90°
% On pondère 4 pixels par leur éloignement à la droite ideale, 
% On parcoure l'image horizontalement, appliquant n autour de son centre vertical

%ENTREES:
% img: image
% d : angle en DEGRE par rapport à la verticale (sens trigo). -90°<d<90°
% n: nombre de valeurs pondérées utilisées dans le calcul de chaque moyenne 

% SORTIES/
% moy: vecteur des moyennes "verticales" suivant l'angle

% A cause de l'angle on ne peut calculer la moyenne en chaque pixel de
% l'image, on aura un vecteur allant de 0 à une taille inférieure à y.
% (y taille horizontale)



%calcul des paramètres
[x,y]=size(img); %x vertical et y horizontal
t=tand(d); %inverse de la pente de la droite

%on fait attention à ne pas sortir de l'image, le déplacement horizontal
%par rapport au centre etant a chaque fois de t*n/2
taille=y-round(n*t+0.5); %on enlève la taille des deux cotés

%on reechantillonne la droite: 
pas=0.5; %pas d'échantillonnage de la droite

if(n<x)
    if (taille>0)
        departx=round(x/2-n/2+0.5); %coordonnée en x du point de départ, on s'éloigne de la bordure avec le +0.5.
        moy=zeros(y,1);      % ou zeros(taille), on laisse 'y' pour se rendre compte qu'on ne calcule pas tout.
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
                %on pondere par les ecarts dx et dy (et non sqrt(dx²+dy²))
                moy(j)=moy(j)+...
                    (img(xn,yp)*(modx+1-mody)+...
                    img(xp,yp)*(2-modx-mody)+...
                    img(xp,yn)*(1-modx+mody)+...
                    img(xn,yn)*(modx+mody))/4; 
                      %il existe peut etre un pb dans la pondération pour
                      %yp ou xp coicidant au point de la droite, à
                      %réfléchir
            end 
           
        end 
        moy=moy/(round((n-1)/pas+0.5));

    end
else
    'n est plus grand que l image, prenez un n plus petit'
end