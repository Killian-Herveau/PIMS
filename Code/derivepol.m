function [ out ] = derivepol( p )
% p : coefficients du polyn�me � d�river dans l'ordre croissant
% coefficients du polyn�me d�riv�

out=zeros(length(p)-1,1);
for i=length(p)-1:-1:1
    out(i)=i*p(i+1);
end