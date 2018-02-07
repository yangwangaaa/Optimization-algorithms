% [xStar iteratiematrix] = gradientDescent(@opt_LS, @LS_gradient, @LS_gradientAlpha, [10; 10], 300,0.01);
% 
% plotDoelfunctie(@opt_LS, [-20 20], [-20 20])
% plotIteraties(iteratiematrix)

[xStar iteratiematrix] = gradientDescent(@functie, @functie_gradient, @functie_gradientAlpha, [2; 2], 5, 0.01);

xStar
plotDoelfunctie(@functie, [-1 2], [-1 2])
plotIteraties(iteratiematrix)