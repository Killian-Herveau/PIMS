% figure
%SUR UNE même LIGNE les deux pics portent la même info DONC on peut les
%moyenner.
alpha=11.2;
pas=25;
k=0;
p=zeros(4,1+1400/pas);
pos_0=zeros(1,1+1400/pas);
par_gauss=zeros(5,1+1400/pas);
for i=0:pas:1400
    img=imdata2(0,i);
%     [x,y]=findXY(img); pas besoin dans fourier l'origine des freq est
%     pile au centre, c'est tout ce qu'on a besoin de savoir
%   
    k=k+1;
    [p(:,k),pos_0(k)]=img_maxfourier2(img,alpha);
    %On choppe la taille de la gaussienne
    par_gauss(:,k)=find_the_gauss(imdata(0,i));
%     plot(1:length(f1),f1,'g');hold on
%     plot(1:length(f2),f2,'r');hold on
end
%smoother les deux courbes 
%On trace la courbe sigma = f(maxfourier)
% étant donné un point, trouver le plus proche point de la courbe.
spl_Garry=createFitSpl(0:ceil(1400/(length(p(1,:)))):1400,p(1,:)',0.00001);figure;
plot(spl_Garry,'g');hold on
plot(0:ceil(1400/(length(p(1,:)))):1400,p(1,:),'r');title('position de Garry en fonction de z');
figure
spl_Bob=createFitSpl(0:ceil(1400/(length(p(1,:)))):1400,par_gauss(5,:)',0.00001);
plot(spl_Bob,'g');hold on
plot(0:ceil(1400/(length(p(1,:)))):1400,par_gauss(5,:));title('Taille Tâche d''Airy en fonction de z');

figure;
X_G=spl_Garry(0:1:1400);
X_B=spl_Bob(0:1:1400);

plot(X_B,X_G);title('sigma en fonction de la fréquence max');
xlabel('Sigma');ylabel('Freq max');
%THAT IS THE BONNE COURBE ! maintenant, à partir des coord (taille tâche + max freq)
%on doit pouvoir trouver le plus proche point de la courbe = indertermination levée

%  plot(0:ceil(1400/(length(p(1,:)))):1400,p(2,:));hold on
%plot(0:pas:1400,(p(3,:)+p(4,:))/2);
% plot(0:ceil(1400/(length(p(1,:)))):1400,p(1,:),'r');hold on
% plot(0:ceil(1400/(length(p(2,:)))):1400,p(2,:));%title('répartition de la position de max des freq en fonction de z avec alpha = 11.2');
% legend('première moitiée','seconde moitiée');
% 
% plot(0:pas:1400,p(3,:));hold on
% plot(0:pas:1400,p(4,:));title('répartition de la position de max des freq en fonction de z');
% legend('première moitiée 11.2','seconde moitiée 11.2','première moitiée 11.2-90','seconde moitiée 11.2-90');