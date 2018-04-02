function plotIteratiesColor(iteratiematrix)
% Deze functie maakt een 3D-scatterplot bovenop een bestaande plot. Elke
% rij in 'iteratiematrix' wordt voorgesteld als een punt. De kleur van de
% punten verandert van rood naar blauw naarmate de optimaliseerder benaderd
% wordt.

% Argumenten
% ----------

% ITERATIEMATRIX:   Een (n x 3) matrix die de coördinaten van n punten bevat
%                   elke rij bevat de coördinaten van een punt in een
%                   (X,Y,Z)-assenstelsel

ic=[1 0 0];
fc=[0 0 1];
colormap(bone)

hold on
for k = 1:size(iteratiematrix,1)
    plot3(iteratiematrix(k,1),iteratiematrix(k,2),iteratiematrix(k,3)+1,'.','MarkerSize',10,'MarkerEdgeColor',ic+(k-1)/(length(iteratiematrix)-1)*(fc-ic));
end
hold off

end