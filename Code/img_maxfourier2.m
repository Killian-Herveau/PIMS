function [ pos] = img_maxfourier2( img,alpha )
%retourne le max des franges qui nous intéresse
%supposant qu'img a été traitée
[f1, pas]=frange_detect(img,alpha);
f2=frange_detect(img,-90+alpha);
% plot(-length(f1)/2:length(f1)/2-1,f1);
%%
%sépare en deux la représentation de fourier et prend le max de part et
%d'autre
f12=zeros(length(f1),1);
f11=zeros(length(f1),1);
f22=zeros(length(f1),1);
f21=zeros(length(f1),1);

f12(ceil(length(f1)/2):length(f1))=f1(ceil(length(f1))/2:length(f1)); %freq positives
f11(1:ceil(length(f1)/2))=f1(1:ceil(length(f1)/2)); %freq 'négatives'

f12(ceil(length(f1)/2):length(f1))=f1(ceil(length(f1))/2:length(f1)); %freq positives
f11(1:floor(length(f1)/2))=f1(1:floor(length(f1)/2)); %freq 'négatives'

f22(ceil(length(f2)/2):length(f2))=f2(ceil(length(f2))/2:length(f2)); %freq positives
f21(1:floor(length(f2)/2))=f2(1:floor(length(f2)/2)); %freq 'négatives'

    pos(1)=abs(121-smooth_max2(f11))*pas;
    pos(2)=abs(121-smooth_max2(f12))*pas;
    pos(3)=abs(121-smooth_max2(f21))*pas;
    pos(4)=abs(121-smooth_max2(f22))*pas;
    pos(5)=(pos(1)+pos(2))/2;
    pos(6)=(pos(3)+pos(4))/2;
    pos(7)=(pos(5)+pos(6))/2;
    plot(f22);
end