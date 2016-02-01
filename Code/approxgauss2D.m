function [ p ] = approxgauss2D(data,p0,dim_h,dim_v)
%approxsinc: renvoie les coefficients correspondant � l'approximation d'une
%gaussienne avec offset
%de la forme y=A+Bexp((x-D)^2)/(2s*s)
%Entrees:
%   x et y: donn�es � approximer
%   p0: coefficients autours desquels on va chercher la bonne approximation
%       p0(1) -> offset
%       p0(2) -> amplitude
%       p0(3) -> moyenne (horizontale)
%       p0(4) -> moyenne (verticale)
%       p0(5) -> �cart-type
%%
options = optimoptions('lsqnonlin','Jacobian','on');
p=lsqnonlin(@(p)Rgauss2D(data,p,dim_h,dim_v),p0);

end

