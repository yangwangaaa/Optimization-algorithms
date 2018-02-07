function A = muteer(A, ParGA)
% Deze functie voert de mutatie van een individu uit
% Input:   A    =       individu uit de populatie
%          ParGA         = structure bevat de parameters van het genetisch
%          algoritme  (!!! aangepast)
% Output:  A    =       gemuteerd individu
%

for i = 1:length(A.genotype)
    for j = 1:size(A.genotype,1)
        if rand <= ParGA.pmut
             A.genotype(j,i) = round(rand);
        end
    end
end

end