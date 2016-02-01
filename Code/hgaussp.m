function [img] = hgaussp(dim,c,a,s,offset,k)
% Renvoie une hypergaussienne 2d
%
%ENTREES:
% img: image
% dim = size(img)
% c: centre de la gaussienne 2d (x,y)
% a: amplitude
% s: écart-type
% k: degre de la gaussienne, pair
% offset : offset
% SORTIES/
% img: hypergaussienne
%%
y=dim(1);
x=dim(2);

img=zeros(y,x);
for i=1:y
    for j=1:x
        img(i,j)=offset+a*exp(-(((i-c(1))^2+(j-c(2))^2)^k)/(2*s^(2*k)));
    end
end

%   imshow(img,'DisplayRange',[min(img(:)) max(img(:))],'InitialMagnification','fit');
    

end