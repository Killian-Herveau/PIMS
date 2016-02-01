function [] = aff_im( fpath,fpcal,pas )
% crée le slider pour l'affichage des images et des graphes
% Le slider fait varier la profondeur Z et charge les images en
% conséquence
% affiche l'image avec des traits correspondant à l'inclinaison des franges
% nécessite bin2mat, moyvert et moyhor
%%
scrsz = get(groot,'ScreenSize');
    lambda=10000000;
    alpha=11.2;
    fpath2=strcat(fpath,'000700.2Ddbl');%on affiche la 700 en premier
    img=bin2mat(fpath2);%conversion de l'image binaire en matrice
    fpathcal=strcat(fpcal,'000700.2Ddbl')
    imcal=bin2mat(fpathcal);
    [x,y]=size(img);%x:nb de ligne ; y : nb de colonnes
    figure('Position',[scrsz(3)/2 scrsz(4)/4 scrsz(3)/2 scrsz(4)/2]); % Place les figures côte à côte
    %permet de déterminer où la droite verticale croise le bord haut et bas de l'image

    
    im=masque_rephase(img);
    imca=masque_rephase(imcal);
    filtre=FiltreWiener(imcal,img,lambda);
    
    imca=filtre-imca;
    subplot(1,2,1);
    image=imshow(im,'DisplayRange',[min(im(:)) max(im(:))],'InitialMagnification','fit');hold off;
    title('Z = 700');
    
    subplot(1,2,2);
    imagi=imshow(imca,'DisplayRange',[min(imca(:)) max(imca(:))],'InitialMagnification','fit');
   
    
   
    
   % Create slider
    sld = uicontrol('Style', 'slider',...
        'Min',0,'Max',1400,'Value',700,'SliderStep',[pas/1400 pas/1400],...
        'Position', [300 3 120 20],...
        'Callback', @replot);
					
    % Add a text uicontrol to label the slider.
    txt = uicontrol('Style','text',...
        'Position',[10 -5 120 30],...
        'String','Images de 0 à 1400nm');
    
    % Make figure visble after adding all components
    f.Visible = 'on';
    % This code uses dot notation to set properties. 
    % Dot notation runs in R2014b and later.
    % For R2014a and earlier: set(f,'Visible','on');
    
    function replot(source,callbackdata)
        val = source.Value;
        % For R2014a and earlier:
        % val = 51 - get(source,'Value');
im=0;
    r=mod(val,pas);
    if(r)%arrondi la valeur du slide au PAS le plus proche
       val=val-r; 
    end

    fpath2=name_Z(fpath,val);
   
    imag=bin2mat(fpath2);
    fpathcal=name_Z(fpcal,val);
    imcal=bin2mat(fpathcal);
    im=masque_rephase(imag);
    imca=masque_rephase(imcal);
    filtre=FiltreWiener(imcal,img,lambda);
    imca=filtre-imca;
    delete(image);delete(imagi);
    
    subplot(1,2,1);
    image=imshow(im,'DisplayRange',[min(im(:)) max(im(:))],'InitialMagnification','fit');
    title(['Z = ',num2str(val)]);
    subplot(1,2,2);
    imagi=imshow(imca,'DisplayRange',[min(imca(:)) max(imca(:))],'InitialMagnification','fit');
    end
end