function [ v ] = moyhor(img,n)
% Renvoie les moyennes horizontales d'une image, en partant du centre et en
% prenant un écart horizontal de n.

%ENTREES:
% img: image
% n: nombre de valeurs utilisées dans le calcul de chaque moyenne

% SORTIES/
% vecteur des moyennes verticales

[x,y]=size(img); %x vertical et y horizontal

if(mod(y,2))
    y=y+1;
end

v=sum(img(:,(y/2-floor(n/2)):(y/2+floor(n/2)))')./y;

end 