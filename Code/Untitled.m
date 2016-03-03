%myui('Projet 2A\Mesures\STACK=0000_IM=00070_Z=','Projet 2A\Calibration\STACK=0001_IM=00001_Z=',100);

img=bin2mat('..\..\Projet 2A\Mesures\STACK=0000_IM=00070_Z=000900.2Ddbl');
imcal=bin2mat('..\..\Projet 2A\Calibration\STACK=0001_IM=00001_Z=000900.2Ddbl');
figure
subplot(1,2,1);
    img=masque_rephase(img);
    imshow(img,'DisplayRange',[min(img(:)) max(img(:))],'InitialMagnification','fit');hold off;
    title('image mesure après la fonction');
    subplot(1,2,2);
    imcal=masque_rephase(imcal);
    imshow(imcal,'DisplayRange',[min(imcal(:)) max(imcal(:))],'InitialMagnification','fit');hold off;
    title('image calib traitée');
    figure;imshow(imcal,'DisplayRange',[min(imcal(:)) max(imcal(:))],'InitialMagnification','fit');
    lambda=10000000;
    filtre=FiltreWiener(imcal,img,lambda);figure;
    filtre=img-filtre;
    
  % filtre=masque_hg([x,y],[ph(3),pv(3)],1,3*ph(4),0,15,filtre);
    
    imshow(filtre,'DisplayRange',[min(filtre(:)) max(filtre(:))],'InitialMagnification','fit');hold off;
    title('image filtrée');
