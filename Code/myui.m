function [] = myui( fpath,fpcal,pas )
% cr�e le slider pour l'affichage des images et des graphes
% Le slider fait varier la profondeur Z et charge les images en cons�quence
% affiche l'image avec des traits correspondant � l'inclinaison des franges
% n�cessite bin2mat
%%
scrsz = get(groot,'ScreenSize');
lambda = 406350000;
    alpha=11.2;
    fpath2=strcat(fpath,'000700.2Ddbl'); %on affiche la 700 en premier
    img=bin2mat(fpath2); %conversion de l'image binaire en matrice
    fpathcal=strcat(fpcal,'000700.2Ddbl');
    imcal=bin2mat(fpathcal);
    [x,y]=size(img); %x:nb de ligne ; y : nb de colonnes
    h=figure('Position',[scrsz(3)/2 scrsz(4)/4 scrsz(3)/2 scrsz(4)/2]); % Place les figures c�te � c�te
    %permet de d�terminer o� la droite verticale croise le bord haut et bas de l'image
    k1=(-y/2+tand(-alpha+90)*x/2)/tand(-alpha+90);
    k2=(y/2+tand(-alpha+90)*x/2)/tand(-alpha+90);
    xi=round(k1):round(k2);
    
    im=abs(masque_rephase(img));
    subplot(1,2,1);
    image=imshow(im,'DisplayRange',[min(im(:)) max(im(:))],'InitialMagnification','fit');hold off;
    title('Z = 700');
    
    % trace les deux lignes
    l=line('Parent',gca,...
    'XData',1:120,...
    'YData',tand(alpha)*(1:120)+4*tand(alpha)*60,...
    'Color','g',...
    'Linewidth', 1);

    l2=line('Parent',gca,...
    'XData',xi,...
    'YData',tand(alpha-90)*(xi)-tand(alpha-90)*60+x/2+1,...
    'Color','r',...
    'Linewidth', 1);
    subplot(1,2,2);
    imagi=imshow(img,'DisplayRange',[min(img(:)) max(img(:))],'InitialMagnification','fit');
   
    %cr�e la figure pour afficher les deux graphes
    f = figure('Visible','off','Position',[1 scrsz(4)/4 scrsz(3)/2 scrsz(4)/2]);
    ax = axes('Units','pixels');
    x1=size(img);
    x1=1:x1(1);
    
    set(groot,'CurrentFigure',f);
    t=moydeg(im,alpha,4,61,61);
    t1=fft(t);
    subplot(2,1,1);
    plot(x1,t,'color','r');
    title(['Amplitude � Z=700']);
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
        'String','Images de 0 � 1400nm');
    
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
t=0;
t1=0;
    r=mod(val,pas);
    if(r)%arrondi la valeur du slide au PAS le plus proche
       val=val-r; 
    end
    set(groot,'CurrentFigure',f);
    fpath2=name_Z(fpath,val);
   
    imag=bin2mat(fpath2);
    fpathcal=name_Z(fpcal,val);
    imcal=bin2mat(fpathcal);
    im=masque_rephase(imag);
    G=hgaussp([120,120],[61,61],1,10,0,1);

    im=abs(FiltreWiener(G,im,lambda));
    im=imcal-im;
    t=moydeg(im,alpha,5,61,61);
    t1=fftshift(fft(t));
    
%  t1([1:12,108:120])=0;
    
    subplot(2,1,1);
    plot(x1,t,'color','r');
    title(['Amplitude � Z=',num2str(val)]);
    
    subplot(2,1,2);
    plot(x1,abs(t1),'color','g');
    title('TF');
    
    set(groot,'CurrentFigure',h);
    delete(image);delete(imagi);
    
    subplot(1,2,1);
    image=imshow(im,'DisplayRange',[min(im(:)) max(im(:))],'InitialMagnification','fit');
    title(['Z = ',num2str(val)]);
    l=line('Parent',gca,...
    'XData',1:120,...
    'YData',tand(alpha)*(1:120)+4*tand(alpha)*60,...
    'Color','g',...
    'Linewidth', 1);

    l2=line('Parent',gca,...
    'XData',xi,...
    'YData',tand(alpha-90)*(xi)-tand(alpha-90)*60+x/2,...
    'Color','r',...
    'Linewidth', 1);
    subplot(1,2,2);
    imagi=imshow(imag,'DisplayRange',[min(imag(:)) max(imag(:))],'InitialMagnification','fit');
    end
end