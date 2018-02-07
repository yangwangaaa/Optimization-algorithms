function populatieNieuw = recombineerPop(populatie, selectie, ParGA)
% Deze functie voert de recombinatie van de populatie uit
% Input:   populatie      = structuur met gegevens omtrent de fitness, genotype en fenotype 
%          selectie       = vector bevat de indices van de geselecteerde individuen
%          ParGA          = structure, bevat de parameters van het genetisch algoritme   
% Output:  populatieNieuw = structure met gegevens omtrent de fitness, genotype en fenotype van de nieuwe populatie

for i = 1:2:length(populatie)
    ouder1 = populatie(selectie(i));
    ouder2 = populatie(selectie(i+1));
    [kind1 kind2] = kruis(ouder1, ouder2, ParGA);
    kind1 = muteer(kind1, ParGA);
    kind2 = muteer(kind2, ParGA);
    populatieNieuw(i) = kind1;
    populatieNieuw(i+1) = kind2;
end
