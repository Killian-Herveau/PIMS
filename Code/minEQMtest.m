function [ lambda ] = minEQM( h,s,r )
%Cherche un lambda qui minimise l'EQM, suppose que EQM(lambda) n'a qu'un
%minimum local.
%h : le truc pour déconvoluer
%s : signal à traiter
%r : le machin pour l'EQM

precisionlambda=0.2

lambda=1;
min=0;
max=Inf

%On fait un premier calcul
%Filtre de Wiener et cakcul EQM
fw=conj(fft2(h))./(abs(fft2(h)).^2+lambda);
imgW=ifft2(fw.*fft2(s));
EQMmin=mean(mean(abs(imgW-r).^2));
EQMtemp=EQMmin;


k=0; %multiplication par pas^(k) de lambda, 


%On multiplie ou divise lambda par pas jusqua atteindre un changement dans
%levolution de l'EQM, on a alors un intervalle contenant lambdaopt
while(<1000)

    if(EQMtemp<EQMin)
        EQMtemp=EQMmin
        lambda=lamda*pas
    elseif(EQMtemp>EQMmin) %on accede a un intervalle contenant lambdaopt
        if(k==0) %lambda entre 0 et pas
            min=0;
            max=2;
        else %lambda entre pas^k-1 et pas^k+1
            min=2^(k-1)
            max=2^(k+1)
        end 
    else %les deux EQM sont egaux, donc lambda est entre les deux positions testées
    end 

end 
end

