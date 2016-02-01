function [ image2 ] = removegauss(img)
% enleve une gaussienne 2D presente sur l'image
%le max de l'image doit correspondre à une gaussienne

%ENTREES:
% 

% SORTIES/
% 


%on cherche le centre de la gaussienne
[x y]=size(img);

%Calcul des coefficients probables
p0(1)=min(min(img))
[poubelle,imaxs]=max(img);
[p0(2) p0(4)]=max(max(img));
maximg=p0(2);
p0(3)=imaxs(p0(4));
p0(2)=p0(2)-p0(1);

%variance: on trouve le x correspondant a la moitié du maximum, sur une ligne
k=p0(3);
while (img(k,p0(4))>maximg) & (k<length(img))
    k=k+1;
end 
p0(5)=sqrt(((k-p0(3))^2)*log(2*p0(2)/(p0(2)-p0(1)))/2); 
    
p=fit_gauss2D(img);
gauss=hgaussp([x y],[p(3) p(4)],p(2),p(5),p(1),1);
image2=img-gauss;
% imshow2(image2)

end

