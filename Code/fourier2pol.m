function [ ypol,p,spl ] = fourier2pol( f )%le x est � remettre
%Smoothe la courbe de fourier et renvoie la s�rie de donn�es correspondant
%au fit polyn�mial, les coeffs du polyn�me et la spline.
%la courbe de fourier doit �tre d�j� pr�d�coup�e tout bien comme il faut
%   x = n� pixel des �chantillons
%   f = valeur du pixel de la TF
%%
%x=33:106;%l� o� se trouvent les freq d'int�r�t en gros
f1=f;
x=1:length(f);  
% [m,mpos]=max(f1);%position dans le tableau de f1
% mpos = mpos + 33;%on a s�lectionn� entre 33 et 106, donc il faut rajouter 33
%%
%Cr�ation du smooth spline

%spl est un 'cfit'
spl=createFitSpl(x,f1); 
%cette ligne permet d'extraire les valeurs de la spline
t=spl(x);

%%
% Fit polyn�mial
d(:,1)=x';
d(:,2)=t;
[ypol,p]=approxpol2(d,30,1);

% pder=derivepol(p);%Calcul de la d�riv�e
% r=real(roots(flipud(pder)));
% 
% val = mpos; %value to find
% tmp = abs(r-val);
% [idx id] = min(tmp); %index of closest value
% closest = r(id); %closest value
end

