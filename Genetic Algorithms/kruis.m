function [kind1 kind2] = kruis(A,B,ParGA)
% Deze functie voert de uniforme crossover uit
% Input:   A,B    =     twee individuen (ouders) uit de populatie
%          ParGA         = structure bevat de parameters van het genetisch
%          algoritme (!!! aangepast)
% Output:  kind1 & kind2 =   kinderen, resultaat uit de crossover van de
%                       ouders

maskers = rand([1 length(A)]);


for i = 1:length(A)
    if maskers(i) <= ParGA.pcross
        for j = size(A,1)
            kind1(j,i) = A(i);
            kind2(j,i) = B(i);
        end
    else
        for j = size(A,1)
            kind1(j,i) = B(i);
            kind2(j,i) = A(i);
        end
    end
end


end

