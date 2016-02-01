function [ out ] = derivepol( p )
% p : coefficients du polynôme à dériver dans l'ordre croissant
% coefficients du polynôme dérivé

out=zeros(length(p)-1,1);
for i=length(p)-1:-1:1
    out(i)=i*p(i+1);
end