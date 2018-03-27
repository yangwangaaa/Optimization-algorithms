[xStar iteratiematrix] = hillClimbing(@opt_LS, 2, 2, [-20 20;-20 20]);
 
plotDoelfunctie(@opt_LS, [-25 25], [-25 25])
plotIteratiesColor(iteratiematrix)
view(0,90)

ParSA.Tmax = 100;
ParSA.Tmin = 0.001;    
ParSA.r = 0.99;        
ParSA.kT = 50;

figure()
[xStar iteratiematrix] = simulatedAnnealing(@opt_LS, 2, 2, [-20 20; -20 20], ParSA);
plotDoelfunctie(@opt_LS, [-25 25], [-25 25])
plotIteratiesColor(iteratiematrix)
view(0,90)


