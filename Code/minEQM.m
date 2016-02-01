function [ lambda ] = minEQM( h,s,r )
%h : le truc pour déconvoluer
%s : signal à traiter
%r : le machin pour l'EQM

lambda=1;
EQMmin=10^30;
min=1000;
pas=100;
max=10000;
    for k=0:4
        for l=min:pas:max
            fw=conj(fft2(h))./(abs(fft2(h)).^2+l);
            imgW=ifft2(fw.*fft2(s));
            EQM=mean(mean(abs(imgW-r).^2));
            if EQMmin>EQM
                EQMmin=EQM;
                inter=l;
            end
        end
        if inter>=pas
            min=inter-pas;
        else
            min=0;
        end
            max=inter+pas;
            pas=pas/100;    
    end
    lambda=inter;
end

