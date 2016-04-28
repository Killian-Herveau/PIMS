function [img] = hgaussp2(dim,p,k)
% Renvoie une hypergaussienne 2d et recoit un vecteur de parametres p
% pour k=1 on a une gaussienne
%ENTREES:
% dim: les dimensions de l'image
%   p0: coefficients autours desquels on va chercher la bonne approximation
%   //SORTIE//
%       p(1) -> offset selon y => A
%       p(2) -> amplitude
%       p(3) -> moyenne (horizontale)
%       p(4) -> moyenne (verticale)
%       p(5) -> ecart-type
% k puissance de la gaussienne
% SORTIES/
% img: hypergaussienne
%%
x=dim(1);
y=dim(2);

img=zeros(y,x);
for i=1:y
    for j=1:x
        img(i,j)=p(1)+...
            p(2)*exp(-(((i-p(3))^2+...
            (j-p(4))^2)^k)/...
            (2*p(5)...
            ^(2*k)));
    end
end

%   imshow(img,'DisplayRange',[min(img(:)) max(img(:))],'InitialMagnification','fit');
    

end