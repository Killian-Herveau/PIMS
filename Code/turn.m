% figure
%SUR UNE même LIGNE les deux pics portent la même info DONC on peut les
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
%converti en µm
par_gauss(5,:)=par_gauss(5,:)/c;
%période en µm et airy en µm
%taille pixel : 3,24675µm
%frequence(mètres)=frequence(pixel)/cN
%%% Passer en Fréquence spatiale %%%
p(7,:)=p(7,:)./(c*120);
%%%% Passer en Période spatiale %%%%
% p(7,:)=c*120/p(7,:);
%%%%%%% Passer en px/franges %%%%%%%
% p(7,:)=120./p(7,:);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
figure;
spl_freq=createFitSpl(0:ceil(1400/(length(p(1,:)))):1400,p(7,:),0.00001);
plot(spl_freq,'g');hold on
plot(0:ceil(1400/(length(p(1,:)))):1400,p(7,:),'r+');title('Position de fmax en fonction de z');
ylabel('Freq max (1/µm)');xlabel('Profondeur (nm)');

figure
spl_airy=createFitSpl(0:ceil(1400/(length(p(1,:)))):1400,par_gauss(5,:),0.00001);
plot(spl_airy,'g');hold on
plot(0:ceil(1400/(length(p(1,:)))):1400,par_gauss(5,:),'r+');title('Taille Tâche d''Airy en fonction de z');
ylabel('Sigma (µm)');xlabel('Profondeur (nm)');

figure;
X_F=spl_freq(0:1:1400);
X_A=spl_airy(0:1:1400);
plot(par_gauss(5,:),p(7,:),'r+');
hold on
plot(X_A,X_F);title('Fréquence max en fonction de sigma');
xlabel('Sigma (µm)');ylabel('Freq max (1/µm)');

%THAT IS THE BONNE COURBE ! maintenant, à partir des coord (taille tâche + max freq)
%on doit pouvoir trouver le plus proche point de la courbe = indertermination levée