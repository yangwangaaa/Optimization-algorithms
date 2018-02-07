function [ kind ] = invoegen( moeder,tak )
%Creëert een kind door een geselecteerde tak bij een moederprogramma in te voegen op een random punt

index=randi(length(moeder));%Selecteer random punt in moeder
punt=moeder{index};
if strcmp(punt(1),'F')%Als dit punt een functie is moet de hele bijhorende 
%tak verwijderd worden met de functie verwijder.
    moeder=verwijder(moeder,index);
end
kind=moeder(1:index-1);
kind=[kind,tak];
kind=[kind,moeder(index+1:end)];

end

