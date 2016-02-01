function [] = myui2( fpath,fpcal,pas )
% crée le slider pour l'affichage des images et des graphes
% Le slider fait varier la profondeur Z et charge les images en conséquence
% affiche l'image avec des traits correspondant à l'inclinaison des franges
% nécessite bin2mat
%%
scrsz = get(groot,'ScreenSize');
lambda = 10000000;
    alpha=11.2;
    fpath2=strcat(fpath,'000700.2Ddbl'); %on affiche la 700 en premier
    img=bin2mat(fpath2); %conversion de l'image binaire en matrice
    fpathcal=strcat(fpcal,'000700.2Ddbl');
    imcal=bin2mat(fpathcal);
    [x,y]=size(img); %x:nb de ligne ; y : nb de colonnes
    h=figure('Position',[scrsz(3)/2 scrsz(4)/4 scrsz(3)/2 scrsz(4)/2]); % Place les figures côte à côte
    %permet de déterminer où la droite verticale croise le bord haut et bas de l'image
    k1=(-y/2+tand(-alpha+90)*x/2)/tand(-alpha+90);
    k2=(y/2+tand(-alpha+90)*x/2)/tand(-alpha+90);
    xi=round(k1):round(k2);
    im=abs(masque_rephase(img));
    subplot(1,2,1);
    image=imshow(im,'DisplayRange',[min(im(:)) max(im(:))],'InitialMagnification','fit');hold off;
    title('Z = 700');
    
    %%
    %trace les deux lignes
    l=line('Parent',gca,...
    'XData',1:120,...
    'YData',tand(alpha)*(1:120)+4*tand(alpha)*x/2,...
    'Color','g',...
    'Linewidth', 1);

    l2=line('Parent',gca,...
    'XData',xi,...
    'YData',tand(alpha-90)*(xi)-tand(alpha-90)*y/2+x/2+1,...
    'Color','r',...
    'Linewidth', 1);
%%
    subplot(1,2,2);
    imagi=imshow(img,'DisplayRange',[min(img(:)) max(img(:))],'InitialMagnification','fit');
   
    %crée la figure pour afficher les deux graphes
    f = figure('Visible','off','Position',[1 scrsz(4)/4 scrsz(3)/2 scrsz(4)/2]);
    ax = axes('Units','pixels');
   
    
    set(groot,'CurrentFigure',f);
    t=moydeg(im,alpha,4,61,61);
    x1=1:length(t);
    t1=fft(t);
    subplot(2,1,1);
    plot(x1,t,'color','r');
    title(['Amplitude à Z=700']);
    axis([0 x 0 inf]);
    subplot(2,1,2);
    plot(x1,abs(t1),'color','g');
    %title(['horizontale sur ',num2str(i),' pixels',' Z=700']);
    title('TF');
   
    
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
        forui( fpath,fpcal,val,pas,image,imagi,f,h,lambda,alpha,x1,xi);
    end
end