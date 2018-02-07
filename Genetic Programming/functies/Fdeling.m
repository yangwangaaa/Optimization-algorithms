function [ quot,arity ] = Fdeling( x1,x2 )
%Functie: quotiënt berekenen
%Berekent het quotiënt van exact 2 input argumenten
%Ook de arity wordt als output meegegeven,
%i.e. het aantal argumenten dat deze functie aanvraardt

%default waarden instellen als er te weinig argumenten gegeven worden. Dit
%zorgt ervoor dat de arity gegeven wordt als geen argumenten meegegeven
%worden
if nargin < 2
    x1=1;
    x2=1;
    quot='not enough input arguments';
else
    quot=x1./x2;
end


arity=2;

end