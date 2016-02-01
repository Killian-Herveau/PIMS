%%
%acquisition des données de calibration
alpha=11.2;
% img=imdata(1,900,1);
imgcal=zeros(120,120,15);
fcal=zeros(74,15);
for i=1:15
    imgcal(:,:,i)=imdata2(0,(i-1)*100);
    ftemp=frange_detect(imgcal(:,:,i),alpha);
    fcal(:,i)=fourier2pol(ftemp);
end
%%
%Acquisition des données à traiter
img = imdata2(1,300,10);
ftemp = frange_detect(img,alpha);
f = fourier2pol(ftemp);
plot(1:length(ftemp),ftemp);hold on
f2=frange_detect(imgcal(:,:,1),alpha);
plot(1:length(f2),f2);
legend('mesure','calib 0');
%%
%comparaison

for i=1:15
    corr(fcal(:,i),f)
    (i-1)*100
end
