function [ moy ] = moydegv3(img,d,n)
% Renvoie les moyennes d'une image, en prenant les pixels sur un angle de d degr�s (par
% rapport � la verticale) . l'angle est inf�rieur � 90�
% On pond�re 4 pixels par leur �loignement � la droite ideale, 
% On parcoure l'image horizontalement, appliquant n autour de son centre vertical

%ENTREES:
% img: image
% d : angle en DEGRE par rapport � la verticale (sens trigo). -90�<d<90�
% n: nombre de valeurs pond�r�es utilis�es dans le calcul de chaque moyenne 

% SORTIES/
% moy: vecteur des moyennes "verticales" suivant l'angle

% A cause de l'angle on ne peut calculer la moyenne en chaque pixel de
% l'image, on aura un vecteur allant de 0 � une taille inf�rieure � y.
% (y taille horizontale)



%calcul des param�tres
[x,y]=size(img); %x vertical et y horizontal
t=tand(d); %inverse de la pente de la droite

%on fait attention � ne pas sortir de l'image, le d�placement horizontal
%par rapport au centre etant a chaque fois de t*n/2
taille=y-round(n*t+0.5); %on enl�ve la taille des deux cot�s

%on reechantillonne la droite: 
pas=0.5; %pas d'�chantillonnage de la droite

if(n<x)
    if (taille>0)
        departx=round(x/2-n/2+0.5); %coordonn�e en x du point de d�part, on s'�loigne de la bordure avec le +0.5.
        moy=zeros(y,1);      % ou zeros(taille), on laisse 'y' pour se rendre compte qu'on ne calcule pas tout.
        for(j=1:taille) %on parcourt l'image horizontalement
            for(X=departx:pas:departx+n-1) %on somme les intensit�s en partant du point exterieur bas
                %La droite aura pour �quation:
                % Y(horizontal)=X(vertical)*t+j-departx*t
                posy=X*t+j-departx*t;
                xp=round(X+0.5);
                xn=xp-1;
                yp=round(posy+0.5);
                yn=yp-1;
                modx=mod(X,1);
                mody=mod(posy,1);
                %on pondere par les ecarts dx et dy (et non sqrt(dx�+dy�))
                moy(j)=moy(j)+...
                    (img(xn,yp)*(modx+1-mody)+...
                    img(xp,yp)*(2-modx-mody)+...
                    img(xp,yn)*(1-modx+mody)+...
                    img(xn,yn)*(modx+mody))/4; 
                      %il existe peut etre un pb dans la pond�ration pour
                      %yp ou xp coicidant au point de la droite, �
                      %r�fl�chir
            end 
           
        end 
        moy=moy/(round((n-1)/pas+0.5));

    end
else
    'n est plus grand que l image, prenez un n plus petit'
end