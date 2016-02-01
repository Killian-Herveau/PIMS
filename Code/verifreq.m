img=bin2mat('Projet 2A\Mesures\STACK=0000_IM=00070_Z=000700.2Ddbl');
imgcal=bin2mat('Projet 2A\Calibration\STACK=0001_IM=00001_Z=000700.2Ddbl');
[x,y]=size(img);
figure;imshow2(img);title('img de base');
img=masque_rephase(img);
img=FiltreWiener(imcal,img,lambda);
img= imcal-img;
img=imrotate(img,11.2);
figure;imshow2(img);title('img traitée');
P=fftshift(fft2(img));
M=P(12:131,12:131);

figure;imshow2(abs(M));title('img traitée fft');

M=M.*(hgaussp([x,y],[61,61],1,50,0,15));
M=M.*(1-hgaussp([x,y],[61,61],1,5,0,5));
M1=0;M2=0;M3=0;M4=0;
% figure;imshow2(abs(M));title('img fft traitée après HG');
% xb=24;yb=113;

% M1=M.*(hgaussp([x,y],[xb,yb],1,25,0,5));
% M2=M.*(hgaussp([x,y],[xb+68,yb-18],1,25,0,5));
% M3=M.*(hgaussp([x,y],[xb+66,yb-100],1,25,0,5));
% M4=M.*(hgaussp([x,y],[xb-5,yb-70],1,25,0,5));

%  xb=15;yb=72;
% M1=M.*(hgaussp([x,y],[xb+55,yb+48],1,15,0,5));
% M2=M.*(hgaussp([x,y],[xb+91,yb-20],1,15,0,5));
% M3=M.*(hgaussp([x,y],[xb+37,yb-58],1,15,0,5));
% M4=M.*(hgaussp([x,y],[xb,yb],1,15,0,5));
%  M=M1+M2+M3+M4;

% % M1=(hgaussp([x,y],[xb+55,yb+38],1,0.5,0,5));
% M2=(hgaussp([x,y],[xb+91,yb-20],1,0.5,0,5));
% % M3=(hgaussp([x,y],[xb+37,yb-58],1,0.5,0,5));
% M1=0;M3=0;
% M4=(hgaussp([x,y],[xb,yb],1,0.5,0,5));
%  M=M1+M2+M3+M4;
 
% for i=1:y
%     for j=1:x
%         if(M(i,j)<=10000)
%             M(i,j)=0;
%         end
%     end
% end

figure;imshow2(abs(M));title('img fft traitée après HG');
im2=ifft2(M);
im2=im2.*(1-hgaussp([x,y],[61,61],1,0.5,0,15));
figure;imshow2(abs(im2));title('img après ifft');