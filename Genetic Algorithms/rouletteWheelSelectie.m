function selectie = rouletteWheelSelectie(populatie,ParGA)
%Deze functie voert de roulette selectie uit
% Input:   populatie = structure met gegevens omtrent de fitness, genotype en fenotype  
%          ParGA     = structure bevat de parameters van het genetisch algoritme      
% Output:  selectie  = vector bevat de indices van de geselecteerde individuen

%Opgelet, dit is voor een maximum optimalisatie. Bij hogere fitness is er
%meer kans om geselecteerd te worden. Indien je rouletteWheelSelectie bij
%een minimumzoektocht wilt gebruiken (bij lagere fitness meer kans om
%geselecteerd te worden), dient bv. een inverse v/d fitness genomen te
%worden.

totalFitness = sum([populatie.fitness]);
for i = 1:length(populatie)
    kans(i) = populatie(i).fitness/totalFitness;
end

cumm = cumsum(kans);
for i = 1:ParGA.pop
    [number index] = histc(rand, cumm);
    selectie(i) = index;
end

