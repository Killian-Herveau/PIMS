% image=imread('C:\Users\ADRIEN\Documents\Images\Rude.jpg');
image=imread('C:\Users\ADRIEN\Documents\Images\rickMorty\EvilMortymini.png');
image=(image(:,:,1)+image(:,:,2)+image(:,:,3))/3;
imshow(image)
angle=-35;
epaisseur=2;
ic=60;
jc=60;
moy=moydeg(image,angle,epaisseur,ic,jc);
