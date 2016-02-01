function [ ypol,p,spl ] = fourier2pol( f )%le x est à remettre
%Smoothe la courbe de fourier et renvoie la série de données correspondant
%au fit polynômial, les coeffs du polynôme et la spline.
%la courbe de fourier doit être déjà prédécoupée tout bien comme il faut
%   x = n° pixel des échantillons
%   f = valeur du pixel de la TF
%%
%x=33:106;%là où se trouvent les freq d'intérêt en gros
f1=f;
x=1:length(f);  
% [m,mpos]=max(f1);%position dans le tableau de f1
% mpos = mpos + 33;%on a sélectionné entre 33 et 106, donc il faut rajouter 33
%%
%Création du smooth spline

%spl est un 'cfit'
spl=createFitSpl(x,f1); 
%cette ligne permet d'extraire les valeurs de la spline
t=spl(x);

%%
% Fit polynômial
d(:,1)=x';
d(:,2)=t;
[ypol,p]=approxpol2(d,30,1);

% pder=derivepol(p);%Calcul de la dérivée
% r=real(roots(flipud(pder)));
% 
% val = mpos; %value to find
% tmp = abs(r-val);
% [idx id] = min(tmp); %index of closest value
% closest = r(id); %closest value
end

