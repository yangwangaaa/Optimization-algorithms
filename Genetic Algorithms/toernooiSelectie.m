function selectie = toernooiSelectie(populatie,ParGA)
%Deze functie voert de tornooiselectie uit
% Input:   populatie = structure met gegevens omtrent de fitness, genotype en fenotype  
%          ParGA     = structure bevat de parameters van het genetisch algoritme      
% Output:  selectie  = vector bevat de indices van de geselecteerde individuen
% bevat

for i = 1:ParGA.pop
    deelnemers = randi(ParGA.pop, [2 1]);
    if populatie(deelnemers(1)).fitness < populatie(deelnemers(2)).fitness
        selectie(i) = deelnemers(1);
    elseif populatie(deelnemers(1)).fitness == populatie(deelnemers(2)).fitness
        selectie(i) = deelnemers(randi(2));
    else
        selectie(i) = deelnemers(2);
    end

end