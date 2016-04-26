function [ moy,pas ] = histodeg2(image,angle,epaisseur,ic,jc,ne,nhisto )
%Effectue l'histogramme d'une image, selon un angle. Le centre de
%l'histogramme correspond au point ic,jc.

%ENTREES
% image: image de doubles, dont on va faire l'histogramme 
% angle: angle (degre) de rotation du parcours de l'histogramme, entre +-90°
% epaisseur: epaisseur de l'echantillon d'image pris pour le calcul d'une valeur
% ic et jc: coordonnees (ligne-colonne) du point image <=> centre de l'histogramme.
% ne: nombre d'echantillon pour une valeur de l'histo
% nhisto: nombre d'abscisse pour l'histogramme
% (le milieu de l'histogramme est en round(nhisto/2), decalage de 0.5 si
% pair)


% Sorties:
% moy: histogramme de l'image
% pas: un delta d'abscisse de 1 correspond à pas pixel image


%ne: nombre de point pris pour le calcul d'une valeur de l'histogramme
if (exist('ne','var'))
else ne=20; end

%nhisto ou nv: nombre de point d'abccisse de l'histogramme (impair=mieux)
if (exist('nhisto','var'))
    nv=nhisto;
else nv=150; end
moy=zeros(nv); %contient l'histogramme

%ENTREES:
% angle: angle entre -90 et 90 degres,dans le sens trigo

%equation generale: i=-tan*(j-j0)+i0

