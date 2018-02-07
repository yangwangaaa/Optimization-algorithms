function plotDoelfunctie(fun, x1Int, x2Int)
% Deze functie plot de 2D-functie FUN over de rechhoek x1Int x x2Int

% Argumenten
% ----------

% FUN:      function handle naar een doelfunctie (deze functie heeft een (2x1)-vector als input)
% X1INT:    een (2x1)-vector die het bereik beschrijft (eerste dimensie)
%           waarover FUN geplot wordt
% X2INT:    een (2x1)-vector die het bereik beschrijft (tweede dimensie)
%           waarover FUN geplot wordt




% Implementatie van de plotfunctionaliteiten
% ------------------------------------------

h1=(x1Int(2)-x1Int(1))/100; % stapgrootte dim 1
h2=(x2Int(2)-x2Int(1))/100; % stapgrootte dim 2

x=x1Int(1):h1:x1Int(2); % coördinaten dim 1
y=x2Int(1):h2:x2Int(2); % coördinaten dim 2

[X,Y]=meshgrid(x,y); % hulpmatrices grid

% matrix van doelfunctiewaarden binnen grid
matrix=zeros(length(x),length(y));
for i=1:length(x)
   
    for j=1:length(y)
        
       matrix(i,j)=fun([x(i) y(j)]);
        
    end
end

% plotten van 
surf(X,Y,matrix')
xlabel('x_1')
ylabel('x_2')
zlabel('Doelfun')
