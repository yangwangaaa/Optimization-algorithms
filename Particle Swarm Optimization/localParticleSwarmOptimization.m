function [xStar,iteratiematrix,populatiematrix] = localParticleSwarmOptimization(fun,dimensie,bereik,ParPSO)

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
p = x;
v = rand(ParPSO.popgrootte,dimensie).*((bereik(:,2)-bereik(:,1))*ones(1,ParPSO.popgrootte))'+(bereik(:,1)*ones(1,ParPSO.popgrootte))'; 
fx = fun(x);

%bepaal voor elk partikel de beste buur
for i = 1:ParPSO.popgrootte
    fpg = inf;
    %alle punten in de omgeving (grootte 2) overlopen
    for k = i-2:i+2
        %zorgen dat er geen negatieve of >popgrootte indices voorkomen
        %'verbinden' van eerste en laatste positie
         if k <= 0
              k = ParPSO.popgrootte + k;
         elseif k > ParPSO.popgrootte
             k = k - ParPSO.popgrootte;
         end
        
        %index beste partikel opslaan
        if fun(x(k,:)) < fpg
            fpg = fun(x(k,:));
            g = k;
        end
    end
    %per partikel beste buur selecteren
    pg(i,:) = x(g,:);
end

%bepaal beste globale partikel (voor iteratiematrix)
[fpg_globaal,g_globaal] = min(fun(x)); 
pg_globaal = x(g_globaal,:);
iteratiematrix(1,:) = [pg_globaal fpg_globaal];
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
        %r1 en r2 kiezen
        r = rand(dimensie,1);
        for d = 1:dimensie
            v(i,d) = w(d) * v(i,d) + ParPSO.c1 * r(1) * (p(i,d) - x(i,d)) + ParPSO.c2 * r(2) * (pg(i,d)-x(i,d));
            x(i,d) = x(i,d) + v(i,d);
            
            %x valt links buiten bereik
            if x(i,d) < bereik(d,1)
                x(i,d) = bereik(d,1);
                v(i,d) = -v(i,d);
            end
            
            %x valt rechts buiten bereik
            if x(i,d) > bereik(d,2)
                x(i,d) = bereik(d,2);
                v(i,d) = -v(i,d);
            end
            
            % snelheid < vmax
            v(i,d) = min(vmax(d), v(i,d));
            
        end
        %beste partikel selecteren (pi)
        fx(i,:) = fun(x(i,:));
        if fx(i,:) < fun(p(i,:))
            p(i,:) = x(i,:);
        end
        
        fpg = inf;
        for k = i-2:i+2
            %zorgen dat er geen negatieve of >popgrootte indices voorkomen
            %'verbinden' van eerste en laatste positie
            if k <= 0
                k = ParPSO.popgrootte + k;
            elseif k > ParPSO.popgrootte
                k = k - ParPSO.popgrootte;
            end
            
            %index beste partikel opslaan
            if fun(x(k,:)) < fpg
                fpg = fun(x(k,:));
                g = k;
            end
        end
        %beste partikel opslaan
        pg(i,:) = x(g,:);
            

    end
    
    %bepaal beste globale partikel (voor iteratiematrix)
    [fpg_globaal,g_globaal] = min(fun(x)); 
    pg_globaal = x(g_globaal,:);
    
    iteratiematrix(t,:) = [pg_globaal fpg_globaal];
    populatiematrix(:,:,t) = x;
    
end

xStar = pg_globaal;

end

