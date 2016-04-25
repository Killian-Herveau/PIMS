function [ moy ] = moydegvisual(image,angle,epaisseur,ic,jc )
%visualisation des bords choisis a droite et a gauche

%ENTREES:
% angle: angle entre -90 et 90 degres,dans le sens trigo

%equation generale: i=-tan*(j-j0)+i0

%verif angle ---
moy=0;
t=tand(angle);
c=cosd(angle);
s=sind(angle);
e=epaisseur;

%On cherche le point de départ pour effectuer l'histogramme.
%Pour cela on regarde les intersections a gauche (i=1 ou j=1) et à droite,
%entre le chemin parcouru par l'histogramme et le bord de l'image


%calcul des intersections:

[ximage,yimage,poub]=size(image); %x vertical et y horizontal
%cote gauche (pour angle<0)
A=[1,(ic+e*c-1)/t+jc+e*s];
B=[t*jc-t*e*s-t*1+ic-e*c,1];
C=[1,(ic-e*c-1)/t+jc-e*s];
D=[t*jc+t*e*s-t*1+ic+e*c,1];
%cote droit (pour angle <0)
A_=[ximage,(ic+e*c-ximage)/t+jc+e*s];
B_=[t*jc+t*e*s-t*yimage+ic+e*c,yimage];
C_=[ximage,(ic-e*c-ximage)/t+jc-e*s];
D_=[t*jc-t*e*s-t*yimage+ic-e*c,yimage];

%NOTE:
%en notant *1 les intersections pour angle<0, sinon *2
% on trouve d2=d1 b2=b1 b2_=b1_ et d2_=d1_
% a2_=a1 a2=a1_ c2=c1_ et c2_=c1

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
    
    %Les candidats possibles: b et d OU d et c OU a et c.
    if(candidatsg==[0,1,0,1]) candidatsg(2)=0;  end
    if(candidatsg==[1,0,1,0]) candidatsg(1)=0;  end
    if(candidatsg==[0,0,1,1]) 
        %on hesite entre d et c, pour choisir on projette de l'autre coté
        candidatsg=[0,0,0,0];
        Cproj=[C(1)+2*e*c,C(2)+2*e*s];
        Dproj=[D(1)-2*e*c,D(2)-2*e*s];
        if(prod(Cproj>=1)) candidatsg(3)=1; 
        else if(prod(Dproj>=1)) candidatsg(4)=1; end
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
                if(candidatsg(1)==1) image(round(A(1)),round(A(2)))=255; end %a normalement jamais choisi pour a<0
                if(candidatsg(2)==1) image(round(B(1)),round(B(2)))=255; end %b normalement jamais choisi pour a<0
                if(candidatsg(3)==1) image(round(C(1)),round(C(2)))=255; end
                if(candidatsg(4)==1) image(round(D(1)),round(D(2)))=255; end
    
    

else if(angle>0)
        %les candidats bords gauche sont A_ , B, C_ et D. (cf note)
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
%     candidatsg
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
if(candidatsg(1)==1) image(round(A_(1)),round(A_(2)))=255; end 
if(candidatsg(2)==1) image(round(B(1)),round(B(2)))=255; end 
if(candidatsg(3)==1) image(round(C_(1)),round(C_(2)))=255; end %c normalement jamais choisi pour a<0
if(candidatsg(4)==1) image(round(D(1)),round(D(2)))=255; end %d normalement jamais choisi pour a<0
    
    
    
    end
end
% ICI, on a les candidats de gauche

        % RECHERCHE CANDIDATS DROITE

candidatsd=[0,0,0,0]; 
if(angle<0)
    %les candidats sont les *_
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
if(candidatsd(1)==1) image(round(A_(1)),round(A_(2)))=255; end 
if(candidatsd(2)==1) image(round(B_(1)),round(B_(2)))=255; end 
if(candidatsd(3)==1) image(round(C_(1)),round(C_(2)))=255; end 
if(candidatsd(4)==1) image(round(D_(1)),round(D_(2)))=255; end 

else if(angle>0)
        %les candidats sont A B_ C et D_
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
    candidatsd
        
        %Les candidats possibles: a et c OU c et b_ OU b_ et d_.
    if(candidatsd==[1,0,1,0]) candidatsd(1)=0;  end
    if(candidatsd==[0,1,0,1]) candidatsd(4)=0;  end
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
        
        
    % %     Affichage
if(candidatsd(1)==1) image(round(A(1)),round(A(2)))=255; end 
if(candidatsd(2)==1) image(round(B_(1)),round(B_(2)))=255; end 
if(candidatsd(3)==1) image(round(C(1)),round(C(2)))=255; end 
if(candidatsd(4)==1) image(round(D_(1)),round(D_(2)))=255; end 
        
    end
end

    

    
    


% ...

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

imagesc(image)

hold on
j=1:ximage;
plot(j,-t*(j-jc-e*s)+ic+e*c);
hold on
plot(j,-t*(j-jc+e*s)+ic-e*c);
hold on
plot(j,-t*(j-jc)+ic);
hold on




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


moy=0;

end

