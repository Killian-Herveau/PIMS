function [ id ] = smooth_max2( f )
%f est la fonction dont on veut trouver la position du smooth_max
%smooth_max va lisser avec une spline, trouver son equation polynomiale et trouver
%analytiquement ses racines
% [y,p]=fourier2pol(f); % bad idea
[z,zz]=max(f);
if(zz<121)
    x=47-40:47+40;%c'est arbitraire, c'est pour voir mieux où est le max et améliorer le fit
else
    x=192-40:192+40;
end
f1=f(x);
%spl est un 'cfit'
spl=createFitSpl(x,f1');
%cette ligne permet d'extraire les valeurs de la spline
t=spl(x);
pp=fit_gauss(x',t);
id=pp(3);

% plot(t);

% G=gaussian_offset(pp(1),pp(2),pp(3),pp(4),x);
% plot(x,G);hold on
% 
% plot(x,t);
% plot(pp(3),t(round(pp(3)-33)),'+');
% [m,mpos]=max(f);%position dans le tableau de f1
% mpos = mpos + 33;%on a sélectionné entre 33 et 106, donc il faut rajouter 33
% 
% 
% pder=derivepol(p);%Calcul de la dérivée
% r=real(roots(flipud(pder)));
% %flip up down, renverse le vecteur pour que les coefficients 
% %soient dans le bon sens pour roots
% 
% 
% tmp = abs(r-mpos);%on enlève mpos aux racines et valeur absolue
% %=> la valeur la plus proche de 0 est donc la bonne
% [id id] = min(tmp); %position de la plus proche valeur
% fmax = r(id); %la position du max


end

