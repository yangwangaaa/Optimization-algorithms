function [ programma ] = puntmutatie(programma,terminals,functies,puntKans,getalKans )
%Functie die puntmutaties uitvoert. Elk element van het programma wordt gemuteerd met de kans pMut.

%programma: te muteren
%terminals: verzameling met terminals waaruit geselecteerd mag worden om te muteren.
%functies: verzameling met functies waaruit geselecteerd mag worden om te muteren.
%puntKans: reëel getal. Kans waarmee in elke punt gemuteerd wordt.
%getalKans: kans waarmee de volgende mutatie gebeurt: Ipv. voor een
%constante een andere terminals uit de verzameling te kiezen, een random
%getal bij de constante optellen.


for i=1:length(programma)%Loop over het hele programma.
	%Stopcriteria voor while lus definiëren.
    t=1;
    local=1;
	%Indien voldaan aan de kans pMut.
    if rand<puntKans
		%COntroleer of element een functie is
        if strcmp(programma{i}(1),'F')
            lengte=length(functies);
			%Doe maximum evenveel trekkingen uit de lijst als de lijst lang is. 
            while (t<=lengte && local)
				%Kies een random nieuwe functie uit de lijst met functies.
                functie=functies{randi(lengte)};
				%Controleer of de arities van de oude en nieuwe functie overeen komen.
                [~,arity1]=eval(functie);
                [~,arity2]=eval(programma{i});
				%Indien de arities overeenkomen, breek uit de while lus.
                if arity1==arity2
                    local=0;
                    programma{i}=functie;
                end
				%Indien niet: volgende iteratie in while lus.
                t=t+1;
            end
			%Anders, controleer of element de variabele x is
        elseif strcmp(programma{i},'x')
			%Indien wel, kies een random nieuwe terminal
            temp=terminals{randi(length(terminals))};
                if(strcmp(temp,'random'))%als de terminal de string 'random' is,
				%random getal genereren voor de terminal.
                    programma {i}= num2str(round(randi(10)*rand/rand,2));
                else%Anders de terminal uit temp behouden
                     programma{i}= temp;
                end
        else
			%Anders is het een getal en dan zal met kans=getalKans
            if rand<getalKans
                if rand<5
                    teken=-1;
                else
                    teken=1;
                end
                programma{i}=num2str(eval(programma{i})+teken*(round(randi(10)*rand/rand,2)));
            else
                temp=terminals{randi(length(terminals))};
                if(strcmp(temp,'random'))
                    programma {i}= num2str(round(randi(10)*rand/rand,2));
                else	%Anders de terminal uit temp behouden.
                     programma{i}= temp;
                end
            end
        end
    end
end

end

