function [ nairy,vimgout ] = getairy( img )
%Permet de rep�rer les differentes taches d'Airy d'une image
%on va privil�gier les faux n�gatifs sur les faux positifs
%   Entrees:
%   -img: 
%   Sorties:
%   -nimg: nombre de taches differentes detectees
%   -vimgout: vecteur des differentes images detectees

col=mean(img);
line=mean(img');




end

