function [ G ] = gaussian_offset( offset,A,mu,sigma,x )
%A= amplitude

G=A*exp(-(x-mu).^2/(2*sigma^2))+offset;

end

