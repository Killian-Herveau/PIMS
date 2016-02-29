function [ img ] = approxsinc(x,y,p0)
%approxsinc: renvoie les coefficients correspondant à l'approximation d'un sinus cardinal
%de la forme y=A+Bsin(C(x-D))/(C(x-D))
%Entrees:
%   x et y: données à approximer
%   p0: coefficients autours desquels on va chercher la bonne approximation
%       p0(1) -> offset selon y
%       p0(2) -> constante multiplicative du sinus
%       p0(3) -> coefficient dans le sinus, multipliant x-p(4)
%       p0(4) -> offset selon x
%%

img=lsqnonlin(@(p)Rgauss(x,y,p),p0)
plot(

end

