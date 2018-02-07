function [kind] = offspring(ouder1, ouder2,functies,terminals,ParOS)
%Functie die een nakomeling produceert voor elke 2 ouders die met toernooiselectie gekozen worden.
%Nakomelingen worden geproduceerd door kruising, mutatie, of door een nieuw random programma aan te maken.

%kruisKans: bepaalt kans op kruisen. Reëel getal.
%muteerKans: bepaalt kans op mutereb. Reëel getal.
%als kruisKans+muteerKans=p<1, dan wordt als nakomeling een random nieuw
%programma gegenereert met de kans 1-p.
%ouder1 en ouder2: de ouders.
%functies en terminals: de primitive set.
%schakelaar: Bepaalt of gemuteerd wordt met puntmutatie of met headless
%chicken. Mag de sting 'punt' zijn of een andere string.
%nodeKans, puntKans en getalKans: reële getallen. Argumenten van functies
%die door offspring opgeroepen worden.
%diepteNieuw: Indien nieuw programma gegenereerd als nakomeling, gebruik deze diepte.
%methodeNieuw: Indien nieuw programma gegenereerd als nakomeling. Mag zijn 'grow' of 'full'.
%maxHeadless: Voor kruising "headless chicken": gebruik deze maximum diepte voor de nieuwe tak.

%Random getal maken om te bepalen hoe de nakomeling geproduceerd wordt
kans=rand;

%Selecteer moeder en vader.
if(rand()>0.5)
    vader = ouder1;
    moeder = ouder2;
else
    vader = ouder2;
    moeder = ouder1;
end

%Enkel kruisen als aan de kans voldaan wordt. Deze kans wordt typisch
%ingesteld op 0.9 of hoger
if kans<ParOS.kruisKans
	%Subtree crossover wordt toegepast. D.w.z. een random tak uit het ene 
	%programma, de "vader", invoegen op een random plaats in het andere, de "moeder".

    randomDeel=slice(vader,ParOS.nodeKans);
    tak=reconstrueer(randomDeel);
    kind=invoegen(moeder,tak);

	%Indien geen kruising en voldaan aan kans voor mutatie: maak een nakomeling
	%door mutatie. Kans op mutatie typisch 0,01.
elseif (ParOS.kruisKans<=kans && kans<ParOS.kruisKans+ParOS.muteerKans)

	%Puntmutatie uitvoeren indien dit gevraagd wordt.
    if strcmp(ParOS.mutMethode,'punt')
        kind=puntmutatie(moeder,terminals,functies,ParOS.puntKans,ParOS.getalKans);
    else%Anders headless chicken mutatie uitvoeren.
        diepteTree=randi(ParOS.maxHeadless)-1;
        tak=genRndPrg(functies,terminals,diepteTree,'grow');
        kind=invoegen(moeder,tak);%Voeg tak in bij te muteren programma.
    end

else
    kind=genRndPrg(functies,terminals,ParOS.diepteNieuw,ParOS.methodeNieuw);
end
end

