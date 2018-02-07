dimensie = 2;
decodering = [10; 0; 100; 0; 0; 1; 1];
ParGA.maxgen = 50;
ParGA.pop = 50;
ParGA.pcross = 0.5;
ParGA.pmut = 0.1;

[xStar,iteratiematrix] = genetischAlgoritme(@alpine,dimensie,ParGA,decodering)