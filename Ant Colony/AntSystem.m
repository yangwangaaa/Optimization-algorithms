function [bestePaden, lengteBestePaden] = AntSystem(cordi, ParAS, beginstad)
% inputs:
%   cordi               matrix, coördinaten steden (2 kolommen: x en y)
%   ParAS               structure, parameters
%   ParAS.fer0          initieel feromoongehalte
%   ParAS.n_ants        aantal mieren in de populatie
%   ParAS.alfa          parameter die rel. invloed feromonen bepaalt
%   ParAS.beta          parameter die rel. heuristische info bepaalt
%   ParAS.rho           degradatiecoëfficiënt feromoonpad
%   ParAS.tmax          aantal iteraties
%   nr_beginstad        scalair, rangnummer van de beginstad
% outputs:
%   bestePaden          s+1 x tmax matrix die per iteratie het beste pad van die iteratie bijhoudt
%   lengteBestePaden    kolomvector die per iteratie de lengte van het beste pad van die iteratie bijhoutd

%% Inlezen parameters
fer0 = ParAS.fer0;
n_ants = ParAS.n_ants;
alfa = ParAS.alfa;
beta = ParAS.beta;
rho = ParAS.rho;
tmax = ParAS.tmax;

%% Initialisatie feromonenpad, toekenning rangnummer steden, berekening afstandsmatrix
s = size(cordi,1);              % aantal steden
steden = 1:s;                   % kolomvector, rangnummer steden

feromonen = ones(s,s)*fer0;     % s x s matrix, initieel feromonenspoor
feromonen(logical(eye(s))) = 0; % naar zelfde node terugkeren gaat niet => 0'en op diagonaal

bestePaden = nan(s+1, tmax);    % preallocatie iteratiematrix die beste pad per iteratie bijhoudt
lengteBestePaden = nan(tmax,1);   % preallocatie iteratiematrix die lengte van beste pad per iteratie bijhoudt

[LAT1, LAT2] = meshgrid(cordi(:,1), cordi(:,1));
[LON1, LON2] = meshgrid(cordi(:,2), cordi(:,2));

R = 6371;
a = sind((LAT1-LAT2)/2).^2+cosd(LAT1).*cosd(LAT2).*sind((LON1-LON2)/2).^2;
c = 2*atan2(sqrt(a),sqrt(1-a));
dist = R * c;                   % afstand tussen steden

%% Optimalisatie
for t = 1:tmax
    lengtePad = zeros(1,n_ants);    % preallocatie van rijvector die per mier de lengte van zijn route bijhoudt
    pad = nan(s+1,n_ants);          % preallocatie van matrix die paden van alle mieren bijhoudt
    
    % opstellen van een route voor elke mier:
    for mier = 1:n_ants      
        restSteden = steden;        % kolomvector die rangnummers resterende steden bevat
        pad(1,mier) = beginstad;    % vertrekpunt toegevoegd aan pad
        restSteden(restSteden==beginstad) = []; % beginstad uit vector met nog te bezoeken steden verwijderd
        % toevoegen resterende steden aan pad:
        for m = 1:s-1
            pad(m+1,mier) = kiesStad(restSteden,pad(m,mier),feromonen,dist,alfa,beta);
            restSteden(restSteden==pad(m+1,mier)) = []; % gekozen stad uit vector met nog te bezoeken steden
            lengtePad(mier) = lengtePad(mier) + dist(pad(m,mier), pad(m+1,mier)); % lengte pad updaten
        end
        pad(s+1,mier) = pad(1);      % vertrekpunt toevoegen om lus te bekomen
        lengtePad(mier) = lengtePad(mier) + dist(pad(s,mier), pad(s+1,mier)); % lengte pad updaten
    end
    
    % kortste pad en lengte kortste pad toevoegen aan iteratiematrix:
    bestePaden(:,t) = pad(:,find(lengtePad==min(lengtePad),1,'first'));
    lengteBestePaden(t) = min(lengtePad);
        
    % updaten feromonen:
    feromonen = updateFerElite(feromonen, pad, lengtePad, rho, bestePaden, lengteBestePaden, ParAS.e);
    
end
end

