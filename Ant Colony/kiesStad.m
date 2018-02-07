function next = kiesStad(restSteden, huidigeStad, feromonen, dist, alfa, beta)
% inputs:
%   restSteden      rijmatrix die de nog te bezoeken steden bevat
%   huidigeStad     rangnummer van de stad van waaruit mier volgende stad zal kiezen
%   feromonen       s x s matrix die per boog de hoeveelheid feromonen bijhoudt
%   dist            s x s afstandsmatrix
%   alfa            parameter die invloed feromonen bepaalt
%   beta            parameter die heuristische waarde bepaalt
% output:
%   next            rangnummer van de stad die de mier als volgende bestemming kiest

% ant-decision tabel bepalen
eta = 1./dist(restSteden,huidigeStad);   % omgekeerde afstand huidige stad tot resterende steden
tau = feromonen(restSteden,huidigeStad); % feromoonhoeveelheid boog huidige stad - resterende stad               
a = (abs(tau).^alfa .* eta .^beta)/sum(abs(tau).^alfa .* eta .^beta);     

% kans om gekozen te worden bepalen per stad en stochastisch volgende bestemming bepalen
p = a/sum(a);               % kans op selectie per stad - Vergelijking 2
cum_p = cumsum(p);          % cumulatieve kans
next = restSteden(find(rand(1) < cum_p, 1, 'first'));  % selectie volgende stad a.d.h.v. in welk interval random cijfer valt
end

