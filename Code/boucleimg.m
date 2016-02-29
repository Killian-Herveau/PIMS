for(i=400:100:975)
    %Calibration
    file=fopen(strcat('Mesures\STACK=0000_IM=00001_Z=000',num2str(i),'.2Ddbl'),'r');

    size = fread(file,[1,2],'*ubit32','ieee-be')
    DATA = fread(file,[120,120],'*double','ieee-be');
    fclose(file);

    dmax=max(max(DATA));
    dmin=min(min(DATA));
    indice=(i-400)/100+1
    subplot(2,5,indice)

    imshow2(fft2(DATA))
%     subplot(1,2,2)
%      DATA=DATA.^0.5;
%     dmax=max(max(DATA));
%     dmin=min(min(DATA));
%     imshow(DATA,'DisplayRange',[dmin dmax])
end


