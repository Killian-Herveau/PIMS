% figure
%SUR UNE m�me LIGNE les deux pics portent la m�me info DONC on peut les
%moyenner.
alpha=11.2;
pas=100;
k=0;
p=zeros(4,1+1400/pas);

for i=0:pas:1400    
    img=imdata2(0,i);
%     [x,y]=findXY(img); pas besoin dans fourier l'origine des freq est
%     pile au centre, c'est tout ce qu'on a besoin de savoir
    k=k+1;
    p(:,k)=img_maxfourier2(img,alpha);

%     plot(1:length(f1),f1,'g');hold on
%     plot(1:length(f2),f2,'r');hold on
end
% c12=abs(c12-length(f1)/2);
% c22=abs(c22-length(f2)/2);

figure
plot(0:ceil(1400/(length(p(1,:)))):1400,(p(1,:)+p(2,:))/2,'r');hold on
plot(0:pas:1400,(p(3,:)+p(4,:))/2);
% plot(0:ceil(1400/(length(p(1,:)))):1400,p(1,:),'r');hold on
% plot(0:ceil(1400/(length(p(2,:)))):1400,p(2,:));%title('r�partition de la position de max des freq en fonction de z avec alpha = 11.2');
% legend('premi�re moiti�e','seconde moiti�e');
% 
% plot(0:pas:1400,p(3,:));hold on
% plot(0:pas:1400,p(4,:));title('r�partition de la position de max des freq en fonction de z');
% legend('premi�re moiti�e 11.2','seconde moiti�e 11.2','premi�re moiti�e 11.2-90','seconde moiti�e 11.2-90');