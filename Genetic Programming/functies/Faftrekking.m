function [ versch,arity ] = Faftrekking( x1,x2 )
%Functie: verschil berekenen
%Berekent het verschil van exact 2 input argumenten
%Ook de arity wordt als output meegegeven,
%i.e. het aantal argumenten dat deze functie aanvraardt

%default waarden instellen als er te weinig argumenten gegeven worden. Dit
%zorgt ervoor dat de arity gegeven wordt als geen argumenten meegegeven
%worden
if nargin < 2
    x1=1;
    x2=1;
    versch='not enough input arguments';
else
    versch=x1-x2;
end
arity=2;

end