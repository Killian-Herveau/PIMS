function [] = myui( fpath,fpcal,pas )
%test de histodeg
%%
scrsz = get(groot,'ScreenSize');

    global angle 
    angle=-78;
    epaisseur=6;
    ic=100;
    jc=100;
    pas=0.5;
    image=imread('C:\Users\ADRIEN\Documents\Images\rickMorty\devil2.png');
%     image=imread('C:\Users\ADRIEN\Documents\Images\Rude.jpg');
    
    image=double(image(:,:,1)+image(:,:,2)+image(:,:,3))/3/.255;

   image=image(:,:,1);
   
    %crée la figure pour afficher les deux graphes
    f = figure('Visible','off','Position',[1 scrsz(4)/4 scrsz(3)/2 scrsz(4)/2]);
    imshow2(image)
    set(groot,'CurrentFigure',f);
    moy=histodeg(image,angle,epaisseur,ic,jc);
    
   
    
   % Create slider
    sld = uicontrol('Style', 'slider',...
        'Min',-90,'Max',90,'Value',angle,'SliderStep',[pas/90 pas/90],...
        'Position', [300 3 120 20],...
        'Callback', @replot);
					
    % Add a text uicontrol to label the slider.
    txt = uicontrol('Style','text',...
        'Position',[10 -5 120 30],...
        'String',strcat('angle de:',num2str(angle)));
    
    % Make figure visble after adding all components
    f.Visible = 'on';
    % This code uses dot notation to set properties. 
    % Dot notation runs in R2014b and later.
    % For R2014a and earlier: set(f,'Visible','on');
    
    function replot(source,callbackdata)
        val = source.Value;
        angle=val;
    moy=histodeg(image,val,epaisseur,ic,jc);
    txt = uicontrol('Style','text',...
        'Position',[10 -5 120 30],...
        'String',strcat('angle de:',num2str(angle)));
    end
end