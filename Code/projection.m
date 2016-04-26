pas=50
opif=[5,80];
pos_min=0;
X_B=spl_Bob(0:pas:1400);
X_G=spl_Garry(0:pas:1400);
for i=0:1
    if i==1
if pos_min-20>0
    pos_minimum=0;
else
    pos_minimum=pos_min*pas-20;
end

if pos_min+20<1400/pas
    pos_maximum=1400;
else
    pos_maximum=pos_min*pas+20;
end

X_B=spl_Bob(pos_minimum:0.2:pos_maximum);
X_G=spl_Garry(pos_minimum:0.2:pos_maximum);
    end
figure
plot(X_B,X_G);hold on
plot(opif(1),opif(2),'x');

mat=[X_B-opif(1),X_G-opif(2)];
distance = sqrt(mat(:,1).^2+mat(:,2).^2); 
[minosef,pos_min]=min(distance);
X_B(pos_min)
X_G(pos_min)
end