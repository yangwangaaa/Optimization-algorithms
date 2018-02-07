function complexes = CCE(complexes,fun, bereik, ParSCE)

%input:
%complexes         matrix dat het complex dat bekeken wordt bevat
%fun               string van te evalueren functie
%bereik            matrix van het bereik van het probleem (1 rij per dimensie)
%ParSCE            bevat alle parameters nodig voor het algoritme (zie SCE.m)

%output:
%complexes         het nieuw gevormde complex

%geef een kans aan elk punt om gekozen te worden volgens de driehoekige distributie
kans = cumsum(2*(ParSCE.m + 1 - (1:ParSCE.m))./(ParSCE.m*(ParSCE.m + 1)));
compindex = zeros(1,ParSCE.q);

%Bepaal de grenzen van de kleinste hypercube
grenzen = [min(complexes(:,1:end-1)); max(complexes(:,1:end-1))]';

for beta=1:ParSCE.beta
    
    %Selecteer een subpopulatie
    for i = 1:ParSCE.q
        gevonden = false;
        while ~gevonden
            a = rand - kans;
            index = find(min(abs(a)) == abs(a));

            if sum(index(1) == compindex) == 0
                gevonden = true;
                compindex(i) = index(1);
            end        
        end
    end

    %Slechtste punt onderaan
    subcomplex = sortrows(complexes(compindex,:),length(bereik)+1);

    %Hier wordt Nealder_Mead toegepast
    for alfa=1:ParSCE.alfa
        subcomplex = Nealder_Mead(subcomplex, fun, bereik, ParSCE, grenzen);
    end
    complexes(compindex, :)=subcomplex;
    complexes=sortrows(complexes, length(bereik)+1);
end
end