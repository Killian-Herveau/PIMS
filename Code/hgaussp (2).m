function [img] = hgauss(dim,c,a,s,offset,k)
% Renvoie une hypergaussienne 2d
%
%ENTREES:
% img: image
% dim = size(img)
% c: centre de la gaussienne 2d (x,y)
% s: écart-type
% offset : offset
% k: degre de la gaussienne, pair
% SORTIES/
% img: hypergaussienne
%%
x=dim(1);
y=dim(2);

img=zeros(y,x);
for i=1:y
    for j=1:x
        img(i,j)=offset+a*exp(-(((i-c(1))^2+(j-c(2))^2)^k)/(2*s^(2*k)));
    end
end

%   imshow(img,'DisplayRange',[min(img(:)) max(img(:))],'InitialMagnification','fit');
    

end