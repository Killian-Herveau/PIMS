function [ moyout ] = moydegtest(image,d,n,centrex,centrey,pasx,pasy,plot)

% Calcule la moyenne selon des segments orientés, en passant par un centre

% Renvoie les moyennes de segments orientés d'une image, en suivant un pas, en prenant les pixels sur un angle de d degrés (par
% rapport à la verticale) . l'angle est inférieur à 90°
%angle <0 : /===/      angle>0   \===\  
% On pondère 4 pixels par leur éloignement à la droite ideale, en dx+dy
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

[ximage,yimage]=size(image); %x vertical et y horizontal
t=tand(d); %inverse de la pente de la droite

%on rajoute une image autour au cas où on dépasse, autour il y aura des
%"nan"
maximg=max(max(image));
img=zeros(3*ximage,3*yimage);
img(ximage:2*ximage-1,yimage:2*yimage-1)=image; %on met l'image au centre
img(1:ximage-1,:)=maximg;
img(2*ximage:3*ximage,:)=maximg;
img(ximage:2*ximage-1,1:yimage-1)=maximg;
img(ximage:2*ximage-1,2*yimage:3*yimage)=maximg;

% moy=zeros((y=taille-1-mod(y-1,pasy)),1);
% departx=round(x/2-n/2+0.5);
% 
% departx=ximage+round(centrex-centrey*t-n/cosd(d))
% departx=ximage+round(centrex*t-n*cosd(d)/2-t*(centrey-n*sind(d)/2))
% departx=ximage+round(centrex+((centrey*t))-(n/(2*cosd(d))))

% departx=ximage+centrex+round(t*centrey-(t>0)*n/(cosd(d)));
departx=ximage+centrex+round(-n/(2*cosd(d))+t*centrey)+1;

% <=> à
        % if(t>0)
        %     departx=ximage+round(centrex+t*centrey-n/(2*cosd(d)))-1
        % else
        %     departx=ximage+round(centrex+t*centrey))
        % end 
        
        
%On verifie que le centre demande n'implique pas de sortir de l'image
%sinon on decale la position initiale        
ajouty=0;
if(departx>2*ximage) %possible avec t>0
    'modif de departx car depasse en bas'
    departx=2*ximage-sind(d)*n-2;        %si depasse en bas:pb de ce qu'on enlève
    %ou cosd(d)
    ajouty=round(centrey-n/(2*cosd(d))-(ximage-centrex)/t)
elseif(departx<ximage)  %possible avec t<0 %fonctionne !
    'modif de departx car depasse en haut'
    ajouty=-round((ximage-departx)/t+n/(2*cosd(d))) %ou enlever cos..
    departx=ximage;
end 

moyY=1; %colonne de la moyenne
[x,y]=size(img); %x vertical et y horizontal
moy=zeros(round(-0.5+(yimage)/pasy),1);      % Moy vert


if(n<x)
    if(t>0)
        %on fait attention à ne pas sortir de l'image par le cote:
        taille1=yimage-round(n*t+0.5);
        %on fait attention à ne pas sortir par en dessous ou au dessus:
        taille2=round((ximage/2-n/2)/t);
        taille=min(taille1,taille2);
        if (taille>0)
            if (plot)  %on fait deux boucles differentes selon qu'on ai besoin de plot CHEMIN ou non
                %A part creer ou non CHEMIN les deux choix de if font la
                %même chose.
                maximg=max(max(image));
            CHEMIN=img;  % affiche le chemin parcouru (plot existe)
                for(j=yimage+ajouty:pasy:2*yimage-n*sind(d)-2) %on parcourt l'image horizontalement
                    
                    for(X=departx:pasx:departx+round(sind(d)*n)) %on somme les intensités en partant du point exterieur bas
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
                    
                        CHEMIN(xp,yp)=maximg;
                        CHEMIN(xn,yn)=maximg;
                    end 
                    departx=departx-t*pasy; %décalage de la droite
                    if(departx>2*ximage)|(departx<ximage) %si on sort de l'image
                        break
                    end
                    moyY=moyY+1; %on calcule la prochaine moyenne

                end 
            figure
            imshow2(CHEMIN) %Affiche le chemin parcouru pour calculer la
                %moyenne
            
            else
                for(j=yimage+ajouty:pasy:2*yimage-n*sind(d)-2) %on parcourt l'image horizontalement
                       
                    for(X=departx:pasx:departx+round(sind(d)*n)) %on somme les intensités en partant du point exterieur bas
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
                     if(departx>2*ximage)|(departx<ximage) %si on sort de l'image
                        break
                    end
                    moyY=moyY+1; %on calcule la prochaine moyenne

                end 
            end
            moy=moy/(round((n-1)/pasx+0.5));
        else
            error('n ou l"angle donne est trop grand')
        end
        
            
        
    elseif t<0
        taille2=-round((ximage/2-n/2)/t);
        taille1=yimage-round(-n*t+0.5);
        taille=min(taille1,taille2);
        
        if (taille>0)
            
            if (plot)  %on fait deux boucles differentes selon qu'on ai besoin de plot CHEMIN ou non
                %A part creer ou non CHEMIN les deux choix de if font la
                %même chose.
                maximg=max(max(image));
                CHEMIN=img;  % affiche le chemin parcouru (plot existe)
                yimage+ajouty
                for(j=yimage+ajouty:pasy:2*yimage-1+ajouty+n*sind(d)-3) %on parcourt l'image horizontalement

                    for(X=departx:pasx:departx+round(-sind(d)*n)) %on somme les intensités en partant du point exterieur bas
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

                         CHEMIN(xp,yp)=maximg;
                         CHEMIN(xn,yn)=maximg;
                        % enregistre le chemin parcouru (optionnel)
              
                    end 
                    moyY=moyY+1; %on calcule la prochaine moyenne
                    departx=departx-t*pasy; %décalage de la droite
                     if(departx-n*sind(d)+2>2*ximage)|(departx<ximage) %si on sort de l'image
                        break
                    end
                    % imshow(CHEMIN)
                end 
            figure
            imshow2(CHEMIN) %Affiche le chemin parcouru pour calculer la
                %moyenne
            else
                for(j=yimage+ajouty:pasy:2*yimage-1+ajouty) %on parcourt l'image horizontalement

                    for(X=departx:pasx:departx+round(-sind(d)*n)) %on somme les intensités en partant du point exterieur bas
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

                    end 
                    moyY=moyY+1; %on calcule la prochaine moyenne
                    departx=departx-t*pasy; %décalage de la droite
                     if(departx-n*sind(d)+2>2*ximage)|(departx<ximage) %si on sort de l'image
%                         j=2*yimage-1+ajouty;
                         break
                     end
                end 
            end
        moyout=moy/(round((n-1)/pasx+0.5));
        
        else
            error('n ou l"angle donne est trop grand')
        end
    elseif(t==0)
    warning('langle etant nul on utilise moyvert'); %cas t=0
    moyout=moyvert(img,n);
    end
    %on enleve les nan de la moyenne, pour ressortir moyout(debut:fin)
    debut=1;
    fin=size(moyout);
    i=2;
%         while((moyout(i)==nan)&(i<fin))
%             i=i+1;
%         end
%         debut=i-1
%         while((moyout(i)~=nan)&(i<fin))
%             i=i+1;
%         end
%         fin=i
%         moyout(i)
%         moyout(i-1)
else
    error('n est plus grand que l image, prenez un n plus petit')
    moyout=0;
end

