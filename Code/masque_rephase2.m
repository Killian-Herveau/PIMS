function [ im ] = masque_rephase2( img ,sigma)
    %Application du masque hypergaussien  et met la phase � 0 en centrant
    %l'image
    % sigma : faut que �a entoure bien la gaussienne, mais pas trop pr�s sinon gare au bruit
    % si sigma non renseigne, le programme prend 3 fois la variance de l'approx
    %gaussienne
    %vire les basses frequences correspondant � ce qui est issu du
    %microscope (soit jusqu'au pixel 23.064) et garde l'information des frequences d'int�r�t
    
    
if (exist('sigma','var'))
    sigma=sigma;
else
    sigma=0;
end

    [x,y]=size(img);
    %on utilise des moyennes horizontales et verticales simples pour
    %estimer les param�tres de la gaussienne qui fit la t�che (on a surtout
    %besoin de son centre et de sa largeur)
    ph=fit_gauss(1:x,moyhor(img,floor((y-1)/2)));
    pv=fit_gauss(1:y,moyvert(img,floor((x-1)/2)));
    ph=abs(ph);%pour �viter les probl�mes de nombre complexe �ventuels
    pv=abs(pv);%c'est d�j� arriv�

    %On enl�ve l'offset
    im=img-ph(1);%comparaison :
    %figure;plot(1:y,moyvert(img,x-1));hold on;plot(1:y,moyvert(im,x-1));
    if(~(sigma==0))
        ph(4)=sigma/3; %on prend le sigma de l'utilisateur
    end 
    %crop l'image selon un masque hypergaussien taille 3x l'estimation
    %gaussienne (ecart-type) faite pr�c�demment
    im=masque_hg(im,[ph(3),pv(3)],1,3*ph(4),0,15);
    im=fftshift(fft2(im));
    %masque les fr�quences ind�sirables (passe bas)
    % faire gaffe � savoir ce qu'on veut
    G=hgaussp([x,y],[x/2+1,y/2+1],1,23.064,0,15);
    im=im.*(1-G);
    
    %ancienne fa�on, mais la nouvelle �conomise un ifft et un fft
    %et offre un meilleur rendu
    %im=abs(ifft2(im));
    %im=traitement_fft_gaussienne(im);
    %recentre la phase
    
    im=traitement_fft_gaussienne2(im);
  end