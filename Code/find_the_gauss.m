function [ p1 ] = find_the_gauss( img )
%img : image à fitter (imdata pas imdata2)
%fit l'image img avec une gaussienne 2D
%   //SORTIE//
%       p(1) -> offset selon y => A
%       p(2) -> amplitude
%       p(3) -> moyenne (horizontale)
%       p(4) -> moyenne (verticale)
%       p(5) -> ecart-type
%%
[x,y]=size(img);
%   on fit1D pour avoir une estimation de la position et de l'écart-type
img=passebas_hg2D(img,23.065,10);
M=histodeg(img,90,25,61,61,25,121);%VERTICAL
M2=histodeg(img,0,25,61,61,25,121);
M=M(1:120);
M2=M2(1:120);
ph=fit_gauss(1:x,M2);
pv=fit_gauss(1:y,M);
ph=abs(ph);
pv=abs(pv);

%   plot(M2);hold on;plot(gaussian_offset(ph(1),ph(2),ph(3),ph(4),1:120))
%   On enlève l'offset
im=img-ph(1);
%   Application du masque hypergaussien  
%   sigma : faut que ça entoure bien la gaussienne, mais pas trop près sinon gare au bruit
im=masque_hg(im,[ph(3),pv(3)],1,3*ph(4),0,15);
%   filtrage : g est l'image filtrée de im
%   23.065 est le pix correspond la fréquence max réceptionnée par le 
%   microscope, donc le reste n'est que du bruit parasite pour le fit.
p1=fit_gauss2D(im);
end