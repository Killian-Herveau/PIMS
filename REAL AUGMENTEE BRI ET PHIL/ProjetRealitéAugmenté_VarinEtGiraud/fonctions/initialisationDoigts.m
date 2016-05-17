function [ M, seuil ] = initialisationDoigts( imgDoigts )
%Initialise la prise en compte de la présence des doigts sur l'image :
%récupère un matrice modèle M et un seuil permettant d'isoler la couleur
%des doigts
%ENTREE : imgDoigts : image (int8) de la video d'origine dans laquelle les
%           doigts sont présents
%SORTIE : M : matrice modèle retournée par CalcM permettant d'isoler la
%           couleur des doigts
%         seuil : valeur (double) permettant d'isoler la couleur des doigts

imagesc(imgDoigts);
%Selection des doigts à la souris :
[x,y] = ginput(2);
x=fix(x)
y=fix(y)
% Les valeurs suivante fonctionnent bien :
% x=[277, 286];
% y=[110, 130];

%Reduit l'image à la zone où se trouvent les doigts
imgRed = imgDoigts(y(1):y(2),x(1):x(2),:);

M=CalcM(double(imgRed));
seuil = 0.1;
%La valeur de seuil fonctionnelle est empirique
end

