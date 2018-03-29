dimensie = 10;
decodering = [20; -20; 20; -20; 0; 1; 1];
ParGA.maxgen = 500;
ParGA.pop = 10;
ParGA.pcross = 0.7;
ParGA.pmut = 0.25;

[xStar,iteratiematrix] = genetischAlgoritme(@alpine,dimensie,ParGA,decodering);

figure(1)
plotDoelfunctie(@alpine, [-20, 20], [-20,20])
plotIteratiesColor(iteratiematrix)
view(0,90)
