function [] = myui3( )
% crée le slider pour l'affichage des images et des graphes
%Pour visualiser les image de Exs_interferogramme
 fpath='D:\FarView\Exs interferogrammes\'

% Le slider fait varier la profondeur Z et charge les images en conséquence
% nécessite bin2mat
%%

    %crée la figure pour afficher les deux graphes
    
        scrsz = get(groot,'ScreenSize');
        f = figure('Visible','off','Position',[1 scrsz(4)/4 scrsz(3)/2 scrsz(4)/2]);
        set(groot,'CurrentFigure',f);
    
    ax = axes('Units','pixels');

    fpath2=strcat(fpath,'0000110.2Ddbl'); %affiche en premier cette image
    img=bin2mat(fpath2); %conversion de l'image binaire en matrice
    [x,y]=size(img); %x:nb de ligne ; y : nb de colonnes
    imshow2(img);hold off;
    title('N = 110');
    

%%

   
    
   % Create slider
    sld = uicontrol('Style', 'slider',...
        'Min',100,'Max',140,'Value',110,'SliderStep',[0.1/4 0.1/4],...
        'Position', [300 3 120 20],...
        'Callback', @replot);
					
    % Add a text uicontrol to label the slider.
    txt = uicontrol('Style','text',...
        'Position',[10 -5 120 30],...
        'String','Images de Exs interferogramme');
    
    % Make figure visble after adding all components
    f.Visible = 'on';
    % This code uses dot notation to set properties. 
    % Dot notation runs in R2014b and later.
    % For R2014a and earlier: set(f,'Visible','on');
    
    function replot(source,callbackdata)
         val = source.Value;
        imag=bin2mat(fpath2);
        
        fpath2=strcat(fpath,'0000',num2str(val),'.2Ddbl'); %affiche en premier cette image
        img=bin2mat(fpath2); %conversion de l'image binaire en matrice
        [x,y]=size(img); %x:nb de ligne ; y : nb de colonnes
        imshow2(img);hold off;
        title(['N = ',num2str(val)]);

    end
end