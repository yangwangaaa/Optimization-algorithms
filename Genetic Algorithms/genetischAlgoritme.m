function [xStar,iteratiematrix] = genetischAlgoritme(fun,dimensie,ParGA,decodering)

%input:
%fun                        string, naam van de te optimaliseren functie 
%dimensie = 2;              integer, dimensie van het probleem
%ParGA                      structuur, parameterinstellingen voor simulated annealing:
%   ParGA.maxgen            maximum aantal generaties
%   ParGA.pop               populatiegrootte
%   ParGA.pcross            kruisingsprobabiliteit
%   ParGA.pmut              mutatieprobabiliteit
%decodering                 matrix met parameters voor decodering         
%output:
%xStar	                    vector het gevonden optimum
%iteratiematrix             matrix met in elke generatie het beste punt in de zoekruimte en bijhorende functiewaarde

% Preallocatie van populatie structure en iteratiematrix

populatie = struct('fitness',[],'genotype',[],'fenotype',[]);
iteratiematrix = zeros(ParGA.maxgen+1,dimensie+1);

% Initialiseer de populatie structure en de iteratiematrix

for m = 1:1:ParGA.pop
   populatie(m).genotype = randi([0 1],dimensie,decodering(1));
end

populatie = evalueerPop(fun,populatie,ParGA,decodering);
[fBest,positieBest] = min([populatie(:).fitness]);
iteratiematrix(1,:) = [populatie(positieBest).fenotype fBest];

    
% Start Genetisch Algoritme

for t = 1:1:ParGA.maxgen
    
        selectie = toernooiSelectie(populatie,ParGA);
        populatieNieuw = recombineerPop(populatie, selectie, ParGA);
        populatieNieuw(1).genotype = populatie(positieBest).genotype;
        populatie = evalueerPop(fun, populatieNieuw, ParGA, decodering);        
        [fBest,positieBest] = min([populatie(:).fitness]);
        iteratiematrix(t+1,:) = [populatie(positieBest).fenotype fBest];
   
end

xStar = populatie(positieBest).fenotype;

end

