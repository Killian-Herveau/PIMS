function [ barN ] = reperage_pos_picots( imgN, M, seuil, barN_1  )
%Repère la position (barycentre) des 4 picots de la Nième image d'après la
%postion des picots à l'image précédente
%ENTREES : imgN : Nième image (valeur en int8) de la vidéo
%          M : matrice modèle utilisée pour la distance de Mahalanobis. 
%               Obtenue à l'aide de CalcM
%          Seuil : double, seuil à prendre pour isoler le picots dans
%               l'espace de Mahalanobis
%          barN_1 : position (2*4 int8) des 4 barycentres à l'image précédente
%SORTIE :  barN : position (2*8 int8)  des 4 barycentres à l'image N

%Crée une image binaire isolant les 4 picots
imgN = double(imgN);
imDist = dMaha(imgN, M);
imSeuil = imDist < seuil;

%Détermines les barycentre des 4 picots
barycentre = determination_bar(imSeuil);

%Réordonne les picots d'après leur position à l'image précédente
barN = ordonnancement(barN_1, barycentre);

end

