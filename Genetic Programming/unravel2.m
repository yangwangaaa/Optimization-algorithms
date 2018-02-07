function [ output,depth ] = unravel2( programma )
%Deze functie maakt een sting van het programma dat opgeslagen is in een
%cell array. Deze string kan met eval geëvalueerd worden. Bv: 
%Faftrekking,Fdeling,2,3,5 wordt Faftrekking(Fdeling(2,3),5)

%Controleren of het 1ste element van programma een functie is, welke
%gekaraktriseerd worden doordat hun string begint met F

if strcmp(programma{1}(1),'F')
    [~,arity]=eval(programma{1});%de arity v/d fuctie opslaan
    output=strcat(programma{1},'(');%string initiëren met betreffende functie, bv. 'Faftrekking(' 
    dieptes = [];
    for i=1:arity%for lus over arity
					%aantal ( en , tellen tot nu toe in de string. Dit geeft aan hoeveel
					%elementen uit de originele cell array er al in de sting staan.
        j=length(strfind(output,'('))+length(strfind(output,','));
				%via recursie de volgende delen v/d string oproepen. 

        [deel,diepte]=unravel2(programma(j+1:end));
        output=strcat(output,deel);
        if(i ~= arity)    %zet na ieder argument een komma behalve bij het laatste
            output = strcat(output,',');
        end
        dieptes(i)=diepte;
    end
    depth = max(dieptes)+1;
    output=strcat(output,')');%als het laatste argument van een functie gevonden is: sluit haken
else%
    output = programma{1};
    depth = 0;
end
end
