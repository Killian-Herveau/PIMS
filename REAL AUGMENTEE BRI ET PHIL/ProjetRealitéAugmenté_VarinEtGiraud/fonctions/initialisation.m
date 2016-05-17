function [M, seuil, barN_1] = initialisation(img1)
%Cette fonction permet l'initialisation du traitement de la vidéo.
%Elle permet de selectionner l'un des picots bleu de déterminer un seuil
%adéquat qui sera utiliser pour tout le traitement
%ENTREE : img1, 1ière image de la vidéo
%SORTIES : M, matrice (3*4 double) modèle utilisée par la distance de mahalanobis
%          seuil, seuil (double) permetant de diférencier les picots du reste
%          barN_1, position (2*4 double) des barycentre des picots de la
%          première image. Chaque colonne représente les position [x;y] de
%          chaque barycentre.

close all

imshow(img1);
%Selection d'un picot à la souris :
% [x,y] = ginput(2);
% x=fix(x)
% y=fix(y)
%Les valeurs suivante fonctionnent bien :
x=[184,194];
y=[142,152];

%Reduction de l'image d'après les coordonnées choisies
imgRed = img1(y(1):y(2),x(1):x(2),:);

%Calcul du modèle M utilisé pour faire une distance de Mahalanobis
M=CalcM(double(imgRed));

%Cacul de la distance de Mahalanobis
imDist = dMaha(double(img1), M);

% Choix d'un seuil pour différencier la couleur du picot du reste
seuil = '1';
%Boucle permettant de trouver un seuil adéquat ne faisant apparaitre que
%les picots. Cette boucle peut être commentée pour utiliser le seuil apr
%défaut de 1
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

%Détermination de la position des picots
barN_1 = determination_bar(imSeuillee);

%Réordonancement des picots trouvés
barry = barN_1(:,3);
barN_1(:,3) = barN_1(:,4);
barN_1(:,4) = barry;

close all
end
