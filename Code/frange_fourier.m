%%
%Ce script détermine la position du centre de la gaussienne correspondant à
%la répartition de la composante fréquentielle de 3px/frange
%(échantillonnage du signal d'intérêt)
%%
x=120;y=120;
z=120;
K=zeros(x,y,15);
C=zeros(x,y,15);
t=zeros(z,15);
t1=zeros(z,15);
t2=zeros(z,15);
p=zeros(4,15);
owe=zeros(15,1);
lambda=1000000;
alpha=-11.2;figure
maxou=zeros(15,1);
pos=zeros(15,1);
G=hgaussp([x,y],[61,61],1,20,0,1);

for i=1:15
    K(:,:,i)=bin2mat(name_Z('..\..\Projet 2A\Mesures\STACK=0000_IM=00130_Z=',(i-1)*100));
    C(:,:,i)=bin2mat(name_Z('..\..\Projet 2A\Calibration\STACK=0001_IM=00001_Z=',(i-1)*100));
    K(:,:,i)=masque_rephase(K(:,:,i));
    C(:,:,i)=masque_rephase(C(:,:,i));%on ouvre, on traite les images
%     K(:,:,i)=abs(FiltreWiener(G,K(:,:,i),lambda));%on déconvolue
    K(:,:,i)=C(:,:,i)-K(:,:,i);
    %%
    %ADRIEN si tu veux afficher les images, met un imshow2 ici et commente plus bas le plot 
    %%
    t(:,i)=(moydeg(K(:,:,i),alpha,4,61,61,1,120/z)+moydeg(K(:,:,i),90-alpha,4,61,61,1,120/z))/2;
    t1(:,i)=abs(fftshift(fft(t(:,i))));
    p(:,i)=fit_gauss(1:z,t1(:,i)');
    t2(:,i)=t1(:,i)-gaussian_offset(p(1,i),p(2,i),p(3,i),p(4,i),1:z)'; 
    o=z/2;
    
    %     [maxou(i),pos(i)]=max(t1([1:o-15 o+15:z],i));
    owe(i)=(t1(o+41,i));
    plot(t2([1:o-15 o+15:z],i));hold on
% plot(t2(:,i));hold on
end

% for i=1:15
%     figure;imshow2(K(:,:,i));title({'n°',num2str((i-1)*100)});
% end
% 
legend(num2str(0),num2str(100),num2str(200),num2str(300),...
    num2str(400),num2str(500),num2str(600),num2str(700),...
    num2str(800),num2str(900),num2str(1000),num2str(1100),...
    num2str(1200),num2str(1300),num2str(1400));

l=fit_gauss(1:15,owe');figure %fit gaussien de la courbe nu=f(Z)
plot(0:100:1400,gaussian_offset(l(1),l(2),l(3),l(4),1:15));
hold on;plot(0:100:1400,owe);title(['Stack : 130 ','pixel N°',num2str(o+41),' Z = ', num2str((l(3)-1)*100)]);

% figure;plot(0:100:1400,maxou);title('max stack : 80');hold on
% figure;plot(0:100:1400,pos);title('position du max stack : 80');