function [xStar,iteratiematrix] = hillClimbing(fun,dimensie,omgeving,bereik)
% Parameterinstellingen voor Hill Climbing voorbeelden:

%fun                        naam van de te optimaliseren functie 
%dimensie                   dimensie van het probleem
%omgeving                   bepaal de grootte van de omgeving
%bereik                     matrix, bereik van het probleem (1 rij per dimensie)

% Preallocatie van xc en xn

xc = zeros(1,dimensie);
xn = zeros(1,dimensie);

% Initialiseer xc, iteratiematrix en lokaal

for i=1:dimensie
    xc(i)=round(rand(1)*(bereik(i,2)-bereik(i,1)) + bereik(i,1));
end
fxc = fun(xc);
iteratiematrix = [xc(1) xc(2) fxc];
lokaal = false;

% Start Hill Climbing algoritme

    while lokaal == false 
        
        beste = 10^20;
        for i = -omgeving:omgeving
            for j = -omgeving:omgeving
                uitkomst = fun([xc(1)+i,xc(2)+j]);
                if uitkomst < beste;
                    beste = uitkomst;
                    xn = [xc(1)+i xc(2)+j]; 
                end
            end
        end
        
        if fun(xn) < fun(xc)
            xc = xn;
            iteratiematrix = [iteratiematrix; xc(1) xc(2) fun(xc)];
        else
            lokaal = true;
            xStar = xc;
        end
        
    end 
      
end
   