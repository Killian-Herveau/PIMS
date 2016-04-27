% figure
%SUR UNE m�me LIGNE les deux pics portent la m�me info DONC on peut les
%moyenner.
k=0;
alpha=11.2;
pas=25;
p=zeros(7,1+1400/pas);
pos_0=zeros(1,1+1400/pas);
par_gauss=zeros(5,1+1400/pas);

for i=0:pas:1400
    img=imdata2(0,i);
%     [x,y]=findXY(img); pas besoin dans fourier l'origine des freq est
%     pile au centre, c'est tout ce qu'on a besoin de savoir

    k=k+1;
    p(:,k)=img_maxfourier2(img,alpha);
    %On choppe la taille de la gaussienne
    par_gauss(:,k)=find_the_gauss(imdata(0,i));
%     plot(1:length(f1),f1,'g');hold on
%     plot(1:length(f2),f2,'r');hold on
end
%smoother les deux courbes 
%On trace la courbe maxfourier = f(sigma)
%%
spl_Garry=createFitSpl(0:ceil(1400/(length(p(1,:)))):1400,p(7,:),0.00001);figure;
plot(spl_Garry,'g');hold on
plot(0:ceil(1400/(length(p(1,:)))):1400,p(7,:),'r');title('position de f_max en fonction de z');

figure
spl_Bob=createFitSpl(0:ceil(1400/(length(p(1,:)))):1400,par_gauss(5,:),0.00001);
plot(spl_Bob,'g');hold on
plot(0:ceil(1400/(length(p(1,:)))):1400,par_gauss(5,:));title('Taille T�che d''Airy en fonction de z');

figure;
X_G=spl_Garry(0:1:1400);
X_B=spl_Bob(0:1:1400);

plot(X_B,X_G);title('sigma en fonction de la fr�quence max');
xlabel('Sigma (px)');ylabel('Freq max (1/px)');

%THAT IS THE BONNE COURBE ! maintenant, � partir des coord (taille t�che + max freq)
%on doit pouvoir trouver le plus proche point de la courbe = indertermination lev�e