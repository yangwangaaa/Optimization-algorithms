function [grad] = functie_gradient(x)

dx1 = 2*x(1)+exp(x(1))+4*x(2);
dx2 = 4*x(1)+exp(x(2))+8*x(2); 

grad = [dx1; dx2];

end

