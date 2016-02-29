function [ imgf ] = passebas_hg2D( img, s , k)
%Applique un filtre passe bas
% img : matrice 2D sur laquelle on va pratiquer l'opération
% s : écart-type de l'hypergaussienne
% k : degré de l'hypergaussienne
% imgf : image filtrée
%%

[x,y]=size(img);
%fftshift pour avoir l'image centrée, fft2 pour passer en fourrier
F=fftshift(fft2(img)); 

%le filtre est une hypergaussienne 2D à sym de révolution centrée dans l'image
H0=hgaussp([x,y],[x/2,y/2],1,s,0,10);

G=zeros(x,y);%préallocation : 35ms de gagnées pour 120x120
for i=1:x 
    for j=1:y 
        G(i,j)=F(i,j)*H0(i,j); 
    end 
end
%on se remet dans l'espace réel
imgf=abs(ifft2(G));

end

