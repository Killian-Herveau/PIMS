load ../Airy_freq
X_F=spl_freq(0:1:1400);
X_A=spl_airy(0:1:1400);
alpha=11.2;
c=3.24675;
z=zeros(1,75);
figure
plot(X_A,X_F)
f=700;
for i=1:75
    figure(1)
    img=imdata2(1,f,i);
    
    p=img_maxfourier2(img,alpha);
    p_g=find_the_gauss(img);
    %%%%CONVERSIONS%%%%
    p(7)=p(7)./(c*120);
    p_g(5)=p_g(5)/c;
    %%%%%%%%%%%%%%%%%%
    z(i)=Splineproj([p_g(5),p(7)],spl_airy,spl_freq,0.01);
    hold on
    plot(p_g(5),p(7),'o','Color',[0,0,1]);
end

for i=0:100:1400
    plot(spl_airy(i),spl_freq(i),'+','Color',[0,0,0],'MarkerSize',10);
    
end
 figure
 plot(1:length(z),z);
 title(['Z=',num2str(f)]);