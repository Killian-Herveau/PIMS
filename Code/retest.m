img=bin2mat('Projet 2A\Mesures\STACK=0000_IM=00070_Z=000700.2Ddbl');
alpha=11.2;
im=masque_rephase(img);
[x,y]=size(img);
p1=fit_gauss2D(img);
H=hgaussp(size(img),[p1(3),p1(4)],p1(2),p1(5),p1(1),1);
%%
%On a pf=N/D // pf le pixel correspondant à la période D en pixel, N le nb
%de pixels
%donc pour D=2.5 on a 120/2.5 = 48
%D=3.5 on a 120/3.5 = 34.3
%on applique un anneau hypergaussien contenant la fréquence
%d'échantillonnage de 3px/franges
%%
%H2=hgaussp(size(img),[p1(3),p1(4)],1,34,0,15);
%G2=hgaussp(size(img),[p1(3),p1(4)],1,48,0,15);
H2=hgaussp(size(img),[p1(3),p1(4)],1,18,0,15);
G2=hgaussp(size(img),[p1(3),p1(4)],1,50,0,15);

im2=fftshift(fft2(im));
im2= (1-H2).*G2.*im2;

f2=abs(im2);
%fait la moyenne sur les boules d'intérêt
f_im = moydeg(f2,-alpha,4,p1(3),p1(4),0.5,0.5,1);
im2=abs(ifft2(im2));

% m_im=moydeg(im2,-alpha,2,p1(3),p1(4),0.5,0.5);
% figure
% plot(1:length(m_im),m_im);
figure
plot(1:length(f_im),f_im);