ParSCE.p = 5;
ParSCE.m = 3;
ParSCE.n = 2;
ParSCE.q = 3;
ParSCE.alfa = 5;
ParSCE.beta = 5;
ParSCE.factor = .9;
ParSCE.threshold = 0.5;
ParSCE.maxit = 50;

[xStar,iteratiematrix, populatiematrix] = SCE(@alpine, [-20 20; -20 20], ParSCE);
plotPopulatie(@alpine, [-20 20; -20 20], populatiematrix)