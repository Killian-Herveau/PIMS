function [ imgN ] = Incrustation( imgN, imgRemplacement, barN, Mmain, seuilmain)
%Dans l'image imgN, remplace la zone définie par les 4 picots de barN par
%l'image imgRemplacement. Ne remplace pas la zone correspondant à la main
%ENTREES : imgN : Nième image (int8) de la vidéo
%          imgRemplacement : image (double) servant à remplacer la zone
%               définie par les picots
%          barN : poistion (2*4 int8) des barycentres des picots sur
%               l'image N
%          Mmain : Matrice modèle retournée par CalcM représentant les
%               couleurs de la main
%          seuilmain : seuil permetant d'isoler la couleur de la main
%SORTIE : imgN : Nième image (int8) de la vidéo, avec le remplacement
%               effectué

%Récupère la variable globale N indiquant le numéro de l'image en cours de
%traitement
global N

%Réorganise les barycentres
barN=barN';

%Définit la zone dans d'imgN représentée par barN. corecCoin permet de ne
%pas prendre les bords de l'image de remplacement, et ainsi remplacer une
%zone plus large (ie : toute la feuille), au lieu de remplacer la zone
%située exclusivement entre les picots.
corecCoin=0.080;
coins = [(1-corecCoin)*size(imgRemplacement,2), (1-corecCoin)*size(imgRemplacement,1);     corecCoin*size(imgRemplacement,2), (1-corecCoin)*size(imgRemplacement,1); 
            corecCoin*size(imgRemplacement,2),     corecCoin*size(imgRemplacement,1); (1-corecCoin)*size(imgRemplacement,2),     corecCoin*size(imgRemplacement,1)];

%Calcul de l'homographie entre la zone à remplacer sur l'image de la vidéo
%et l'image de remplacement.
H=fitgeotrans(coins, barN, 'projective');

%Déforme l'image de remplacement d'après l'homographie, récupère ses
%dimensions
[imgtransformee,infos] = imwarp(imgRemplacement, H, 'FillValues', [-1 -1 -1]);
minX = round(infos.XWorldLimits(1));
minY = round(infos.YWorldLimits(1));

%Isole la partie d'intérêt (ie : à modifier) sur l'image imgN
imgNfinale = imgN(minY:(minY+infos.ImageSize(1)-1), minX:(minX+infos.ImageSize(2)-1),:);

%Si la main est présente sur l'image, donc à prendre en compte
if N>=38
    %Répère la position de la main
    imDist = dMaha(double(imgNfinale), Mmain);
    imSeuillee  = imDist < seuilmain;
    
    %Ferme puis ouvre l'image de la main, pour homogénéiser la zone à
    %prendre en compte
    elem = strel('disk', 2, 0);
    imSeuillee = imdilate(imerode(imSeuillee, elem), elem);
    elem2=strel('disk', 4, 0);
    imSeuillee = imerode(imdilate(imSeuillee, elem2), elem2);
    
    %Indique que la main ne doit pas être remplacée (valeur -1 sur l'image
    %de remplacement)
    imgtransformee = (repmat(imSeuillee==0,1,1,3)).*imgtransformee + (repmat(imSeuillee~=0,1,1,3))*-1;
end

%Remplie l'image de remplacement après homographie (donc non rectangulaire)
%avec les valeur de l'image de fond imgN
imgNfinale = (imgtransformee<0).*double(imgNfinale) + (imgtransformee>=0).*imgtransformee;

%Replace l'image après incrustation dans l'image globale
imgN(minY:(minY+infos.ImageSize(1)-1), minX:(minX+infos.ImageSize(2)-1),:) = imgNfinale;
end

