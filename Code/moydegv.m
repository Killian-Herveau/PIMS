function [ moy ] = moydegv(img,d,n)
% Renvoie les moyennes d'une image, en prenant les pixels sur un angle de d degrés (par
% rapport à la verticale) . l'angle est inférieur à 90°
%On parcoure l'image horizontalement, appliquant n autour de son centre vertical

%ENTREES:
% img: image
% d : angle en DEGRE par rapport à la verticale (sens trigo). -90°<d<90°
% n: nombre de valeurs utilisées dans le calcul de chaque moyenne 

% SORTIES/
% moy: vecteur des moyennes "verticales" suivant l'angle

% A cause de l'angle on ne peut calculer la moyenne en chaque pixel de
% l'image, on aura un vecteur allant de 0 à une taille inférieure à y.
% (y taille horizontale)
%MAT=img;


%calcul des paramètres
[x,y]=size(img); %x vertical et y horizontal
t=tand(d); 

%on fait attention à ne pas sortir de l'image, le déplacement horizontal
%par rapport au centre etant a chaque fois de t*n/2
taille=y-round(n*t+0.5); %on enlève la taille des deux cotés
if(n<x)
    if (taille>0)
        departx=round(x/2-n/2); %coordonnée en x du point le plus bas , 
        %-1?
        moy=zeros(y,1);      % ou zeros(taille), on laisse 'y' pour se rendre compte qu'on ne calcule pas tout.
        for(j=1:taille) %on parcourt l'image horizontalement
            for(i=1:n) %on somme les intensités en partant du point exterieur bas gauche 

                moy(j)=moy(j)+img(departx+i,round(j+(i-1)*t)); %pour un decalage i en x on a un decalage i*t en y
                %MAT(departx+i,round(j+(i-1)*t))=0;
            end 
            %imshow(MAT)
        end 
        moy=moy/(n);

    end
else
    'n est plus grand que l image, prenez un n plus petit'
end