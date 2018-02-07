function feromonen = updateFer(feromonen, pad, lengtePad, rho)
% inputs:
%   feromonen       s x s matrix die per boog de hoeveelheid feromonen bevat
%   pad            	s+1 x n matrix die per mier het gekozen pad bevat
%   lengtePad       rijvector die per mier de lengte van zijn route bevat
%   rho             parameter, degradatiecoëfficiënt feromoonpad
% output:
%   feromonen       update van s x s matrix die per boog de hoeveelheid feromonen bevat

dtau_afgezet = zeros(size(feromonen)); % preallocatie van matrix die hoeveelheid feromonen afgezet door alle mieren tezamen bijhoudt
for mier = 1:length(lengtePad) % loop overheen het aantal mieren
    for n = 1:size(pad,1)-1 % loop overheen de nodes van het pad van mier
        dtau_afgezet(pad(n,mier), pad(n+1,mier)) = dtau_afgezet(pad(n,mier), pad(n+1,mier)) + 1/lengtePad(mier);  % Vergelijking 3
        dtau_afgezet(pad(n+1,mier), pad(n,mier)) = dtau_afgezet(pad(n+1,mier), pad(n,mier)) + 1/lengtePad(mier);  % Vergelijking 3
    end
end
% update feromonen (op basis van Vergelijking 4)
feromonen = (1-rho)*feromonen + dtau_afgezet;
end

