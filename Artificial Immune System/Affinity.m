function aff = Affinity(m,s)
% Bepalen van de affiniteit tussen de antilichamen/detectoren en de 
% antigenen/data op basis van de euclidische afstand

% Input:    m = Rijvector van de locatie van het antilichaam (1,dimensies)
%           s = Rijvector van de locatie van het antigen (1,dimensies)
% Output:   aff = Reëel getal, de affiniteit tussen het antilichaam en het
%                 antigen

% Euclidische afstand
aff=sqrt(sum((m-s).^2));

end

