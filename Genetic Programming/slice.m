function [ deel ] = slice(programma,nodeKans )
%Slicet een deel van het programma op een random punt om dit voor kruising te gebruiken.

%programma: hieruit slicen.
%nodeKans: verhoogt de kans dat een functie gekozen wordt. Zie theorie.

deel=programma(randi(length(programma)):end);%Programma slicen op random punt.
if strcmp(deel{1}(1),'F')
	%Als de eerste keer niet gesliced werd voor een functie, herhaal dan de random puntselectie.
else
    while (rand<nodeKans && ~strcmp(deel{1}(1),'F'))
        deel=programma(randi(length(programma)):end);
    end
end

