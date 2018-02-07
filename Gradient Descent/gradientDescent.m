function [xStar, iteratiematrix]=gradientDescent(fun, funGrad, funGradAlpha, x0, alphaMax, eps)

% initieel punt
x=x0;

% (? x 3) iteratiematrix die de punten van de verschillende iteratiestappen
% bevat en de bijhorende doelfunctiewaarden
iteratiematrix=[x(1) x(2) fun(x)];

while norm(funGrad(x)) > eps
    p = -funGrad(x)./norm(funGrad(x));
    a_output = bisectie(funGradAlpha, x, p, [0 alphaMax], eps);
    a = mean(a_output);
    x = x + a*p;
    iteratiematrix = [iteratiematrix; x(1) x(2) fun(x)];
end

xStar = x;