function [ img ] = bin2mat( file )
%bin2mat : charge l'image au format binaire en double dont les 32 premiers
%bits correspondent à la taille selon x et les 32 suivants, selon y
%   file : nom du fichier binaire à ouvrir
%   img  : matrice image

fid=fopen(file,'r'); % ouvre le fichier en mode read
size=fread(fid,[1,2],'*ubit32','ieee-be'); %retourne [x,y]
img=fread(fid,size,'*float64','ieee-be'); % donne la matrice de l'image
fclose(fid); %ferme le fichier
end

