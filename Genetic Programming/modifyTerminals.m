function [ terminals ] = modifyTerminals( programma,terminals)
%Extraheert constanten uit een programma en vervangt de constanten in de
%verzameling van de terminals hierdoor

%programma: hieruit de constanten halen
%terminals: verzameling terminals waaraan de constanten moeten worden toegevoegd.

%Geef alle plaatsen waar geen constanten staan.
 vector=strcmp(programma,'x')+strncmpi(programma,'F',1);
 %Op de andere plaatsen staan dus constanten. Sla deze op.
 constanten=programma(find(~vector));
 %Geef alle plaatsen in terminals waar 'x' of 'random' staat.
 vector=strcmp(terminals,'x')+strcmp(terminals,'random');
 %Sla de constanten die al in terminals stonden op.
 constantenTerminals=terminals(find(~vector));
 %Voeg deze samen met de geëxtraheerde constanten
 constanten=[constanten,constantenTerminals];
 constanten=unique(constanten);%Verwijder dubbele constanten.
 %Voeg de 'x' en 'random' terug toe met het oorspronkelijk aantal
 terminals=[terminals(find(vector)),constanten];
 %Herschik alles op random wijze
 terminals=terminals(randperm(numel(terminals)));
end

