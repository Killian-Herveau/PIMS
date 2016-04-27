function [ spl_airy,spl_freq,X_A,X_F ] = createCal( alpha,plot )
%Pour chaque image de calibration :
%-analyse des 4 t�ches en fourier, moyennage deux � deux puis moyennage
%total pour les courbes finales (de p(1,x) � p(7,x)), cr�e une spline de 
%f_max=f(z)
%-calcule la taille de la gaussienne �quivalente, cr�e une spline de 
%sigma=f(z)
%plot: affichage des courbes (mettre 1 pour les afficher, rien sinon)
%
k=0;
alpha=11.2;
pas = 25;
p=zeros(7,1+1400/pas);
par_gauss=zeros(5,1+1400/pas);

for i=0:pas:1400
k=k+1;
    img=imdata2(0,i);
    %les max en fourier
    p(:,k)=img_maxfourier2(img,alpha);
    %taille de la gaussienne �quivalente
    par_gauss(:,k)=find_the_gauss(imdata(0,i));
end

%% Cr�ation des Splines
spl_freq=createFitSpl(0:ceil(1400/(length(p(1,:)))):1400,p(7,:),0.00001);
spl_airy=createFitSpl(0:ceil(1400/(length(p(1,:)))):1400,par_gauss(5,:),0.00001);
X_F=spl_freq(0:1:1400);
X_A=spl_airy(0:1:1400);
if exist('plot','var')
%% PLOTS
% Maximum des fr�quences
figure
plot(spl_freq,'g');hold on
plot(0:ceil(1400/(length(p(1,:)))):1400,p(7,:),'r');title('position du max(Freq) en fonction de z');

%taille t�che Airy (sigma)
figure
plot(spl_airy,'g');hold on
plot(0:ceil(1400/(length(p(1,:)))):1400,par_gauss(5,:));title('Taille T�che d''Airy en fonction de z');

%freqmax=f(sigma)
figure
X_F=spl_freq(0:1:1400);
X_A=spl_airy(0:1:1400);
plot(X_A,X_F);title('Fr�quence max en fonction de la taille de la t�che d''Airy');
xlabel('Sigma');ylabel('Freq max');
end
end

