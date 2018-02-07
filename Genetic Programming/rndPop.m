function [ populatie ] = rndPop(popSize,funcSet,termSet,maxD,method)
%Creëert populatie random initiële programma's
%Slaat elk programma op in het veld van een cell array
%Deze functie laat toe populaties te creëren met de methode full, grow of
%ramped half and half.

%popSize: populatiegrootte. Moet even zijn.
%funcSet: lijst met toegelaten functies, bestaande uit strings met de namen van de functies.
%termSet: lijst met toegelaten terminals, bestaande uit strings met de waarde van de terminals.
%maxD: 
%-als methode 'full' of 'grow': maximum diepte van de tree.
%-als methode 'rampedHalfAndHalf': max waarde v/d range van de max diepte.
%(1ste node heeft diepte 0)
%method: methode voor creatie random programma's. Moet zijn: 'grow', 'full'
%of 'rampedHalfAndHalf'

%Cell array voor populatie prealloceren
populatie=cell(1,popSize);
if (strcmp(method,'grow')||strcmp(method,'full'))
    for i=1:popSize
        populatie{i}=genRndPrg(funcSet,termSet,maxD,method);
    end
		%Anders ramped half en half methode toepassen
elseif strcmp(method,'rampedHalfAndHalf')

for i=1:round(popSize/2)
    diepte = randi(maxD+1)-1;
    populatie{i}=genRndPrg(funcSet,termSet,diepte,'full');
end

for i=round(popSize/2)+1:popSize
    diepte = randi(maxD+1)-1;
    populatie{i}=genRndPrg(funcSet,termSet,diepte,'grow');
end

end

end

