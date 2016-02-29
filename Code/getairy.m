function [ nairy,vimgout ] = getairy( img )
%Permet de repérer les differentes taches d'Airy d'une image
%on va privilégier les faux négatifs sur les faux positifs
%   Entrees:
%   -img: 
%   Sorties:
%   -nimg: nombre de taches differentes detectees
%   -vimgout: vecteur des differentes images detectees

col=mean(img);
line=mean(img');




end

