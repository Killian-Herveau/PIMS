function [] = forui( fpath,fpcal,val,pas,image,imagi,f,h,lambda,alpha,x1,xi )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

% im=0;
% t=0;
% t1=0;
    r=mod(val,pas);
    if(r)%arrondi la valeur du slide au PAS le plus proche
       val=val-r; 
    end
    
    set(groot,'CurrentFigure',f);
    fpath2=name_Z(fpath,val);
    fpathcal=name_Z(fpcal,val);
    imag=bin2mat(fpath2);
    imcal=bin2mat(fpathcal);
    
    
    [x,y]=size(imag);
    im=masque_rephase2(imag);
    imcal=masque_rephase2(imcal);
    G=hgaussp([x,y],[61,61],1,20,0,1);
    im=FiltreWiener(G,im,lambda);
   % im=imcal-im;
    
    t=moydeg(im,-alpha,4,61,61,1,1);
    t1=fftshift(fft(t));
    p=fit_gauss(1:x,t1(:)');
    t2=t1(:)-gaussian_offset(p(1),p(2),p(3),p(4),1:x)'; 
    
    %%
    %Plot des graphes : 
    % - t est la moyennedeg de l'image avec masque rephase 2 et filtre
    % wiener utilisant une gaussienne,taille 120x120, écart type
    % 20 offset 0
    % - abs(t2) sachant que t2 est la fft de t1 auquel on enlève une
    % gaussienne centrée en 0 (pour enlever le gros pic principal)
    %%
    subplot(2,1,1);
    plot(1:length(t),t,'color','r');
    title(['Amplitude à Z=',num2str(val)]);
    
    subplot(2,1,2);
    plot(1:length(t2),abs(t2),'color','g');
    title('TF');
    
    set(groot,'CurrentFigure',h);
    %on enlève les images précédentes
    delete(image);delete(imagi);
    %%
    %affichage des images
    %d'abord la première, suivie des deux lignes
    %puis l'autre
    %%
    subplot(1,2,1);imshow2(im);
    title(['Z = ',num2str(val)]);
%     l=line('Parent',gca,...
%     'XData',1:120,...
%     'YData',tand(alpha)*(1:120)+4*tand(alpha)*60,...
%     'Color','g',...
%     'Linewidth', 1);
% 
%     l2=line('Parent',gca,...
%     'XData',xi,...
%     'YData',tand(alpha-90)*(xi)-tand(alpha-90)*60+x/2,...
%     'Color','r',...
%     'Linewidth', 1);
    subplot(1,2,2);
    imshow2(imag);

end

