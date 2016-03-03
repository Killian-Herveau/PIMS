
C=zeros(120,120,56);
t=zeros(120,56);
t1=zeros(120,56);
x=1:120;
lambda=1000000;
alpha=-11.2;figure
maxou=zeros(56,1);
pos=zeros(56,1);
t2=zeros(120,56);
p=zeros(4,56);
minou=zeros(56,1);
owe=zeros(56,1);
for i=1:56
    C(:,:,i)=bin2mat(name_Z('..\..\Projet 2A\Calibration\STACK=0001_IM=00001_Z=',(i-1)*25));
    C(:,:,i)=masque_rephase(C(:,:,i));
%     C(:,:,i)=abs(FiltreWiener(C(:,:,i),C(:,:,i),lambda));
    t(:,i)=moydeg(C(:,:,i),alpha,5,61,61);
    t1(:,i)=abs(fftshift(fft(t(:,i))));
%     t1([1:35,90:120],i)=0;

    p(:,i)=fit_gauss(x,t1(:,i)');
    t2(:,i)=t1(:,i)-gaussian_offset(p(1,i),p(2,i),p(3,i),p(4,i),1:120)';
%     plot(t2([1:42,78:120],i));
    plot(t2(:,i));
    hold on
    owe(i)=t1(61+40,i);
%     [maxou(i),pos(i)]=max(t2(61+38:61+42,i));
%     minou(i)=min(t1(:,i));
end

% legend(num2str(0),num2str(100),num2str(200),num2str(300),...
%     num2str(400),num2str(500),num2str(600),num2str(700),...
%     num2str(800),num2str(900),num2str(1000),num2str(1100),...
%     num2str(1200),num2str(1300),num2str(1400));
figure
l=fit_gauss(1:56,owe');
plot(0:25:1375,gaussian_offset(l(1),l(2),l(3),l(4),1:56));hold on;
plot(0:25:1375,owe);title({'plot valeur du point n°101, centre: ',num2str((l(3)-1)*25)});  
% plot(0:25:1375,maxou);title('plot du max de chaque TF rebond');figure
% figure;plot(0:25:1375,pos);title('plot de l''emplacement du max');
% plot(0:100:1375,minou);title('plot du min de chaque TF');