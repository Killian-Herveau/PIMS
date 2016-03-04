function [ rms] = meansquare(img1,img2)
%Renvoie l'erreur quadratique moyenne entre deux images 2D


%Entrees:
%   img1: Cela va peut etre vous surprendre mais img signifie 'image'
%   img2: C'est la deuxième image utilisée, de même dimension que la
%   première
%SORTIES:
%   rms: valeur de l'erreur.

    [x,y]=size(img1);
    if( ([x,y]==size(img2))~=[1,1]) %pas les memes dimensions
        'Erreur dans meansquare: Les images ne sont pas de la même taille'
        rms=NaN;
    else
        rms=0;
        for(i=1:x)
            for(j=1:y)
                rms=rms+(img1(i,j)-img2(i,j))^2;
            end
        end
        rms=rms/(x*y);
    end 


end