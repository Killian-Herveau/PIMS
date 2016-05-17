function [ barN ] = reperage_pos_picots( imgN, M, seuil, barN_1  )
%Rep�re la position (barycentre) des 4 picots de la Ni�me image d'apr�s la
%postion des picots � l'image pr�c�dente
%ENTREES : imgN : Ni�me image (valeur en int8) de la vid�o
%          M : matrice mod�le utilis�e pour la distance de Mahalanobis. 
%               Obtenue � l'aide de CalcM
%          Seuil : double, seuil � prendre pour isoler le picots dans
%               l'espace de Mahalanobis
%          barN_1 : position (2*4 int8) des 4 barycentres � l'image pr�c�dente
%SORTIE :  barN : position (2*8 int8)  des 4 barycentres � l'image N

%Cr�e une image binaire isolant les 4 picots
imgN = double(imgN);
imDist = dMaha(imgN, M);
imSeuil = imDist < seuil;

%D�termines les barycentre des 4 picots
barycentre = determination_bar(imSeuil);

%R�ordonne les picots d'apr�s leur position � l'image pr�c�dente
barN = ordonnancement(barN_1, barycentre);

end

