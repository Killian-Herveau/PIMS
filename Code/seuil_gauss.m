function [ im_seuil ] = seuil_gauss( img1 )
%Fait le seuillage de l'image img1 par rapport à l'approxiamtion gaussienne
%2D de cette image; cette méthode de seuillage a les résultats les plus
%intéressants à exploiter
im = masque_rephase(img1);
p = fit_gauss2D(im);
im_seuil = zeros(120, 120);
comparaison = hgaussp(size(img1), [p(3), p(4)], p(2), p(5), p(1), 1);
for i=1:120
    for j=1:120
        if im(i,j)>=comparaison(i,j)+100
            im_seuil(i,j) = 1;
        end
    end
end

end

