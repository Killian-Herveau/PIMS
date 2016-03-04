function [ pos,pos_0 ] = img_maxfourier2( img,alpha )
%retourne le max des franges qui nous intéresse
%supposant qu'img a été traitée
[f1, posi1]=frange_detect(img,alpha);
[f2, posi2]=frange_detect(transpose(img),-alpha);
posi1=posi1-120;
posi1(:,2)=posi1(:,2)-60;
posi2=posi2-120;
% plot(-length(f1)/2:length(f1)/2-1,f1);
%%
%sépare en deux la représentation de fourier et prend le max de part et
%d'autre
f12=zeros(length(f1),1);
f11=zeros(length(f1),1);

f12(ceil(length(f1)/2):length(f1))=f1(ceil(length(f1))/2:length(f1));%freq positives
f11(1:ceil(length(f1)/2))=f1(1:ceil(length(f1)/2));%freq 'négatives'

    f22=f2(length(f2)/2:length(f2));
    f21=f2(1:length(f2)/2); 
    pos(1)=119.2-smooth_max2(f11);%Trouve le max de garry
    pos(2)=smooth_max2(f12);
    pos_0 =+pos(1) +(pos(2)-pos(1))/2;
    pos(3)=smooth_max(flipud(f21));
    pos(4)=smooth_max(f22);

    %% POUR POS(1)
    %norm de posi1 et pos(1) la position depuis le premier point
    pos(1) = length(f1)/2-pos(1);
    pos(1) = norm(posi1(1,:))-pos(1)/2;
    
    %% POUR POS(2)
    pos(2) = length(f1)/2-pos(2);
    pos(2) = norm(posi1(1,:))-pos(2)/2;
    
end