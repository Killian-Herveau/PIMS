function [ M, seuil ] = initialisationDoigts( imgDoigts )
%Initialise la prise en compte de la pr�sence des doigts sur l'image :
%r�cup�re un matrice mod�le M et un seuil permettant d'isoler la couleur
%des doigts
%ENTREE : imgDoigts : image (int8) de la video d'origine dans laquelle les
%           doigts sont pr�sents
%SORTIE : M : matrice mod�le retourn�e par CalcM permettant d'isoler la
%           couleur des doigts
%         seuil : valeur (double) permettant d'isoler la couleur des doigts

imagesc(imgDoigts);
%Selection des doigts � la souris :
[x,y] = ginput(2);
x=fix(x)
y=fix(y)
% Les valeurs suivante fonctionnent bien :
% x=[277, 286];
% y=[110, 130];

%Reduit l'image � la zone o� se trouvent les doigts
imgRed = imgDoigts(y(1):y(2),x(1):x(2),:);

M=CalcM(double(imgRed));
seuil = 0.1;
%La valeur de seuil fonctionnelle est empirique
end

