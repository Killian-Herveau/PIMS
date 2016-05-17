function [M, seuil, barN_1] = initialisation(img1)
%Cette fonction permet l'initialisation du traitement de la vid�o.
%Elle permet de selectionner l'un des picots bleu de d�terminer un seuil
%ad�quat qui sera utiliser pour tout le traitement
%ENTREE : img1, 1i�re image de la vid�o
%SORTIES : M, matrice (3*4 double) mod�le utilis�e par la distance de mahalanobis
%          seuil, seuil (double) permetant de dif�rencier les picots du reste
%          barN_1, position (2*4 double) des barycentre des picots de la
%          premi�re image. Chaque colonne repr�sente les position [x;y] de
%          chaque barycentre.

close all

imshow(img1);
%Selection d'un picot � la souris :
% [x,y] = ginput(2);
% x=fix(x)
% y=fix(y)
%Les valeurs suivante fonctionnent bien :
x=[184,194];
y=[142,152];

%Reduction de l'image d'apr�s les coordonn�es choisies
imgRed = img1(y(1):y(2),x(1):x(2),:);

%Calcul du mod�le M utilis� pour faire une distance de Mahalanobis
M=CalcM(double(imgRed));

%Cacul de la distance de Mahalanobis
imDist = dMaha(double(img1), M);

% Choix d'un seuil pour diff�rencier la couleur du picot du reste
seuil = '1';
%Boucle permettant de trouver un seuil ad�quat ne faisant apparaitre que
%les picots. Cette boucle peut �tre comment�e pour utiliser le seuil apr
%d�faut de 1
    validation = 'Non';
    imagesc(imDist);
    while validation == 'Non'
        seuil = inputdlg('Veuillez choisir une valeur pour le seuil',...
             'Choix seuil',...
             1,...
             {seuil});
        seuil = str2double(seuil);
        imSeuillee  = imDist < seuil;
        h=figure, imshow(imSeuillee);
        validation = questdlg('Ce seuil vous convient-il ?', 'Validation seuil',...
            'Oui', 'Non', 'Oui');
        seuil = num2str(seuil);
        close all
    end
seuil = str2double(seuil);

%Seuillage
imSeuillee  = imDist < seuil;

%D�termination de la position des picots
barN_1 = determination_bar(imSeuillee);

%R�ordonancement des picots trouv�s
barry = barN_1(:,3);
barN_1(:,3) = barN_1(:,4);
barN_1(:,4) = barry;

close all
end
