function [ s,arity ] = Fcosinus( x1 )
%Functie: sinus berekenen
%Berekent de sinus van exact 1 input argument
%Ook de arity wordt als output meegegeven,
%i.e. het aantal argumenten dat deze functie aanvraardt
%default waarden instellen als er te weinig argumenten gegeven worden. Dit
%zorgt ervoor dat de arity gegeven wordt als geen argumenten meegegeven
%worden
if nargin < 1
    x1=1;
    s='not enough input arguments';
else
    s=cos(x1);
end
arity=1;

end
