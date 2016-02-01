function [ image_centree ] = traitement_fft_gaussienne2( gauss2 )
% Renvoie l'image dont la phase est annulée
% image : matrice de l'image en fourier !
[x,y]=size(gauss2);
for i=1:x
    for j=1:y
        %gauss2(i,j) = gauss2(i,j)*conj(gauss2(i,j));
        gauss2(i,j) = abs(gauss2(i,j)); %on garde uniquement l'amplitude de la FFT (revient à annuler la phase)
    end
end
image_centree = abs(fftshift(ifft2(gauss2)));
end
