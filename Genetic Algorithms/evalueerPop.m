function populatie = evalueerPop(fun,populatie,ParGA,decodering)
% input   fun           = string, bevat de te optimaliseren functienaam
%         populatie     = structure met gegevens omtrent de fitness, genotype en fenotype 
%         ParGA         = structure bevat de parameters van het genetisch algoritme 
%         decodering    = vector bevat de parameters voor de decodering
% output  populatie     = structure met de gegevens omtrent de fitness, genotype en fenotype van de geëvalueerde populatie

for i = 1:length(populatie)
   populatie(i).fenotype = bs2rv(populatie(i).genotype, decodering)';
   populatie(i).fitness = fun(populatie(i).fenotype);
end



end