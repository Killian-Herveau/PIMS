function [ pos] = img_maxfourier2( img,alpha )
%retourne le max des franges qui nous int�resse
%supposant qu'img a �t� trait�e (imdata2, pas imdata)
%   pos(1)= GAUCHE
%   pos(2)= DROITE
%   pos(3)= HAUT
%   pos(4)= BAS
%   pos(5)= moyenne GAUCHE-DROITE
%   pos(6)= moyenne BAS-HAUT
%   pos(7)= moyenne totale

[f1, pas]=frange_detect(img,alpha);
f2=frange_detect(img,-90+alpha);
%%
%s�pare en deux la repr�sentation de fourier et prend le max de part et
%d'autre
f12=zeros(length(f1),1);
f11=zeros(length(f1),1);
f22=zeros(length(f1),1);
f21=zeros(length(f1),1);

f12(ceil(length(f1)/2):length(f1))=f1(ceil(length(f1)/2):length(f1)); %freq positives
f11(1:ceil(length(f1)/2))=f1(1:ceil(length(f1)/2)); %freq 'n�gatives'

f12(ceil(length(f1)/2):length(f1))=f1(ceil(length(f1)/2):length(f1)); %freq positives
f11(1:floor(length(f1)/2))=f1(1:floor(length(f1)/2)); %freq 'n�gatives'

f22(ceil(length(f2)/2):length(f2))=f2(ceil(length(f2)/2):length(f2)); %freq positives
f21(1:floor(length(f2)/2))=f2(1:floor(length(f2)/2)); %freq 'n�gatives'

%Le pas permet d'obtenir la fr�quence exacte vue sur l'image (n�cessaire
%car f11 est r�-�chantillonn�)
    pos(1)=abs(121-smooth_max2(f11))*pas;
    pos(2)=abs(121-smooth_max2(f12))*pas;
    pos(3)=abs(121-smooth_max2(f21))*pas;
    pos(4)=abs(121-smooth_max2(f22))*pas;
    pos(5)=(pos(1)+pos(2))/2;
    pos(6)=(pos(3)+pos(4))/2;
    pos(7)=(pos(5)+pos(6))/2;
end