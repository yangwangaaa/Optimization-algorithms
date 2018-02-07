function [z] = testfunction(x,alpha,p)

z=testfunction2 (x+alpha*p)' * p;

end


function [z]=testfunction2(x)

z=zeros(2,1);
z(1)=2*x(1);
z(2)=2*x(2);

end
