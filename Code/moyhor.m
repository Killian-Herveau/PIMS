function [ v ] = moyhor(img,n)
% Renvoie les moyennes horizontales d'une image, en partant du centre et en
% prenant un écart horizontal total de n.

%ENTREES:
% img: image
% n: nombre de valeurs utilisées dans le calcul de chaque moyenne -1

% SORTIES/
% vecteur des moyennes verticales

[x,y]=size(img); %x vertical et y horizontal
if(n>x)
    error(strcat('n depasse la taille image: ',num2str(x)))
else
    departy=round(y/2-n/2);
    v=sum(img(:,departy:departy+n)')/(n+1); %le ' est il couteux en temps et operations ?
end
end 