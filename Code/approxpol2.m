function [ y1,p ] = approxpol2( data, D,k )
%data doit être un vecteur 2 colonnes et plein de lignes
%   D= degré du polynome

x=data(:,1);
y=data(:,2);
d=size(x);
d1=d(1,1);
F=zeros(D, d1);
for i=0:D
    for j=0:d1-1
        F(i+1,j+1)=x(j+1)^i;
    end
end
A=F*transpose(F);
b=F*y;
p=A\b;
y1=0;
for i=1:D+1
    y1=y1+p(i,1)*x.^(i-1);
end

if (exist('k','var'))
    if(k==1)
        figure;
        plot(x,y1);
        title(['degré : ',num2str(D)]);
        hold on;
        plot(x,y);
        legend('approximation','data');
    end
end
end


