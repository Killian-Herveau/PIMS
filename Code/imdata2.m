function [ img ] = imdata2(dossier,numero,im)
%imdata :renvoie l'image en position "numero" dans le dossier Mesures ou Calibration
%Createur: moi
%ENTREES:
% dossier: mettre M ou 1 pour mesures et C ou 0 pour Calibration
% num: valeur du focus
% im: pour le dossier Mesures, numero de l'image

% SORTIES/
% img: image qui etait contenue en binaire


if (exist('im','var'))
    im=im;
else
    im=00001; %pas d'image renseignee
end

%nombre a renseigner pour choix de l'image
sim=num2str(im);
for(i=length(sim):4)
    sim=strcat('0',sim);
end 


%nombre a renseigner pour choix de focus
snum=num2str(numero);
for(i=length(snum):5)
    snum=strcat('0',snum);
end 


if((dossier(1)=='M')|(dossier(1)=='m')|(dossier(1)==1))
    chemin=strcat('..\..\Projet 2A\Mesures\STACK=0000_IM=',sim,'_Z=',snum,'.2Ddbl')
elseif((dossier(1)=='C')|(dossier(1)=='c')|(dossier(1)==0))
    chemin=strcat('..\..\Projet 2A\Calibration\STACK=0001_IM=00001_Z=',snum,'.2Ddbl')
else
    warning('dossier specifie non pris en charge par la fonction, rentrez C (ou 0) ou M (ou 1)')
end

img=masque_rephase(bin2mat(chemin));

end
% 
% strcat('Mesures\STACK=0000_IM=00001_Z=000',num2str(i),'.2Ddbl')