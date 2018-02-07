function C = Clone(P1,aff,gamma1,gamma2,Nmax,Dmax)
% Clone maakt de klonen van de "beste" antilichamen (nl. de
% antilichamen met de hoogste affiniteit) aan
% Input:     P1 = Rijvector van beste antilichamen (1,dimensie)
%            aff = Reëel getal, bijhorende affiniteit bij P1
%            gamma1 = Reël getal, parameterswaarde voor de kloningsfunctie,
%                     bepaalt vanaf welke affiniteit er extra klonen worden
%                     gegenereerd
%            gamma2 = Reëel getal, parameterwaarde voor de kloningsfuncite, 
%                     bepaalt hoe sterk een grotere affiniteit beloond wordt
%            Nmax = Intiger, het maximaal aantal klonen die geproduceerd kunnen
%                   worden voor een bepaald antilichaam/detector
%            Dmax = Reëel getal, de maximale affiniteit binnen de n1 beste
%                   detectoren
% Output:    C = Matrix van de klonen van de "beste" antilichamen, de rijen
%                zijn de klonen en de kolommen de dimensie en de 
%                bijbehorende affiniteiten

% Affiniteit normaliseren ten opzichte van de maximale affiniteit Dmax
x=aff/Dmax;

% Aantal klonen bepalen via kloningsfunctie
nclons=round(Nmax./(1+gamma1*exp(gamma2*x)));

% Klonen aanmaken
C=repmat([P1 aff],[nclons,1]);
end

