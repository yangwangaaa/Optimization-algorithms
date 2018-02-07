% [xStar iteratiematrix] = hillClimbing(@opt_LS, 2, 2, [-20 20;-20 20]);
% 
% plotDoelfunctie(@opt_LS, [-20 20], [-20 20])
% plotIteratiesColor(iteratiematrix)

% [xStar iteratiematrix] = hillClimbing(@alpine, 2, 2, [0 100;0 100]);
% 
% plotDoelfunctie(@alpine, [0 100], [0 100])
% plotIteratiesColor(iteratiematrix)
% view(0,90)

ParSA.Tmax = 100;
ParSA.Tmin = 0.001;    
ParSA.r = 0.99;        
ParSA.kT = 50;

[xStar iteratiematrix] = simulatedAnnealing(@alpine, 2, 5, [0 100;0 100], ParSA);
plotDoelfunctie(@alpine, [0 100], [0 100])
plotIteratiesColor(iteratiematrix)
view(0,90)
