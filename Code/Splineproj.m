function [ Pc ] = Splineproj(Point,splinex,spliney,pas )
%Projette un point sur la partie la plus proche d'une courbe (splinex,spliney), en norme.
%splinex: airy
%spliney: freq
%pas: pas pour l'echantillonnage spline

%Note:  dmax: distance max pour la norme. 
dmax=20;

%Projection d'un point sur le lieu le plus proche de la Spline
if (exist('pas','var'))
else pas=10; end

P=Point;
z=1:pas:1400;
% a=spl_Airy(z);
% f=spl_Freq(z);
a=splinex(z);
f=spliney(z);
Points=[a,f];
l=length(a);


dmin=0;
nmax=1; %on veut un seul point a la fin
itermax=500; %n iterations max (while)
iter=0;
norm(P-Points(5,:))
%Note: on pourrait reduire la boucle for aux points deja eus avec dmax...
%enregistrer les points dans un vecteur et les enlever...
Pc=0;
while(iter<itermax)
    
    
    d=(dmin+dmax)/2; %distance pour la norme euclidienne
    ntouche=0; %nombre de points à une distance inferieure à d de P
    for(n=1:l) %pour tous les points
        if(norm(P-Points(n,:))<=d);
            ntouche=ntouche+1;
            Pc=[Pc,Points(n,:)];
        end
    end
    iter=iter+1;
    if(ntouche==0) dmin=d;Pc=0;
    else if(ntouche>nmax) dmax=d;Pc=0;
        else if(ntouche==nmax) iter=itermax; end %c'est gagné!
        end
    end
    
end
Pc=Pc(2:length(Pc));

% plot(Pc(1),Pc(2),'x')
% hold on
% plot(a,f)
% xlabel('airy')
% ylabel('freq')
% hold on
% plot(P(1),P(2),'o')


end

