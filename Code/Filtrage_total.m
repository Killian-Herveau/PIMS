function [ image_finale ] = Filtrage_total( image, 
img_comp )
%Filtrage_total : traite l'image de mani�re � pouvoir appliquer le filtre
%de Wiener, puis nous rend l'image filtr�e
%   image : image que l'on cherche � filtrer
%   a : param�tre random dans la fonction hgaussp qui n'est pas expliqu�,
%   je sais pas ce qu'il fout l�
%   img_comp : image par rapport � laquelle on compare notre image
%   lambda : param�tre du filtre de Wiener


% u = [1:121];
% moy_y = moyhor(image, 4);
% param_gauss1_y = fit_gauss(u, moy_y);
% moy_x = moyvert(image, 4);
% param_gauss1_x = fit_gauss(u, moy_x);
% image_masquee = masque_hg([121 121], [param_gauss1_x param_gauss1_y], a, param_gauss1_x(4), param_gauss1_x(1), 4, image);          % je savais pas quoi prendre en param�tres, la fonction masque etait pas bien expliqu�e
% image_filtree1 = passebas_hg2D(image_masquee, param_gauss1_x(4), 4);
% param_gauss2 = fit_gauss2D(image_filtree);
% image_centree = traitement_fft_gaussienne(image_filtree1);
% image_finale = FiltreWiener(img_comp, image_centree, lambda);

image_masquee = masque_rephase(image);
lambda = minEQM(img_comp, image_masquee, img_comp);
image_finale = FiltreWiener(image_masquee, img_comp, lambda);

end

