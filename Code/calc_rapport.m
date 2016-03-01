function [ rapport ] = calc_rapport( interfrange )
%Détermine le rapport p/lambda à partir des images de calibration par
%approximation polynomiale (on a z= p/lambda * interfrange)
%     z : vecteur contenant toutes les profondeurs (incrémentées de 25 en 25)
%     interfrange : vecteur contenant les valeurs d'interfrange
%     correspondantes
z = transpose([0 : 25 : 1375]); %vecteur contenant toutes les profondeurs (incrémentées de 25 en 25)
D = 1;  %degré du polynome d'approximation
d=size(interfrange);
d1=d(1,1);
F=zeros(D, d1);
for i=0:D
    for j=0:d1-1
        F(i+1,j+1)=interfrange(j+1)^i;
    end
end
A=F*transpose(F);
b=F*z;
p=A\b;
y1=0;
for i=1:D+1
    y1=y1+p(i,1)*interfrange.^(i-1);
end
rapport = p(2,1);
end

