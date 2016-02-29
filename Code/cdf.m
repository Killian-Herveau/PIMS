% uiopen('F:\DOSSIER\projet c++ 2a\ProjetCPP\cdfligne.pgm',1)
% uiopen('F:\DOSSIER\projet c++ 2a\ProjetCPP\cdftot.pgm',1);
b=cdfligne(1,:,1);
plot(b);
title('cdfligne de la première ligne du gradient');
xlabel('colonne');
ylabel('valeur d''echantillon');

figure
a=cdftot(1:length(cdftot),1,1);
plot(a);
title('cdftot du gradient');
xlabel('ligne');
ylabel('valeur d''echantillon');