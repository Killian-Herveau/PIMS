function [ y ] = polycalc( x,p )
%x = série de x à calculer
%p = params
%Renvoie le polynôme
y=0;
for i=1:length(p)
    y=y+p(i,1)*x.^(i-1);
end

end

