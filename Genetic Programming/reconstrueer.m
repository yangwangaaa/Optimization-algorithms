function [ tak ] = reconstrueer( randomDeel )
%Extraheert alle bij een tak horende delen uit het gesliced deel dat de functie slice produceert.

%randomDeel: deel dat de functie slice heeft gesliced van een random punt
%tot het einde van het vaderprogramma. De delen die niet bij de tak
%horen moeten verwijderd worden.

%cell array initiëren waarin de tak zal worden opgeslagen
tak={};

if strcmp(randomDeel{1}(1),'F')
    [~,arity]=eval(randomDeel{1});%Indien functie, arity v/d opslaan
    tak{1}=randomDeel{1};%De functie op plaats 1 in de tak steken 
    for i=1:arity%For lus over arity
        j=length(tak);
        tak=[tak,reconstrueer(randomDeel(j+1:end))];
    end
else
    tak{1} = randomDeel{1};
end
end
