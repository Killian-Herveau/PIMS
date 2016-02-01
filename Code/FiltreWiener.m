function x = FiltreWiener(h,y,lambda)
% Rôle de FiltreWiener : applique le filtre de WIener associe a une
% perturbation a une image l'ayant subie.
%ENTREES : h = perturbation (ici PSF)
%          y : image à  filtrer
%          lambda : parametre du filtre de Wiener
% SORTIE : image filtree
% AUTEURS : C.Balsier & B.Varin

TFWiener=fft2(h)./((abs(fft2(h))).^2+lambda);
x=fftshift(ifft2(fft2(y).*TFWiener));

end

