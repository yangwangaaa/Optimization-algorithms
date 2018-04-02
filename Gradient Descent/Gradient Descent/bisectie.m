function [alphaInt]=bisectie(funGradAlpha, x, p, initInterval, eps)

a = initInterval(1);
b = initInterval(2);

f_alpha_a = funGradAlpha(x,a,p);
f_alpha_b = funGradAlpha(x,b,p);

while abs(f_alpha_a) > eps || abs(f_alpha_b) > eps
    c = (a + b)/2;
    f_alpha_c = funGradAlpha(x,c,p);
    
    if f_alpha_c < 0
        a = c;
        f_alpha_a = funGradAlpha(x,a,p);
    else
        b = c;
        f_alpha_b = funGradAlpha(x,b,p);
    end
end
alphaInt = [a b];
