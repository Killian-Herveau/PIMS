img=bin2mat('D:\FarView\Exs interferogrammes\0000122.2Ddbl');
% img=removefilter2(img);
imshow2(abs(img(200:400,200:400)))

title('image type')


% % mes=imdata(1,700,5);
% cal=imdata(0,700);
% 
% 
% % img=bin2mat('D:\FarView\Exs interferogrammes\0000122.2Ddbl');
% imshow2(cal(45:76,45:76))
% % imshow2(mes(45:76,45:76))
% 
% title('Calibration à z=700nm')
% xlabel('position x')
% ylabel('position y')

