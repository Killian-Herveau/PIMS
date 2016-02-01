function [ v ] = moyvert(img,n)
% Renvoie les moyennes verticales d'une image, en partant du centre et en
% prenant un écart vertical de n.

%ENTREES:
% img: image
% n: nombre de valeurs utilisées dans le calcul de chaque moyenne

% SORTIES/
% vecteur des moyennes verticales

[x,y]=size(img); %x vertical et y horizontal

if(mod(x,2))
    x=x+1;
end
v=sum(img((x/2-floor(n/2)):(x/2+floor(n/2)),:))./x;


end 
