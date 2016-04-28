% figure
%SUR UNE m�me LIGNE les deux pics portent la m�me info DONC on peut les
%moyenner.
k=0;
c=3.24675;
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
%converti en �m
par_gauss(5,:)=par_gauss(5,:)/c;
%p�riode en �m et airy en �m
%taille pixel : 3,24675�m
%frequence(m�tres)=frequence(pixel)/cN
%%% Passer en Fr�quence spatiale %%%
p(7,:)=p(7,:)./(c*120);
%%%% Passer en P�riode spatiale %%%%
% p(7,:)=c*120/p(7,:);
%%%%%%% Passer en px/franges %%%%%%%
% p(7,:)=120./p(7,:);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
figure;
spl_freq=createFitSpl(0:ceil(1400/(length(p(1,:)))):1400,p(7,:),0.00001);
plot(spl_freq,'g');hold on
plot(0:ceil(1400/(length(p(1,:)))):1400,p(7,:),'r+');title('Position de fmax en fonction de z');
ylabel('Freq max (1/�m)');xlabel('Profondeur (nm)');

figure
spl_airy=createFitSpl(0:ceil(1400/(length(p(1,:)))):1400,par_gauss(5,:),0.00001);
plot(spl_airy,'g');hold on
plot(0:ceil(1400/(length(p(1,:)))):1400,par_gauss(5,:),'r+');title('Taille T�che d''Airy en fonction de z');
ylabel('Sigma (�m)');xlabel('Profondeur (nm)');

figure;
X_F=spl_freq(0:1:1400);
X_A=spl_airy(0:1:1400);
plot(par_gauss(5,:),p(7,:),'r+');
hold on
plot(X_A,X_F);title('Fr�quence max en fonction de sigma');
xlabel('Sigma (�m)');ylabel('Freq max (1/�m)');

%THAT IS THE BONNE COURBE ! maintenant, � partir des coord (taille t�che + max freq)
%on doit pouvoir trouver le plus proche point de la courbe = indertermination lev�e