function [ slicedMoeder ] = verwijder( moeder,index )
%Wordt opgeroepen door de functie invoegen.m in het geval bij een
%programma, de "moeder", een tak moet worden ingevoegd op de plaats waar
%een functie staat. In dat geval moet heel de bijhorende tak verwijderd
%worden uit de moeder om deze te kunnen vervangen door de geselecteerde
%tak. Deze bijhorende tak verwijderen gebeurt door deze functie.

%moeder: programma waaruit tak zal worden verwijderd.
%index: door invoegen.m geselecteerde plaats waar de functie met bijhorende
%tak verwijderd moet worden.

%De arity v/d fuctie opslaan die staat op positie index in de moeder 
[~,arity]=eval(moeder{index});
	%De te verwijderen tak zal gereconstrueerd worden om zijn lengte te kunnen bepalen
weghalen{1}=moeder{index};%De functie op moeder{index} moet op plaats 1 in die tak komen
for i=1:arity%For lus over arity van die functie
				%Lengte van de tak toe nu toe tellen. Dit geeft weer hoeveel elementen uit 
				%de weg te halen tak er al werden toegevoegd. 
    j=length(weghalen);
				%Via recursie de tak reconstueren. Om de argumenten van de functie die je
				%beschouwt te vinden moet je de moeder slicen op de juiste positie.
    weghalen=[weghalen,reconstrueer(moeder(j+index:end))];
end

%Enkel het benodigde deel v/d moeder bijhouden en een plaats creëren op de
%plaats "index" waar staat 'remove', zodanig dat dit in invoegen.m overschreven kan worden
slicedMoeder=moeder(1:index-1);
slicedMoeder=[slicedMoeder,{'remove'}];
slicedMoeder=[slicedMoeder,moeder(index+length(weghalen):end)];

end


