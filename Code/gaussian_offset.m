function [ G ] = gaussian_offset( offset,A,mu,sigma,x )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

G=A*exp(-(x-mu).^2/(2*sigma^2))+offset;

end

