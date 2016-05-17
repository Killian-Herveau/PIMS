function [barycentre] = determination_bar(im_seuil)
%Determine le barycentre de chaque élément indépendant contenu dans l'image
%en entrée
%ENTREE : im_seuil image en noir et blanc contenant plusieurs zone distance
%           dont on cherche les barycentres
%SORTIE : barycentre (2*n double) position [x;y] des barycentre des n zones
%           distinctes trouvée


im_seuil = bwmorph(im_seuil, 'majority', Inf);

im_seuil= edge(im_seuil, 'canny', [0.1 0.5],3);

[L,num] = bwlabel(im_seuil,8);
barycentre = zeros(2,num);
for ii=1:num
    im_seuil=(L==ii);
    [y,x] = find(im_seuil);
    barycentre(1,ii) = mean(x);
    barycentre(2,ii) = mean(y);
end




