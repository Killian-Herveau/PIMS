load ../Airy_freq
X_F=spl_freq(0:1:1400);
X_A=spl_airy(0:1:1400);
alpha=11.2;
i=1;
z=zeros(1,50);
figure
plot(X_A,X_F)
f=300;

 for i=1:75
     figure(1)
    img=imdata2(1,f,i);
    
    p=img_maxfourier2(img,alpha);
    p_g=find_the_gauss(img);
    z(i)=Splineproj([p_g(5),p(7)],spl_airy,spl_freq,0.01);
    hold on
    plot(p_g(5),p(7),'o');
 end
 figure
 plot(1:length(z),z);