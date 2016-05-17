function [ M ] = CalcM( imgRed )
%Permet le calcul du mod�le M=[moyenne,covariance] des couleurs de l'image
%pass�e en entr�e
%ENTREE : imgRed image de double en couleur
%SORTIE : M mod�le des couleur, d�finie selon M=[mu,sigma]:
%           mu (3*1 double) moyenne des couleur sur l'espace RGB
%           sigma (3*3 double) covariance des couleur sur l'espace RGB

mu = mean(mean(imgRed));
mu=mu(:); %R�ordonnancement des moyenne

%R�cup�ration et r�odonancement des couleur de chaque pixel
R=imgRed(:,:,1);
G=imgRed(:,:,2);
B=imgRed(:,:,3);
x(:,1)=R(:);
x(:,2)=G(:);
x(:,3)=B(:);

%Calcul de chaque �l�ment de la matrice de covariance
sigma=ones(3,3);
for i=1:3
    for j=1:3
        sigma(i,j)=sum((x(:,i)-mu(i)).*(x(:,j)-mu(j)));
    end
end

M=[mu,sigma];
end

