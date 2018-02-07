function [ programma ] = vereenvoudig( programma )
%Vereenvoudigt een programma door takken die de variabele x niet bevatten
%uit te rekenen en te vervangen door de waarde. 

%programma: te vereenvoudigen programma

i=1;
%While lus gebruiken omdat de lengte van het programma kan veranderen
%tijdens de uitvoering.
while i<=length(programma)
    if strcmp(programma{i}(1),'F')%Als op plaats i een functie staat
        deel=reconstrueer(programma(i:end));%Reconstrueer heel de bijhorende tak.
        if ~max(strcmp(deel,'x'))==1%Als in die tak de variabele x niet voorkomt.
            [resultaat,~]=bereken(deel,1);%Bereken de constante waarde die de tak voorstelt
            tempResultaat{1}=num2str(resultaat);
            programma=verwijder(programma,i);%Verwijder vervolgens heel de bijhorende tak
											%De tak is vervangen door een leege plaats
            temp=programma(1:i-1);%Slice dus tot voor die plaats.
            temp=[temp,tempResultaat];%Plak de berekende waarde achter de slice
            programma=[temp,programma(i+1:end)];%Voeg het deel achter de lege plaats terug toe
            
        end
    end
    i=i+1;
end


end

