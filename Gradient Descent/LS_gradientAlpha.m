function [z]=LS_gradientAlpha(x,alpha,p)

z=LS_gradient (x+alpha*p)' * p;

end