%parametres
moy=0;
t=tand(angle);
c=cosd(angle);
s=sind(angle);
e=epaisseur; %epaisseur de chaque coté (ensemble de point pris pour calculer une valeur de l'histo)
p=2*e/ne; %pas

if(~mod(nv,2)) %pair
    nv=nv+2; %on va faire une moyenne plus grand et enlever les deux extremités (pb de bord)
end



%On cherche le point de départ pour effectuer l'histogramme.
%Pour cela on regarde les intersections a gauche (i=1 ou j=1) et à droite,
%entre le chemin parcouru par l'histogramme et le bord de l'image
%on prendra l'intersection la plus proche de ic,jc


%Preli: recherche des intersections images, pour ne pas déborder.
%calcul des intersections:

[yimage,ximage,poub]=size(image); %x vertical et y horizontal
%cote gauche (pour angle<0)
A=[1,(ic+e*c-1)/t+jc+e*s];
B=[t*jc-t*e*s-t*1+ic-e*c,1];
C=[1,(ic-e*c-1)/t+jc-e*s];
D=[t*jc+t*e*s-t*1+ic+e*c,1];
%cote droit (pour angle <0)
A_=[yimage,(ic+e*c-yimage)/t+jc+e*s]; %pb angle <0 cand D choix a d ximg?
B_=[t*jc+t*e*s-t*yimage+ic+e*c,yimage]; %Yimage?
C_=[ximage,(ic-e*c-ximage)/t+jc-e*s];
D_=[t*jc-t*e*s-t*yimage+ic-e*c,yimage]; %yimage?

%NOTE:
%en notant *1 les intersections pour angle<0, sinon *2
% on trouve pour une image carree:
%d2=d1 b2=b1 b2_=b1_ et d2_=d1_
% a2_=a1 a2=a1_ c2=c1_ et c2_=c1

%Au cas ou elle est rectangle, on appliquera une correction sur ximage et yimage.

%pour chaque bord il n'y a que deux points dans l'image (non hors image),donc qui sont candidats
% (ou trois points si par exemple a et d ou b et c confondus)

        % RECHERCHE CANDIDATS GAUCHE
        
candidatsg=[0,0,0,0]; %on va chercher les candidats de gauche
if(angle<0)
    if(prod(A>=1))
    candidatsg(1)=1;
    end
    if(prod(B>=1))
    candidatsg(2)=1;
    end
    if(prod(C>=1))
    candidatsg(3)=1;
    end
    if(prod(D>=1))
    candidatsg(4)=1; 
    end
%     candidatsg
    %Les candidats possibles: b et d OU d et c OU a et c.
    if(candidatsg==[0,1,0,1]) candidatsg(2)=0;  end
    if(candidatsg==[1,0,1,0]) candidatsg(1)=0;  end
    if(candidatsg==[0,0,1,1]) 
        %on hesite entre d et c, pour choisir on projette de l'autre coté
        candidatsg=[0,0,0,0];
        Cproj=[C(1)+2*e*c,C(2)+2*e*s];
        Dproj=[D(1)-2*e*c,D(2)-2*e*s];
        if(prod(Cproj>=1)) candidatsg(3)=1;
        else if(prod(Dproj>=1)) candidatsg(4)=1;
            else if(norm(Dproj)>norm(Cproj)) %et verifier sup à racne(2)/2 ?
                    candidatsg(4)=1; %Si aucune des deux proj marche... on prend plus loin de 0,0
                else candidatsg(3)=1;
                end
            end
        end
        
         %Affichage  des projections
        %         if(prod(Cproj>=1)*(Cproj(1)<=yimage)*(Cproj(2)<=ximage))
        %         image(round(Cproj(1)),round(Cproj(2)))=255;
        %         end
        %         if(prod(Dproj>=1)*(Dproj(1)<=yimage)*(Dproj(2)<=ximage))
        %         image(round(Dproj(1)),round(Dproj(2)))=255;
        %         end
        
    end
        %pour un angle négatif, on a ici les candidats bord gauche
                    % %     Affichage
%                 if(candidatsg(1)==1) image(round(A(1)),round(A(2)))=255; end %a normalement jamais choisi pour a<0
%                 if(candidatsg(2)==1) image(round(B(1)),round(B(2)))=255; end %b normalement jamais choisi pour a<0
%                 if(candidatsg(3)==1) image(round(C(1)),round(C(2)))=255; Pg=[3,-1]; end
%                 if(candidatsg(4)==1) image(round(D(1)),round(D(2)))=255; Pg=[4,1] end
%     
    

else if(angle>0)
        %les candidats bords gauche sont A_ , B, C_ et D. (cf note)
%     A_=[yimage,(ic+e*c-yimage)/t+jc+e*s];
    if(prod(A_>=1))
    candidatsg(1)=1;
    end
    if(prod(B>=1))
    candidatsg(2)=1;
    end
    if(prod(C_>=1))
    candidatsg(3)=1;
    end
    if(prod(D>=1))
    candidatsg(4)=1; 
    end

%      candidatsg


        %Les candidats possibles: b et d OU b et a OU a et c.
    if(candidatsg==[0,1,0,1]) candidatsg(4)=0;  end
    if(candidatsg==[1,0,1,0]) candidatsg(3)=0;  end
    if((candidatsg(1)==1)*(candidatsg(2)==1)) %on peut avoir 1 1 0 1 ou 1 1 1 1
        %on hesite entre a et b, pour choisir on projette de l'autre coté
        candidatsg=[0,0,0,0];
        
        Aproj=[A_(1)-2*e*c,A_(2)-2*e*s];
        Bproj=[B(1)+2*e*c,B(2)+2*e*s];
        if( prod((Aproj>=1))*(Aproj(1)<=yimage)*(Aproj(2)<=ximage) ) candidatsg(1)=1; 
        else if(prod(Bproj>=1)*(Bproj(1)<=yimage)*(Bproj(2)<=ximage)) candidatsg(2)=1; end
        end
%          Affichage  des projections
%                 if(prod(Aproj>=1)*(Aproj(1)<=yimage)*(Aproj(2)<=ximage))
%                 image(round(Aproj(1)),round(Aproj(2)))=255;
%                 end
%                 if(prod(Bproj>=1)*(Bproj(1)<=yimage)*(Bproj(2)<=ximage))
%                 image(round(Bproj(1)),round(Bproj(2)))=255;
%                 end

    end
    
        % %     Affichage
% if(candidatsg(1)==1) image(round(A_(1)),round(A_(2)))=255; end 
% if(candidatsg(2)==1) image(round(B(1)),round(B(2)))=255; end 
% if(candidatsg(3)==1) image(round(C_(1)),round(C_(2)))=255; end %c normalement jamais choisi pour a<0
% if(candidatsg(4)==1) image(round(D(1)),round(D(2)))=255; end %d normalement jamais choisi pour a<0
%     
    
    
    end
end
% ICI, on a les candidats de gauche

        % RECHERCHE CANDIDATS DROITE

candidatsd=[0,0,0,0]; 
if(angle<0)
    %les candidats sont les *_
 D_=[t*jc-t*e*s-t*ximage+ic-e*c,ximage];
if(prod((A_>=1))*(A_(1)<=yimage)*(A_(2)<=ximage)) 
    candidatsd(1)=1;
end
if(prod(B_>=1)*(B_(1)<=yimage)*(B_(2)<=ximage))
    candidatsd(2)=1;
end
if(prod(C_>=1)*(C_(1)<=yimage)*(C_(2)<=ximage)) 
    candidatsd(3)=1;
end
if(prod(D_>=1)*(D_(1)<=yimage)*(D_(2)<=ximage))
    candidatsd(4)=1;
end
% candidatsd

            %Les candidats possibles: a_ et c_ OU a_ et d_ OU d_ et b_.
    if(candidatsd==[1,0,1,0]) candidatsd(3)=0;  end
    if(candidatsd==[0,1,0,1]) candidatsd(2)=0;  end
    if(candidatsd==[1,1,0,0]) candidatsd(2)=0;  end %correction
    if((candidatsd(1)==1)*(candidatsd(4)==1)) 
        %on hesite entre a_ et d_, pour choisir on projette de l'autre coté
        candidatsd=[0,0,0,0];
        Aproj=[A_(1)-2*e*c,A_(2)-2*e*s];
        Dproj=[D_(1)+2*e*c,D_(2)+2*e*s];
        if( prod((Aproj>=1))*(Aproj(1)<=yimage)*(Aproj(2)<=ximage) ) candidatsd(1)=1; 
        else if(prod(Dproj>=1)*(Dproj(1)<=yimage)*(Dproj(2)<=ximage)) candidatsd(4)=1; end
        end
% % %          Affichage  des projections
%                 if(prod(Aproj>=1)*(Aproj(1)<=yimage)*(Aproj(2)<=ximage))
%                 image(round(Aproj(1)),round(Aproj(2)))=255;
%                 end
%                 if(prod(Dproj>=1)*(Dproj(1)<=yimage)*(Dproj(2)<=ximage))
%                 image(round(Dproj(1)),round(Dproj(2)))=255;
%                 end

    end
    
  
    % %     Affichage
% if(candidatsd(1)==1) image(round(A_(1)),round(A_(2)))=255; end 
% if(candidatsd(2)==1) image(round(B_(1)),round(B_(2)))=255; end %non
% if(candidatsd(3)==1) image(round(C_(1)),round(C_(2)))=255; end %non 
% if(candidatsd(4)==1) image(round(D_(1)),round(D_(2)))=255; end 

else if(angle>0)
        %les candidats sont A B_ C et D_
        
B_=[t*jc+t*e*s-t*ximage+ic+e*c,ximage];
if(prod((A>=1))*(A(1)<=yimage)*(A(2)<=ximage))
    candidatsd(1)=1;
end
if(prod(B_>=1)*(B_(1)<=yimage)*(B_(2)<=ximage))
    candidatsd(2)=1;
end
if(prod(C>=1)*(C(1)<=yimage)*(C(2)<=ximage))
    candidatsd(3)=1;
end
if(prod(D_>=1)*(D_(1)<=yimage)*(D_(2)<=ximage))
    candidatsd(4)=1;
end

% % candidatsd



        
        %Les candidats possibles: a et c OU c et b_ OU b_ et d_. (Seuls c et
        %b_ devraient etre bons.)
    if(candidatsd==[1,0,1,0]) candidatsd(1)=0;  end
    if(candidatsd==[0,1,0,1]) candidatsd(4)=0;  end
    if(candidatsd==[1,0,1,1]) candidatsd=[0,0,1,0]; end %correction %Note: ds les 3 cas on enleve 1 et 4...
    if((candidatsd(2)==1)*(candidatsd(3)==1)) 
        %on hesite entre c et b_, pour choisir on projette de l'autre coté
        candidatsd=[0,0,0,0];
        Cproj=[C(1)+2*e*c,C(2)+2*e*s];
        Bproj=[B_(1)-2*e*c,B_(2)-2*e*s];
        if( prod((Cproj>=1))*(Cproj(1)<=yimage)*(Cproj(2)<=ximage) ) candidatsd(3)=1; 
        else if(prod(Bproj>=1)*(Bproj(1)<=yimage)*(Bproj(2)<=ximage)) candidatsd(2)=1; end
        end
% %          Affichage  des projections
%                 if(prod(Cproj>=1)*(Cproj(1)<=yimage)*(Cproj(2)<=ximage))
%                 image(round(Cproj(1)),round(Cproj(2)))=255;
%                 end
%                 if(prod(Bproj>=1)*(Bproj(1)<=yimage)*(Bproj(2)<=ximage))
%                 image(round(Bproj(1)),round(Bproj(2)))=255;
%                 end

    end
        
        
%     % %     Affichage
% if(candidatsd(1)==1) image(round(A(1)),round(A(2)))=255; end %non
% if(candidatsd(2)==1) image(round(B_(1)),round(B_(2)))=255; end 
% if(candidatsd(3)==1) image(round(C(1)),round(C(2)))=255; end 
% if(candidatsd(4)==1) image(round(D_(1)),round(D_(2)))=255; end %non
        
    end
end
%Ici on a les deux intersections, a gauche et a droite.

invm=-1; % (-1 si il faut echanger les deux cotés calculés de la moyenne, cf for: si le sum correspond a la partie droite, on inverse)
if(candidatsg(1)==1) Pg=A_;dir=[1,-1]; end     %part en haut a gauche
if(candidatsg(2)==1) Pg=B;dir=[-1,1]; end      %part en bas a droite
if(candidatsg(3)==1) Pg=C;dir=[-1,-1]; end      %part en bas a gauche
if(candidatsg(4)==1) Pg=D;dir=[1,1]; end      %part en haut a droite
if(candidatsd(1)==1) Pd=A_;dir2=[1,1]; end     %part en haut a droite
if(candidatsd(2)==1) Pd=B_;dir2=[1,-1]; end     %part en haut a gauche
if(candidatsd(3)==1) Pd=C;dir2=[-1,1]; end      %part en bas a droite
if(candidatsd(4)==1) Pd=D_;dir2=[-1,-1]; end     %part en bas a gauche
if(angle==0) Pg=[ic+e,1]; Pd=[ic+e,ximage]; dir2=[1,1];dir=[1,1]; end
%on Rq que les point et operations sur A et C_ sont/etaient inutiles.


%Affichage 
% image(round(Pg(1)),round(Pg(2)))=255;
% image(round(Pd(1)),round(Pd(2)))=255;

if(norm(Pg-[ic,jc])<norm(Pd-[ic,jc]))
   % On part du point gauche (plus proche)
P=Pg;
if(candidatsg(1)==1) end     %part en haut a gauche
if(candidatsg(2)==1) invm=1; end      %part en bas a droite
if(candidatsg(3)==1) invm=1; end      %part en bas a gauche
if(candidatsg(4)==1) end      %part en haut a droite   P=Pg;
%    image(round(Pg(1)),round(Pg(2)))=255;
else
   % On part du point droit
   P=Pd;
   dir=dir2;
if(candidatsd(1)==1) invm=-1; end     %part en haut a droite
if(candidatsd(2)==1) end     %part en haut a gauche
if(candidatsd(3)==1) invm=1; end      %part en bas a droite
if(candidatsd(4)==1) end     %part en bas a gauche
%    image(round(Pd(1)),round(Pd(2)))=255;
end
%    image(ic,jc)=255; 

if(angle>0) dir(2)=-dir(2);end

%ON VA FAIRE L'histogramme (enfin !)
    DEPi=ic+dir(1)*e*c;
    DEPj=jc+dir(2)*e*s;
% image(round(DEPi),round(DEPj))=255;
startmoy=round(nv/2); %valeur centrale de l'histogramme
distance=norm([DEPi,DEPj]-P); %parcourue par l'histogramme de chaque coté.

depi=DEPi;
depj=DEPj;
%calcul de la valeur centrale si nv est impair:

bonus=0;
if(~mod(nv,2)) %nv pair
%     bonus=0.5;
%     bonus2=1; %correction pour l'attribution de sum à moyenne
%     startmoy=startmoy-0.5; %on ne remplit pas le centre
else
    sum=0;
    for(ep=0:ne) %calcul d'une valeur de l'histo.
        %on prend la moyenne ponderee sur les points (depi-ep*dir(1)*c,depj-ep*dir(2)*s)
        %pour cela on prend les quatres points autour
        ip=round(depi+0.5);
        in=ip-1;
        jp=round(depj+0.5);
        jn=jp-1;
        modi=mod(depi,1); %distance pour ponderer
        modj=mod(depj,1); 
        sum=sum+...
        (image(in,jp)*(modi+1-modj)+...
        image(ip,jp)*(2-modi-modj)+...
        image(ip,jn)*(1-modi+modj)+...
        image(in,jn)*(modi+modj))/4;   

    depi=depi-p*dir(1)*c;
    depj=depj-p*dir(2)*s;
    %     image(ip,jp)=255;
    end
    moy(startmoy)=sum/ne;
end



% Calcul des autres valeurs: on fait en nv+-1,nv+-2... jusqua attendre
% le bord, qui correspond à P, ou/et son symetrique par (DEPi,DEPj)
pas=2*distance/nv;
    
 for(posh=1:startmoy-1) %de nv/2 à environ nv
    sum=0;
    sum2=0;
    depi=DEPi-pas*posh*dir(2)*s;
    depj=DEPj+pas*posh*dir(1)*c;
    depi2=DEPi+pas*posh*dir(2)*s;
    depj2=DEPj-pas*posh*dir(1)*c;
    
    for(ep=0:ne) %calcul de deux valeurs de l'histo.
        %on prend la moyenne ponderee sur les points (depi-ep*dir(1)*c,depj-ep*dir(2)*s)
        %pour cela on prend les quatres points autour
        
        %premiere valeur
        ip=round(depi+0.5);
        in=ip-1;
        jp=round(depj+0.5);
        jn=jp-1;
        modi=mod(depi,1); %distance pour ponderer
        modj=mod(depj,1); 
        sum=sum+...
        (image(in,jp)*(modi+1-modj)+...
        image(ip,jp)*(2-modi-modj)+...
        image(ip,jn)*(1-modi+modj)+...
        image(in,jn)*(modi+modj))/4;
%                                      image(ip,jp)=255;

  
         %deuxieme valeur
        ip=round(depi2+0.5);
        in=ip-1;
        jp=round(depj2+0.5);
        jn=jp-1;
        modi=mod(depi2,1); %distance pour ponderer
        modj=mod(depj2,1); 
        sum2=sum2+...
        (image(in,jp)*(modi+1-modj)+...
        image(ip,jp)*(2-modi-modj)+...
        image(ip,jn)*(1-modi+modj)+...
        image(in,jn)*(modi+modj))/4; 
%                                     image(ip,jp)=255;
    
    
    depi=depi-p*dir(1)*c;
    depj=depj-p*dir(2)*s;
    depi2=depi2-p*dir(1)*c;
    depj2=depj2-p*dir(2)*s;

    end
    moy(startmoy-posh*invm)=sum/ne;
    moy(startmoy+posh*invm)=sum2/ne;
 end

if(~mod(nv,2)) moy(startmoy)=[];
%OU faire calcul de sum au milieu, et le moyenner avec les moyennes en
%startmoy+-1 ?
end


% 
% % % % Affichage candidats
% if(prod(A>=1)*(A(1)<=yimage)*(A(2)<=ximage))
% image(round(A(1)),round(A(2)))=255;
% end
% if(prod(B>=1)*(B(1)<=yimage)*(B(2)<=ximage))
% image(round(B(1)),round(B(2)))=255;
% end
% if(prod(C>=1)*(C(1)<=yimage)*(C(2)<=ximage))
% image(round(C(1)),round(C(2)))=255;
% end
% if(prod(D>=1)*(D(1)<=yimage)*(D(2)<=ximage))
% image(round(D(1)),round(D(2)))=255;
% end
% 
% if(prod((A_>=1))*(A_(1)<=yimage)*(A_(2)<=ximage))
% image(round(A_(1)),round(A_(2)))=255;
% end
% if(prod(B_>=1)*(B_(1)<=yimage)*(B_(2)<=ximage))
% image(round(B_(1)),round(B_(2)))=255;
% end
% if(prod(C_>=1)*(C_(1)<=yimage)*(C_(2)<=ximage))
% image(round(C_(1)),round(C_(2)))=255;
% end
% if(prod(D_>=1)*(D_(1)<=yimage)*(D_(2)<=ximage))
% image(round(D_(1)),round(D_(2)))=255;
% end
% 
% subplot(1,2,1)

% if angle>0
%     persistent v;
%     v=v+1;
% figure
% imagesc(image)
% % 
% hold on
% j=1:ximage;
% plot(j,-t*(j-jc-e*s)+ic+e*c);
% hold on
% plot(j,-t*(j-jc+e*s)+ic-e*c);
% hold on
% plot(j,-t*(j-jc)+ic);
% if isempty(v)
%     v=1;
% end
% title(num2str(v));
% end


% subplot(1,2,2)
% plot(moy);



% 
% %IMAGE GRANDE
% 
% A2=[A(1)+ximage;A(2)+yimage];
% B2=[B(1)+ximage;B(2)+yimage];
% C2=[C(1)+ximage;C(2)+yimage];
% D2=[D(1)+ximage;D(2)+yimage];
% 
% A2_=[A_(1)+ximage;A_(2)+yimage];
% B2_=[B_(1)+ximage;B_(2)+yimage];
% C2_=[C_(1)+ximage;C_(2)+yimage];
% D2_=[D_(1)+ximage;D_(2)+yimage];
% 
% img=zeros(3*ximage+1,3*yimage+1,3);
% img(ximage:2*ximage-1,yimage:2*yimage-1,3)=image;
% 
% if(prod(A2>=1))
% img(round(A2(1)),round(A2(2)))=255;
% end
% if(prod(B2>=1))
% img(round(B2(1)),round(B2(2)))=255;
% end
% if(prod(C2>=1))
% img(round(C2(1)),round(C2(2)))=255;
% end
% if(prod(D2>=1))
% img(round(D2(1)),round(D2(2)))=255;
% end
% % 
% if(prod(A2_>=1))
% img(floor(A2_(1)),floor(A2_(2)))=255;
% end
% if(prod(B2_>=1))
% img(floor(B2_(1)),floor(B2_(2)))=255;
% end
% if(prod(C2_>=1))
% img(floor(C2_(1)),floor(C2_(2)))=255;
% end
% if(prod(D2_>=1))
% img(floor(D2_(1)),floor(D2_(2)))=255;
% end
% 
% 
% 
% imagesc(img)
% hold on
% j=1:3*ximage;
% ic2=ic+yimage;
% jc2=jc+ximage;
% plot(j,-t*(j-jc2-e*s)+ic2+e*c);
% hold on
% plot(j,-t*(j-jc2+e*s)+ic2-e*c);
% hold on
% plot(j,-t*(j-jc2)+ic2);
% hold on




end

