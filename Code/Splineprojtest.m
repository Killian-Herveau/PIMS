function [  ] = splineProj(Point,splinex,spliney,pasf )
%Projette un point sur la partie la plus proche d'une courbe (splinex,spliney), en norme.
%renvoil'altitude correspondante

%Point: le point a projeter, dont on cherche z en (x,y) soit (airy,freq)
%splinex: airy
%spliney: freq
%pas: pas pour l'echantillonnage spline


%z: altitude du point le plus proche

%Note:  dmax: distance max pour la norme. 
dmax=20;
itermax=500; %iteration max pour le while
itermax2=itermax;

%Projection d'un point sur le lieu le plus proche de la Spline
if (exist('pas','var'))
else pasf=0.01; end

pas=1;
P=Point;
z=1:pas:1400;
% a=spl_Airy(z);
% f=spl_Freq(z);
a=splinex(z);
f=spliney(z);
Points=[a,f];
size(Points)
l=length(a);


dmin=0;
nmax=1; %on veut un seul point a la fin (marche pas encore avec nmax>1)
iter=0;

%Note: on pourrait reduire la boucle for aux points deja eus avec dmax...
%enregistrer les points dans un vecteur et les enlever...
Pc=double.empty(3,0) %pointx pointy et z
zparcour=1:l;
normmin=Inf;

while((pas>pasf)*itermax2) %on reduit le pas de plus en plus    
    while(iter<itermax)
        d=(dmin+dmax)/2; %distance pour la norme euclidienne
        ntouche=0; %nombre de points à une distance inferieure à d de P

        for(n=zparcour) %pour tous les points
            normnow=norm(P-Points(n,:));
            if(normnow<=d);
                if(normnow<=normmin)
                    normmin=normnow;
%                     Pc=[Points(n,:),n*pas];
                      Pc=[Points(n,:),n];
                end
            end
        end
        iter=iter+1;
        if(ntouche==0) dmin=d;
        else if(ntouche>=1) iter=itermax; end %c'est gagné!
        end
    end
    
% ici on a le point le plus proche pour le pas choisi,
% on prend une borne autour de son z: [z-10*pas,z+10*pas]
n=Pc(3); % z=n*pas
zparcour=zparcour(max(1,n-10):min(length(zparcour),n+10));
pas=pas/10;
itermax2=itermax2+1;
end

plot(Pc(1),Pc(2),'x')
hold on
plot(a,f)
xlabel('airy')
ylabel('freq')
hold on
plot(P(1),P(2),'o')


end

