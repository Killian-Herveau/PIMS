function [ bar ] = ordonnancement( bar1, bar2 )
%Ordonne les 4 barycentre de bar2 d'après leur proxymité avec les
%barycentre de bar1
%ENTREES : bar1 : (2*4 int8) barycentre de reférence
%          bar2 : (2*4 int8) barycentre à ordonnée
%SORTIE : bar : (2*4 int8) barycentre de bar2 réordonnés (colonnes
%               échangées)


[size1, size2] = size(bar2);
dist = zeros(4,size2);
bar = zeros(2,4);
for i = 1:4
    for j=1:size2
        dist(i,j) = pdist([bar1(1,i),bar1(2,i);bar2(1,j), bar2(2,j)], 'euclidean');
    end
end
for i = 1:4
    [m, pos_old] = min(dist);
    [mini, pos_new] = min(m);
    size(bar2);
    bar(:, pos_old(pos_new)) = bar2(:, pos_new);
    dist(pos_old(pos_new),:) =max(max(dist))+3;
    dist(:,pos_new) = max(max(dist))+3;
end

end

