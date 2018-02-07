function plotIteraties(iteratiematrix)
% Deze functie maakt een 3D-scatterplot bovenop een bestaande plot. Elke
% rij in 'iteratiematrix' wordt voorgesteld als een punt.

% Argumenten
% ----------

% ITERATIEMATRIX:   Een (n x 3) matrix die de coördinaten van n punten bevat
%                   elke rij bevat de coördinaten van een punt in een
%                   (X,Y,Z)-assenstelsel

hold on
plot3(iteratiematrix(:,1), iteratiematrix(:,2), iteratiematrix(:,3),'r*-')
hold off