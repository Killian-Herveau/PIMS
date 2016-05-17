clear, tic

%PARAMETRE :
VideoALire = 'vid_in.mp4'; %Vidéo sur laquelle se fait le traitement
ImgRemplacement='img_remplacement.jpg'; %Image utilisée pour le remplacement.
VideoSortie='sortie4.avi'; %Fichier de sortie pour la vidéo traitée
inception = 1; %Nombre de fois que le traitement doit se réaliser par image.
%Mettre 1 pour un traitement normal.

%-------------Début du programme-----------------

%Chargement des fonctions du dossier 'fonctions'
addpath('fonctions')

%Définie la valeur globale N, numéro de l'image en cours de traitement
global N

%Récupération des information concernant la vidéo sur laquelle se fait le traitement :
Video = VideoReader(VideoALire);
vidHeight = Video.Height;
vidWidth = Video.Width;
NumberOfFrames = Video.NumberOfFrames;
%Après NumberOfFrames, la vidéo à été lue jusqu'à la dernière image. Il
%faut donc la réouvrir pour repartir du début de la vidéo :
Video = VideoReader(VideoALire);

%Définition de l'image utilisée pour faire le remplacement :
ImgRemplacement = double(imread(ImgRemplacement));

%Définition du fichier de sortie :
writerObj = VideoWriter(VideoSortie);
open(writerObj);
sortieVide=zeros(vidHeight, vidWidth);


%Initialisation des variables utilisée plus tard :
barN = zeros(NumberOfFrames*2, 4);
M2=0;
seuil=0;
%Le modèle M2 et le seuil sont utilisés pour la prise en compte de la mains. 
%Il ne doivent pas être utilisés avant l'image 38 (apparition de la main)


%-------------Début du traimtement-----------------

%Traitement particulier de la première image
N=1;

img1 = readFrame(Video);
[M,s, barN(1:2,:)] = initialisation(img1);

%Boucle pour traiter l'ensemble des images de la vidéo
while(hasFrame(Video))
    %Selection de l'image suivante
    N=N+1;
    imgN = readFrame(Video);
    
    %Repérage de la position des picots sur cette image
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
msgbox('Terminé');