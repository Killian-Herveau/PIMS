function [ imgf ] = passebas_hg2D( img, s , k)
%Applique un filtre passe bas
% img : matrice 2D sur laquelle on va pratiquer l'op�ration
% s : �cart-type de l'hypergaussienne
% k : degr� de l'hypergaussienne
% imgf : image filtr�e
%%

[x,y]=size(img);
%fftshift pour avoir l'image centr�e, fft2 pour passer en fourrier
F=fftshift(fft2(img)); 

%le filtre est une hypergaussienne 2D � sym de r�volution centr�e dans l'image
H0=hgaussp([x,y],[x/2,y/2],1,s,0,10);

G=zeros(x,y);%pr�allocation : 35ms de gagn�es pour 120x120
for i=1:x 
    for j=1:y 
        G(i,j)=F(i,j)*H0(i,j); 
    end 
end
%on se remet dans l'espace r�el
imgf=abs(ifft2(G));

end

