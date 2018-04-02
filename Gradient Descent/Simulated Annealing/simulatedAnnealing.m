function [xStar,iteratiematrix]=simulatedAnnealing(fun,dimensie,omgeving,bereik,ParSA)

% parameterinstellingen voor Simulated Annealing:
% fun        string, naam van de te optimaliseren functie 
% dimensie   integer, dimensie van het probleem
% bereik     matrix, bereik van het probleem (1 rij per
%                                   dimensie)
% omgeving   integer, bepaalt de grootte van de omgeving
% ParSA      structuur, parameterinstellingen voor simulated annealing:

%   ParSA.Tmax      maximumtemperatuur
%   ParSA.Tmin      minimumtemperatuur
%   ParSA.r         koelsnelheid
%   ParSA.kT        aantal iteraties

% Preallocatie van xc en xn 

xc = zeros(1,dimensie);
xn = zeros(1,dimensie);

% Initialisatie van xc en iteratiematrix

for i = 1:dimensie
    xc(i) = round(rand(1)*(bereik(i,2)-bereik(i,1)) + bereik(i,1));
    %controleer of xc binnen het bereik ligt, anders kies een nieuwe xc
    while xc(i) < bereik(i,1) | xc(i) > bereik(i,2)
        xc(i) = round(rand(1)*(bereik(i,2)-bereik(i,1)) + bereik(i,1));
    end
end

fxc = fun(xc);
iteratiematrix = [xc(1) xc(2) fxc];
T = ParSA.Tmax;

% Start Simulated Annealing algoritme

while T > ParSA.Tmin
    
       for i = 1:ParSA.kT
           
           %kies een willekeurige xn (uit de omgeving van xc)
           for i = 1:dimensie
                xn(i) = xc(i)+round(rand(1)*2*omgeving-omgeving);
                %controleer of xn in het bereik ligt, kies anders een
                %nieuwe xn
                while xn(i) < bereik(i,1) || xn(i) > bereik(i,2)
                    xn(i) = xc(i)+round(rand(1)*2*omgeving-omgeving);
                end
           end
           
           %weerhoud het punt indien het beter is
           if fun(xn) < fun(xc)
               xc = xn;
               iteratiematrix = [iteratiematrix; xc(1) xc(2) fun(xc)];
           else
               %weerhoud het punt indien het slechter is met kans ...
               kans = exp(-(fun(xn)-fun(xc))/T);
               if rand(1) < kans
                   xc = xn;
                   iteratiematrix = [iteratiematrix; xc(1) xc(2) fun(xc)];
               end
           end
           T = ParSA.r*T;
       end
end

xStar = xc;

end
