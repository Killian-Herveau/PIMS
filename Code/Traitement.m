%%
%Ce script sert � fitter le spot par la gaussienne la plus adapt�e
%%
img=bin2mat('Projet 2A\Mesures\STACK=0000_IM=00070_Z=001200.2Ddbl');
% figure;imshow2(img);
%img=hgaussp( [200 200],[100,70],1,20,1,1);
alpha=11.2;
%figure;imshow(img,'DisplayRange',[min(img(:)) max(img(:))],'InitialMagnification','fit') ;title('image originale');
[x,y]=size(img);

%   on fit1D pour avoir une estimation de la position et de la variance
ph=fit_gauss(1:x,moyhor(img,y-1));
pv=fit_gauss(1:y,moyvert(img,x-1));
ph=abs(ph);%pour �viter les probl�mes de nombre complexe �ventuels
pv=abs(pv);

%On enl�ve l'offset
im=img-ph(1);%comparaison :
% figure;plot(1:y,moyvert(img,x-1));hold on;plot(1:y,moyvert(im,x-1));

%Application du masque hypergaussien  
% sigma : faut que �a entoure bien la gaussienne, mais pas trop pr�s sinon gare au bruit
im=masque_hg(im,[ph(3),pv(3)],1,3*ph(4),0,15);
%%v�rif si �a marche : 
% figure;m=moydeg(im,alpha,4,ph(3),pv(3));
% plot(1:length(m),m);title('image non trait�e');

%filtrage : g est l'image filtr�e de im
%23.065 est le pix correspond la fr�quence max r�ceptionn�e par le 
%microscope, donc le reste n'est que du bruit parasite pour le fit.
g=passebas_hg2D(im,23.065,10);

% figure;plot(1:y,moyvert(abs(g),x-1));title(['sigma =',num2str(5*ph(4))]);

%fait le fit 2D
p1=fit_gauss2D(g);
hg=hgaussp(size(g),[p1(3),p1(4)],p1(2),p1(5),p1(1),1);

%calcule le r�sidu
residu=abs(hg-g);

% recentre l'image
im_c=traitement_fft_gaussienne(im);figure
%plot(1:y,moydeg(im_c,alpha,4,1,1,0)');title('image rephas�e');figure
%imshow(im_c,[min(im_c(:)),max(im_c(:))],'InitialMagnification','fit');title('image centr�e');
%%
%Affiche l'image non filtr�e, l'image filtr�e, le fit,le residu
% imshow(im,'DisplayRange',[min(im(:)) max(im(:))],'InitialMagnification','fit') ;title('image masqu�e'); figure
 imshow(g,[min(g(:)),max(g(:))],'InitialMagnification','fit');title('image filtr�e');figure
 imshow(hg,'DisplayRange',[min(hg(:)) max(hg(:))],'InitialMagnification','fit');hold off;title('Fit 2D');figure
 % imshow(residu,'DisplayRange',[min(residu(:)) max(residu(:))],'InitialMagnification','fit');title('R�sidu');
%%
%Affiche une comparaison du profil d'intensit� horizontal du fit des
%donn�es et de l'image filtr�e
% figure;
plot(1:y,moyvert(im,x-1));hold on;
plot(1:y,moyvert(abs(g),x-1));
plot(1:y,moyvert(hg,x-1));
legend('data','g','h');
%%