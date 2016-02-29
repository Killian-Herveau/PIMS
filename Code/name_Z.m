function [ fpath2 ] = name_Z( fpath,Z )
%Retourne le filepath avec les '0' devant la profondeur
%   fpath : chemin relatif ou absolu jusqu'à 'Z='
%   exemple : 'Projet 2A\Calibration\STACK=0001_IM=00001_Z='
%   Z : la profondeur actuelle

if Z==0
        fpath2=strcat(fpath,'000000','.2Ddbl');
    elseif Z<100
        fpath2=strcat(fpath,'0000',num2str(Z),'.2Ddbl');
    elseif Z<1000
        fpath2=strcat(fpath,'000',num2str(Z),'.2Ddbl');
    elseif Z<10000
        fpath2=strcat(fpath,'00',num2str(Z),'.2Ddbl');
    elseif Z<100000
        fpath2=strcat(fpath,'0',num2str(Z),'.2Ddbl');
end
 
end

