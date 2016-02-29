function [ p ] = fit_gauss2D( img,p0 )
%img est l'image d'une gaussienne2D pour laquelle on souhaite obtenir
%les param�tres
%%%%%
%On fait un fit gaussienne avec lsqnonlin
%   p0: coefficients autours desquels on va chercher la bonne approximation
%   //SORTIE//
%       p(1) -> offset selon y => A
%       p(2) -> amplitude
%       p(3) -> moyenne (horizontale)
%       p(4) -> moyenne (verticale)
%       p(5) -> ecart-type
%%
%Fait appel � lsqnonlin avec construction de jacobienne
%N�cessite : approxgauss2D.m
%            Rgauss2D.m
%            jaco_der.m
%%

[dim_v,dim_h]=size(img);%nombre de lignes, nombre de colonnes
fline=zeros(1,dim_v*dim_h);

% Quels parametres l'utilisateur a t-il choisit ?
if (exist('p0','var'))
    p  = approxgauss2D( fline , p0 ,dim_h,dim_v);
    return
end


[Max,Iv]=max(img);%donne la position verticale de chaque maximum
[Max,I_h]=max(Max);%donne la position horizontale du maximum global
I_v = Iv(I_h);
Min=min(min(img));
rec=[0,0];
k=0;

%permet d'estimer grossi�rement la largeur de la gaussienne en param
%d'optimisation
for i=I_v-15:I_v+15
    if img(i,I_h)>(Max+Min)/2 && k==0
        k=1;
        rec(1)=i;
    end
    if img(i)<Max/2 && k==1
        rec(2)=i;
    end
end

%%
%%cr�e une ligne dim_v*dim_v pour contenir l'image recoup�e � chaque fin de
%ligne   
%      dim_h
%   <---------->
%    1234567891<- => 12345678912345678912
% -> 2345678912
%   ...
%pourquoi pas laisser en 2D ?
% Parce que lsqnonlin ne g�re pas la 2D �tant donn� qu'on peut se ramener
% au cas 1D !
%%


for i=1:dim_v
    fline((i-1)*dim_h+1:i*dim_h)=img(i,:);
end

p0 = [ Min, Max-Min, I_h, I_v, (rec(2)-I_v)/sqrt(2*log((2*Max)/(Max-Min))) ];

p  = approxgauss2D( fline , p0 ,dim_h,dim_v);

end

