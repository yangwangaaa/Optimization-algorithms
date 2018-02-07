function C1 = Hypermut(C,D,Dmax,rho)
% Hypermut zal de mutaties aanbrengen op de klonen
% Input:    C   = Rijvector, de locatie van het antilichamen/detector
%                 (1,dimensie)
%           D = Reëel getal, de affiniteit van de detector/antilichaam
%           Dmax = Reëel getal, de maximale affiniteit binnen de beste n1
%                  detectoren
%           rho  = Reeël getal, de parameterwaarde voor de vlakheid van de
%                  permutatiecurve
% Output:   C1 = Rijvector, de locatie van het gemuteerde
%                antilichamen/detector

sigma=1;        % Standaard afwijking
Dster=D/Dmax;   % Genormaliseerd affiniteit

% Bepalen van de hypermutatiesnelheid alfa
alfa=(exp(-rho*Dster));
% Mutaties aanbrengen op de klonen
if Dster~=1
      C1=C+(1./alfa).*(normrnd(0,sigma,[1,size(C,2)]));
end

end

