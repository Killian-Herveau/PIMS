function [ y ] = polycalc( x,p )
%x = s�rie de x � calculer
%p = params
%Renvoie le polyn�me
y=0;
for i=1:length(p)
    y=y+p(i,1)*x.^(i-1);
end

end

