function [ imDist ] = dMaha( img, M )
%Calcul la distance de Mahalanobis entre chaque pixel de l'image img en entr�e
%et un mod�le de couleur donn� par M
%ENTREES : img image de double en couleur
%          M matrice mod�le de couleur retourn�e par CalcM
%SORTIE :  imDist image de double en nuance de gris donnant la distance de
%           Mahalanobis pour chaque pixel

%S�paration des moyenne et des covariances
sigma = M(:,2:4);
mu = M(:,1);

%S�paration des donn�es pour chaque couleur
R = img(:,:,1)-mu(1);
G = img(:,:,2)-mu(2);
B = img(:,:,3)-mu(3);

%Calcul de la distance de Mahalanobis pour chaque pixel. Renvoie les pixels
%comme un unique vecteur ligne
imDist = sum([R(:)'; G(:)'; B(:)'].*(inv(sigma)*[R(:)'; G(:)'; B(:)']),1);

%R�organisation des pixels sous forme d'un images
imDist = reshape( imDist, size(img,1), size(img,2), 1 );

end

