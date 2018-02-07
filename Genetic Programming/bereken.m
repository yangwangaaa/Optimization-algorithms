function [ output,diepte ] = bereken( programma,x)
%Functie die recursief de output van een programma berekent en een getal of
%lijst met getallen als antwoord geeft. Deze functie geeft ook de max diepte
%van het programma.

%x: dit geef je als argument mee aan de functie en x is dan gedefinieerd. x
%mag de vorm van een getal of een rijvector hebben

%Als het programma op plaats 1 een functie heeft, moet de functiewaarde
%berekend worden
if strcmp(programma{1}(1),'F')
    [~,arity]=eval(programma{1});%Arity van de functie opslaan.
    f=strcat('@',programma{1});%Functie handle aanmaken in stringvorm.
    f=eval(f);%String omzetten naar functie handle en opslaan in variabele f
    argumenten=cell(1,arity);%Cell array prealloceren voor de argumenten
    diepte=1;%Als er een functie staat, is de diepte min gelijk aan 1.
    diepteVec=zeros(1,arity);% Vector aanmaken om dieptes horend bij elke plaats waar 

    deel{1}=programma{1};
    for i=1:arity%For lus over arity van de functie
        j=length(deel);

	%Het programma slicen vanaf waar het volgende argument staat en recursief
	%bereken uitvoeren.
        [argumenten{i},temp]=bereken(programma(j+1:end),x);
        diepteVec(i)=diepte+temp;%Per argument de diepte van de bijhorende tak opslaan in een vector.
	%Deel moet bij elke toevoeging van een argument ook worden aangevuld,
	%zodanig dat het volgende argument gevonden kan worden. Hier zit mogelijk
	%nog een fout in, want dit werkt wss enkel voor functies met arity 1 tot 2
        deel=[deel,reconstrueer(programma(j+1:end))];
    end
    output=f(argumenten{1:end});%Output van functie genereren.

	%Als het programma op plaats 1 een terminal heeft, is de output gelijk aan de waarde van de terminal. 
else
    output=eval(programma{1});
    diepte=0;%Als op plaats 1 een terminal staat is de diepte 0 (plaats 1 heeft diepte 0)
    diepteVec='error';%Aangeven dat een terminal op plaats 1 staat.
end
if strcmp(diepteVec,'error')
	%Indien geen terminal op plaats 1 stond, moet de maximale diepte bepaald
	%worden over alle takken. Dit is dan de max diepte van de boom.
else
    diepte=max(diepteVec);
end
	%Als het aantal outputs niet gelijk is aan het aantal x-waarden, geeft het
	%programma een constante output. In dat geval moet evenveel keer die output
	%gegenereert worden als dat er x-waarden werden opgegeven.
if numel(x)~=numel(output)
    output=repelem(output,numel(x));
end
end

