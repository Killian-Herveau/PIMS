clear, tic

%PARAMETRE :
VideoALire = 'vid_in.mp4'; %Vid�o sur laquelle se fait le traitement
ImgRemplacement='img_remplacement.jpg'; %Image utilis�e pour le remplacement.
VideoSortie='sortie4.avi'; %Fichier de sortie pour la vid�o trait�e
inception = 1; %Nombre de fois que le traitement doit se r�aliser par image.
%Mettre 1 pour un traitement normal.

%-------------D�but du programme-----------------

%Chargement des fonctions du dossier 'fonctions'
addpath('fonctions')

%D�finie la valeur globale N, num�ro de l'image en cours de traitement
global N

%R�cup�ration des information concernant la vid�o sur laquelle se fait le traitement :
Video = VideoReader(VideoALire);
vidHeight = Video.Height;
vidWidth = Video.Width;
NumberOfFrames = Video.NumberOfFrames;
%Apr�s NumberOfFrames, la vid�o � �t� lue jusqu'� la derni�re image. Il
%faut donc la r�ouvrir pour repartir du d�but de la vid�o :
Video = VideoReader(VideoALire);

%D�finition de l'image utilis�e pour faire le remplacement :
ImgRemplacement = double(imread(ImgRemplacement));

%D�finition du fichier de sortie :
writerObj = VideoWriter(VideoSortie);
open(writerObj);
sortieVide=zeros(vidHeight, vidWidth);


%Initialisation des variables utilis�e plus tard :
barN = zeros(NumberOfFrames*2, 4);
M2=0;
seuil=0;
%Le mod�le M2 et le seuil sont utilis�s pour la prise en compte de la mains. 
%Il ne doivent pas �tre utilis�s avant l'image 38 (apparition de la main)


%-------------D�but du traimtement-----------------

%Traitement particulier de la premi�re image
N=1;

img1 = readFrame(Video);
[M,s, barN(1:2,:)] = initialisation(img1);

%Boucle pour traiter l'ensemble des images de la vid�o
while(hasFrame(Video))
    %Selection de l'image suivante
    N=N+1;
    imgN = readFrame(Video);
    
    %Rep�rage de la position des picots sur cette image
    barN(2*N:2*N+1,:) = reperage_pos_picots(imgN, M, s, barN(2*(N-1):2*(N-1)+1,:));
    
    
    if N==38
        [M2, seuil] = initialisationDoigts( imgN );
    end
    % Incrustation de l'image de remplacement
    imgN = Incrustation(imgN, ImgRemplacement, barN(2*N:2*N+1,:), M2, seuil);
    for i=1:inception-1
        imgN = Incrustation(imgN, double(imgN),    barN(2*N:2*N+1,:), M2, seuil);
    end
    % Enregistrement de l'image avec remplacement
    writeVideo(writerObj, imgN)
    
    if mod(N, 10)==0
        disp(['Avancement : ', num2str(floor(N/NumberOfFrames*100)), '%']);
    end
end

%Finalise
close(writerObj);
close all;
toc;
msgbox('Termin�');