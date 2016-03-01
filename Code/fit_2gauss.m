function [ p ] = fit_2gauss(img)
%: renvoie les coefficients correspondant à l'approximation de deux
%gaussiennes sur une image, avec offset
%de la forme y=A+Bexp((x-D)^2)/(2s*s)   + A'+B'exp((x-D')^2)/(2s'*s')
%Entrees:
%   img: données à approximer
%Sortie:
%   p0: coefficients autours desquels on va chercher la bonne approximation
%       p0(1) -> offset selon y => A
%       p0(2) -> amplitude B
%       p0(3) -> moyenne D
%       p0(4) -> ecart type s
%%
[x,y]=size(img);
col=mean(img); %moyenne sur les colonnes
lines=mean(img');


%Calcul des coefficients probables pour la première gaussienne
p0(1)=min(y);
[p0(2),i]=max(y);
p0(2)=p0(2)-min(y);
p0(3)=x(i);
%variance: on trouve le x correspondant a la moitié du maximum
j=i;
while (y(j)>y(i)/2) && (j<length(y))
    j=j+1;
end 
p0(4)=sqrt(((x(j)-p0(3))^2)*log(2*p0(2)/(p0(2)-p0(1)))/2); 


p=lsqnonlin(@(p)(y-p(1)-p(2)*exp(-((x-p(3)).^2)./(2*p(4)*p(4)))),p0);

end