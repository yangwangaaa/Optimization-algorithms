ParPSO.c1 = 1.3;    
ParPSO.c2 = 1.3;
ParPSO.aantalIteraties = 500;
ParPSO.popgrootte = 100;
ParPSO.delta = 0.7;
ParPSO.w = 0.7;

dimensie = 10;
grenzen = [-10 10];
bereik = [];
for i = 1:dimensie
    bereik = [bereik; grenzen];
end

[xStar iteratiematrix populatiematrix] = particleSwarmOptimization(@alpine, dimensie, bereik, ParPSO);
figure(1)
plotDoelfunctie(@alpine, grenzen, grenzen)
plotIteratiesColor(iteratiematrix)
view(0,90)
plotPopulatie(@alpine, bereik, populatiematrix)

