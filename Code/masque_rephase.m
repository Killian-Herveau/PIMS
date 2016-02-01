function [ im ] = masque_rephase( img ,sigma)
    %Application du masque hypergaussien  et met la phase à 0 en centrant
    %l'image
    % sigma : faut que ça entoure bien la gaussienne, mais pas trop près sinon gare au bruit
    % si sigma non renseigne, le programme prend 3 fois la variance de l'approx
    %gaussienne
    
    
if (exist('sigma','var'))
    sigma=sigma;
else
    sigma=0;
end
    [x,y]=size(img);
    
    ph=fit_gauss(1:x,moyhor(img,floor((y-1)/2)));
    pv=fit_gauss(1:y,moyvert(img,floor((x-1)/2)));
    ph=abs(ph);%pour éviter les problèmes de nombre complexe éventuels
    pv=abs(pv);

    %On enlève l'offset
    im=img-ph(1);%comparaison :
    %figure;plot(1:y,moyvert(img,x-1));hold on;plot(1:y,moyvert(im,x-1));
    if(~(sigma==0))
        ph(4)=sigma/3; %on prend le sigma de l'utilisateur
    end 
    
    im=masque_hg(im,[ph(3),pv(3)],1,3*ph(4),0,15);
    im=traitement_fft_gaussienne(im);
    im=masque_hg(im,[ph(3),pv(3)],1,3*ph(4),0,15);
  end