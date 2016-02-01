function [ image_centree ] = traitement_fft_gaussienne( image )
% Renvoie l'image dont la phase est annulée
% image : matrice de l'image

gauss2 = fft2(image);  %on détermine la FFT en 2D de notre image

for i=1:120
    for j=1:120
        %gauss2(i,j) = gauss2(i,j)*conj(gauss2(i,j));
        gauss2(i,j) = abs(gauss2(i,j)); %on garde uniquement l'amplitude de la FFT (revient à annuler la phase)
    end
end
gauss = fftshift(gauss2);   %on centre la fft obtenue

Y = ifft2(fftshift(gauss));
image_centree = fftshift(Y);
end
