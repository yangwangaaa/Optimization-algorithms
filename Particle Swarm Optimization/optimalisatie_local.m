ParPSO.c1 = 1.3;    
ParPSO.c2 = 1.3;
ParPSO.aantalIteraties = 100;
ParPSO.popgrootte = 100;
ParPSO.delta = 0.5;
ParPSO.w = 0.5;

[xStar iteratiematrix populatiematrix] = localParticleSwarmOptimization(@alpine, 2, [-100 100; -100 100], ParPSO);

figure(1)
plotDoelfunctie(@alpine, [-100 100], [-100 100])
plotIteratiesColor(iteratiematrix)
view(0,90)

plotPopulatie(@alpine, [-100 100;-100 100], populatiematrix)
