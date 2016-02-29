function [S] = antecedent(ordonnee,data)
% Renvoie de façon discrète le ou les antécédents numeriques d'une fonction discrete
% Pour se faire on approxime data par un polynome de degre 9, on resout le systeme
% on renvoit l'antecedent discret le plus proche de l'antecedent numerique
%Entree:
% ordonnee: valeur dont on cherche l'antecedent
%  data: vecteur à une dimension correspondant a la courbe


[maxi,maxp]=max(data);
[mini,minp]=min(data);
if(ordonnee>maxi)
    'Erreur: antecedent: l''ordonnee depasse les valeurs atteignables'
    return;
end
if(ordonnee<mini)
    'Erreur: antecedent: les valeurs atteignables depassent l''ordonne'
    return;
end
D=[1:length(data),data]
p=approxpol2(D,9,1);
S := solve(p(10)*x^9+p(9)*x^8+p(8)*x^7+p(7)*x^6+p(6)*x^5+p(5)*x^4 + p(4)*x^3 + p(3)*x^2 + p(2)*x + p(1)- ordonnee= 0, x)
S=round(S);



end

