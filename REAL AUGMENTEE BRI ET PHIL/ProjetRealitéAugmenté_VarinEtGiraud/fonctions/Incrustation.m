function [ imgN ] = Incrustation( imgN, imgRemplacement, barN, Mmain, seuilmain)
%Dans l'image imgN, remplace la zone d�finie par les 4 picots de barN par
%l'image imgRemplacement. Ne remplace pas la zone correspondant � la main
%ENTREES : imgN : Ni�me image (int8) de la vid�o
%          imgRemplacement : image (double) servant � remplacer la zone
%               d�finie par les picots
%          barN : poistion (2*4 int8) des barycentres des picots sur
%               l'image N
%          Mmain : Matrice mod�le retourn�e par CalcM repr�sentant les
%               couleurs de la main
%          seuilmain : seuil permetant d'isoler la couleur de la main
%SORTIE : imgN : Ni�me image (int8) de la vid�o, avec le remplacement
%               effectu�

%R�cup�re la variable globale N indiquant le num�ro de l'image en cours de
%traitement
global N

%R�organise les barycentres
barN=barN';

%D�finit la zone dans d'imgN repr�sent�e par barN. corecCoin permet de ne
%pas prendre les bords de l'image de remplacement, et ainsi remplacer une
%zone plus large (ie : toute la feuille), au lieu de remplacer la zone
%situ�e exclusivement entre les picots.
corecCoin=0.080;
coins = [(1-corecCoin)*size(imgRemplacement,2), (1-corecCoin)*size(imgRemplacement,1);     corecCoin*size(imgRemplacement,2), (1-corecCoin)*size(imgRemplacement,1); 
            corecCoin*size(imgRemplacement,2),     corecCoin*size(imgRemplacement,1); (1-corecCoin)*size(imgRemplacement,2),     corecCoin*size(imgRemplacement,1)];

%Calcul de l'homographie entre la zone � remplacer sur l'image de la vid�o
%et l'image de remplacement.
H=fitgeotrans(coins, barN, 'projective');

%D�forme l'image de remplacement d'apr�s l'homographie, r�cup�re ses
%dimensions
[imgtransformee,infos] = imwarp(imgRemplacement, H, 'FillValues', [-1 -1 -1]);
minX = round(infos.XWorldLimits(1));
minY = round(infos.YWorldLimits(1));

%Isole la partie d'int�r�t (ie : � modifier) sur l'image imgN
imgNfinale = imgN(minY:(minY+infos.ImageSize(1)-1), minX:(minX+infos.ImageSize(2)-1),:);

%Si la main est pr�sente sur l'image, donc � prendre en compte
if N>=38
    %R�p�re la position de la main
    imDist = dMaha(double(imgNfinale), Mmain);
    imSeuillee  = imDist < seuilmain;
    
    %Ferme puis ouvre l'image de la main, pour homog�n�iser la zone �
    %prendre en compte
    elem = strel('disk', 2, 0);
    imSeuillee = imdilate(imerode(imSeuillee, elem), elem);
    elem2=strel('disk', 4, 0);
    imSeuillee = imerode(imdilate(imSeuillee, elem2), elem2);
    
    %Indique que la main ne doit pas �tre remplac�e (valeur -1 sur l'image
    %de remplacement)
    imgtransformee = (repmat(imSeuillee==0,1,1,3)).*imgtransformee + (repmat(imSeuillee~=0,1,1,3))*-1;
end

%Remplie l'image de remplacement apr�s homographie (donc non rectangulaire)
%avec les valeur de l'image de fond imgN
imgNfinale = (imgtransformee<0).*double(imgNfinale) + (imgtransformee>=0).*imgtransformee;

%Replace l'image apr�s incrustation dans l'image globale
imgN(minY:(minY+infos.ImageSize(1)-1), minX:(minX+infos.ImageSize(2)-1),:) = imgNfinale;
end

