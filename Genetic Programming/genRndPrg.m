function [ programma ] = genRndPrgOpdracht(funcSet,termSet,maxD,method)
%Random programma generator.
%Een programma wordt opgeslagen als een rijvector in een cell array waarvan
%de cellen strings bevatten die functies of terminals voorstellen. 
%Een programma heeft de prefix structuur. Bij elkaar horende delen zijn af
%te leiden uit de arity van de functies. Bv: som,som,1,2,x=som(som(1,2),x).

%funcSet: lijst met toegelaten functies, bestaande uit strings met de namen van de functies.
%termSet: lijst met toegelaten terminals, bestaande uit strings met de waarde van de terminals.
%maxD: maximum diepte van de tree. Integer. 1ste node of terminal heeft diepte 0.
%method: methode voor creatie random programma's. Moet de string 'grow' of 'full' bevatten.

%initieer cell array
programma={};

if maxD == 0 | (method == 'grow' & rand() < length(termSet)/(length(termSet)+length(funcSet)))
    temp = termSet{randi(length(termSet))};
    if(strcmp(temp,'random'))%Als de terminal de string 'random' is,
							%een random getal genereren voor de terminal.
        programma {1}= num2str(round(randi(10)*rand/rand,2));
    else	%Anders de terminal uit temp behouden.
        programma{1}= temp;
    end
else
    functie = funcSet{randi(length(funcSet))};
    [a, arity] = eval(functie);
    programma = functie;
    for i = 1:arity
        argument = genRndPrg(funcSet, termSet, maxD-1, method);
        programma = [programma, argument];
    end
end
    



    
    
end