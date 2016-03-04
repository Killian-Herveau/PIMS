function [ p1 ] = find_the_gauss( img )
%img : image � fitter
%fit l'image img avec une gaussienne 2D
%renvoie les positions x et y de la gaussienne

[x,y]=size(img);
%   on fit1D pour avoir une estimation de la position et de la variance
ph=fit_gauss(1:x,moyhor(img,y-1));
pv=fit_gauss(1:y,moyvert(img,x-1));
ph=abs(ph);%pour �viter les probl�mes de nombre complexe �ventuels
pv=abs(pv);
%On enl�ve l'offset
im=img-ph(1);
%Application du masque hypergaussien  
% sigma : faut que �a entoure bien la gaussienne, mais pas trop pr�s sinon gare au bruit
im=masque_hg(im,[ph(3),pv(3)],1,3*ph(4),0,15);
%filtrage : g est l'image filtr�e de im
%23.065 est le pix correspond la fr�quence max r�ceptionn�e par le 
%microscope, donc le reste n'est que du bruit parasite pour le fit.
g=passebas_hg2D(im,23.065,10);
p1=fit_gauss2D(g);
end

