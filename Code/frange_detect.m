function [ f_im ] = frange_detect( img,alpha )
%   img = image à traiter
%   x = position en x de la gaussienne fittant au mieu la tâche
%   y = position en y ---
%   f_im = courbe correspondant au moydeg de fourier
%%
%On a pf=N/D // pf le pixel correspondant à la période D en pixel, N le nb
%de pixels
%donc pour D=2.5 on a 120/2.5 = 48
%D=3.5 on a 120/3.5 = 34.3
%ARBITRAIRE, JUSTE POUR LES PREMIERS TESTS
%A MODIFIER APRES, EN VERIFIANT LES CAS MESURES ET CALIBRATION
%on applique un anneau hypergaussien contenant la fréquence
%d'échantillonnage de 3px/franges
%%
[x,y]=size(img);
x=x/2;y=y/2;
%H2=hgaussp(size(img),[p1(3),p1(4)],1,34,0,15);%D=3.5 à modifier
%G2=hgaussp(size(img),[p1(3),p1(4)],1,48,0,15);%D=2.5
H2=hgaussp(size(img),[x,y],1,18,0,15);
G2=hgaussp(size(img),[x,y],1,50,0,15);

im2=fftshift(fft2(img));
%Application du donut <= A CHANGER
%pour plus de précision en théorie, vaudrait mieux utiliser des cercles,
%juste sélectionner ce qu'on veut mais après faut voir, vu moydeg ça peut
%rester comme ça (on sélect directement ce qu'on veut) = moins de
%traitements
im2= (1-H2).*G2.*im2;
f2=abs(im2);
%fait la moyenne sur les boules d'intérêt, seulement "horizontal"
%pour le moment, après il faudra faire avec vertical puis faire la moyenne
%voir faire deux tableaux distincts pour voir les variations relatives :
%les deux (horz et vert) donnent la même valeur ou y a-t-il un offset
%permanent ? vérifier. REPONSE : Offset dû peut être au sampling
% Voir maintenant avec les mesures : même offset ?
f_im = moydeg(f2,-alpha,6,61,61,0.5,0.5);

end

