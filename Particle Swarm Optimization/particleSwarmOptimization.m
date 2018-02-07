function [xStar,iteratiematrix,populatiematrix] = particleSwarmOptimization(fun,dimensie,bereik,ParPSO)

%fun                   string, naam van de te optimaliseren functie
%bereik                matrix, bereik van het probleem (1 rij per dimensie)
%dimensie              integer, dimensie van het probleem
%ParPSO                structure, parameterinstellingen voor PSO

%   ParPSO.popgrootte           populatiegrootte
%   ParPSO.c1                   voorfactor voor invloed beste eigen positie
%   ParPSO.c2                   voorfactor voor invloed beste globale positie
%   ParPSO.delta                factor om vmax te bepalen
%   ParPSO.w                    traagheidsgewicht
%   ParPSO.aantalIteraties      aantal iteraties


% Preallocatie van x, v, p, w, vmax, iteratiematrix en populatiematrix

x = zeros(ParPSO.popgrootte, dimensie); 
p = zeros(ParPSO.popgrootte, dimensie); 
v = zeros(ParPSO.popgrootte, dimensie);
w = zeros(ParPSO.aantalIteraties,1);
vmax = zeros(dimensie,1);
iteratiematrix = zeros(ParPSO.aantalIteraties,dimensie+1);
populatiematrix = zeros(ParPSO.popgrootte,dimensie,ParPSO.aantalIteraties+1);

% Initialisatie van x, v, p, iteratiematrix en populatiematrix
x = rand(ParPSO.popgrootte,dimensie).*((bereik(:,2)-bereik(:,1))*ones(1,ParPSO.popgrootte))'+(bereik(:,1)*ones(1,ParPSO.popgrootte))';
p = x; %want eerste punt is beste dat je al geweest bent
v = rand(ParPSO.popgrootte,dimensie).*((bereik(:,2)-bereik(:,1))*ones(1,ParPSO.popgrootte))'+(bereik(:,1)*ones(1,ParPSO.popgrootte))'; 
fx = fun(x);
fp = fx;
[fpg,g] = min(fp); %bepaal beste partikel
pg = x(g,:);
iteratiematrix(1,:) = [pg fpg];
populatiematrix(:,:,1) = x;

% Bepaal de traagheid w in elke iteratiestap

if length(ParPSO.w)==1
    w(:,1) = ParPSO.w;    
else
    w = ParPSO.w;
end

% Bepaal de vmax per dimensie

   vmax = ParPSO.delta * (bereik(:,2) - bereik(:,1));


% Start Particle Swarm Optimization

for t = 1:1:ParPSO.aantalIteraties

    for i = 1:ParPSO.popgrootte
        %r1 en r2 bepalen
        r = rand(dimensie,1);
        
        for d = 1:dimensie
            v(i,d) = w(d) * v(i,d) + ParPSO.c1 * r(1) * (p(i,d) - x(i,d)) + ParPSO.c2 * r(2) * (pg(d)-x(i,d));
            x(i,d) = x(i,d) + v(i,d);
            
            %indien x links buiten het bereik valt
             if x(i,d) < bereik(d,1)
                x(i,d) = bereik(d,1);
                v(i,d) = -v(i,d);
             end
            
            %indien x rechts buiten het bereik valt
            if x(i,d) > bereik(d,2)
                x(i,d) = bereik(d,2);
                v(i,d) = -v(i,d);
            end
            
            %kleinste kiezen (vmax of v)
            v(i,d) = min(vmax(d), v(i,d));
            
        end
        
        %x opslaan als pi indien het beter is
        fx(i,:) = fun(x(i,:));
        if fx(i,:) < fun(p(i,:))
            p(i,:) = x(i,:);
        end
    end
    %bepaal beste partikel
    [fpg,g] = min(fx); 
    pg = x(g,:);
    
    %iteratie- en populatiematrix aanvullen
    iteratiematrix(t,:) = [pg fpg];
    populatiematrix(:,:,t) = x;
    

    
end

xStar = pg;

end

