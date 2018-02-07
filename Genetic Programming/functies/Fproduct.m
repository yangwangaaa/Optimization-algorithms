function [ prod,arity ] = Fproduct( x1,x2 )
%Functie: product berekenen
%Berekent het product van exact 2 input argumenten
%Ook de arity wordt als output meegegeven,
%i.e. het aantal argumenten dat deze functie aanvraardt

%default waarden instellen als er te weinig argumenten gegeven worden. Dit
%zorgt ervoor dat de arity gegeven wordt als geen argumenten meegegeven
%worden
if nargin < 2
    x1=1;
    x2=1;
    prod='not enough input arguments';
else
    prod=x1.*x2;
end
arity=2;

end

