function feromonen = updateFerElite(feromonen, pad, lengtePad, rho, bestePaden, lengteBestePaden, e)
% inputs:
%   feromonen           s x s matrix die per boog de hoeveelheid feromonen bevat
%   pad                 s+1 x n matrix die per mier het gekozen pad bevat
%   lengtePad           rijvector die per mier de lengte van zijn route bevat
%   rho                 parameter, degradatiecoëfficiënt feromoonpad
%   bestePaden          s+1 x tmax matrix die per iteratie het beste pad van die iteratie bijhoudt
%   lengteBestePaden    kolomvector die per iteratie de lengte van het beste pad van die iteratie bijhoudt
%   e                   gewicht toegekend aan de best-so-far route 
% output:
%   feromonen       update van s x s matrix die per boog de hoeveelheid feromonen bevat

lengteBestePad = min(lengteBestePaden);
bestePad = bestePaden(:,find(lengteBestePaden==lengteBestePad,1,'first'));

dtau_mieren = zeros(size(feromonen)); % preallocatie van matrix die hoeveelheid feromonen afgezet door alle mieren tezamen bijhoudt
dtau_elite = zeros(size(feromonen)); % preallocatie van matrix die hoeveelheid feromonen afgezet door elitemier bijhoudt
for n = 1:size(pad,1)-1 % loop overheen de nodes van het pad van mier
    for mier = 1:length(lengtePad) % loop overheen het aantal mieren
        dtau_mieren(pad(n,mier), pad(n+1,mier)) = dtau_mieren(pad(n,mier), pad(n+1,mier)) + 1/lengtePad(mier);  % Vergelijking 3
        dtau_mieren(pad(n+1,mier), pad(n,mier)) = dtau_mieren(pad(n+1,mier), pad(n,mier)) + 1/lengtePad(mier);  % Vergelijking 3
    end
    dtau_elite(bestePad(n), bestePad(n+1)) = 1/lengteBestePad;
    dtau_elite(bestePad(n+1), bestePad(n)) = 1/lengteBestePad;
end

% update feromonen (op basis van Vergelijking 5)
% feromonen = (1-rho)*feromonen + dtau_afgezet;
feromonen = (1-rho)*feromonen + dtau_mieren + e*dtau_elite;
end

