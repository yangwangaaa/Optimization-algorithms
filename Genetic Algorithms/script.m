dimensie = 10;
decodering = [100; 0; 100; 0; 0; 1; 1];
ParGA.maxgen = 500;
ParGA.pop = 100;
ParGA.pcross = 0.7;
ParGA.pmut = 0.05;

[xStar,iteratiematrix] = genetischAlgoritme(@alpine,dimensie,ParGA,decodering);

figure(1)
plotDoelfunctie(@alpine, [0 100], [0,100])
plotIteratiesColor(iteratiematrix)
view(0,90)
