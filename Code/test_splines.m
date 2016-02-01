%%
%acquisition des données
alpha=11.2;
% img=imdata(1,900,1);
img=imdata(0,700);
img=masque_rephase(img);
f=frange_detect(img,alpha);

x=33:106;
f1=f(length(f)/2:length(f));%freq positives en coupant au milieu
f1=f1(x);
[m,mpos]=max(f1);%position dans le tableau de f1
mpos = mpos + 33;%on a sélectionné entre 33 et 106, donc il faut rajouter 33
figure
plot(x,f1,'g');hold on
% en vrai, on a fait un donut de taille 18
% il faut donc ignorer ces pixels dans le fit(les longueurs ne sont plus les
% bonnes en terme de pixel à cause du resampling de moydeg)
%pareil pour px>50

%%
%Création du smooth spline

%spl est un 'cfit'
spl=createFitSpl(x,f1); 
% plot(spl,x,f1);figure
%cette ligne permet d'extraire les valeurs de la spline
t=spl(x);
[m id] = max(t);
id=id/10;
pp=fit_gauss(x',t);
G=gaussian_offset(pp(1),pp(2),pp(3),pp(4),x);
plot(x,G);


%%
% Fit polynômial
% d(:,1)=x';
% d(:,2)=t;
% [y,p]=approxpol2(d,30);
% 
% pder=derivepol(p);%Calcul de la dérivée
% r=real(roots(flipud(pder)));
% 
% val = mpos; %value to find
% tmp = abs(r-val);
% [idx id] = min(tmp); %index of closest value
% closest = r(id); %closest value
% 
% % x2=33:0.1:90;
% % yder=polycalc(x2,pder);%tracé de la dérivée
% % hold on
% % plot(r(id),polycalc(r(id),p),'+');

%%
% figure
% plot(x,f1,'g');hold on;plot(x,t);
% xlabel x;ylabel f1;grid on
% legend('f1 vs. x', 'fit', 'Location', 'NorthEast' );
% spl=spl(1:length(f1));
% plot(1:length(f1),spl);
