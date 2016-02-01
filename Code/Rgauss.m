function [ R ] = Rgauss(x,y,p0)
R=y-p0(1)-p0(2)*exp(-((x-p0(3)).^2)./(2*p0(4)*p0(4)));
end