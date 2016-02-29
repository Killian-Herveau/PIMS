function [ pos ] = img_maxfourier2( img,alpha )
%retourne le max des franges qui nous intéresse
%supposant qu'img a été traitée
[f1, posi1]=frange_detect(img,alpha);
[f2, posi2]=frange_detect(transpose(img),-alpha);
%%
%sépare en deux la représentation de fourier et prend le max de part et
%d'autre

f12=f1(length(f1)/2:length(f1));%freq positives
f11=f1(1:length(f1)/2);%freq 'négatives'

    f22=f2(length(f2)/2:length(f2));
    f21=f2(1:length(f2)/2);

    pos(1)=smooth_max(flipud(f11));
    pos(2)=smooth_max(f12);
    pos(3)=smooth_max(flipud(f21));
    pos(4)=smooth_max(f22);
    
    pos(1)=round(length(f1)/2-pos(1));
    p=posi1(pos(1));
    pos(1)=norm(p,[61,61]);
    %finir de trouver la position par rapport au centre (précisément) voir
    %peut-être avec l'équation de la droite

%     plot(1:length(f12),f12);hold on

end