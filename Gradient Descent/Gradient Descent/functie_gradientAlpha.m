function [z] = functie_gradientAlpha(x, alpha, p)

z=functie_gradient(x+alpha*p)' * p;


end

