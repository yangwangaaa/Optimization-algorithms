function [xStar,iteratiematrix, populatiematrix] = SCE(fun, bereik, ParSCE)

%input:
%fun                        string, naam van de te optimaliseren functie 
%ParSCE                     structuur, parameterinstellingen voor simple complex evolution
%   ParSCE.p                aantal complexen
%   ParSCE.m                punten per complex
%   ParSCE.n                aantal dimensies
%   ParSCE.q                aantal punten dat geselecteerd wordt uit een complex
%   ParSCE.alfa             aantal keer dat Nealder-Mead wordt doorlopen per complex
%   ParSCE.beta               
%   ParSCE.maxit            het maximum aantal iteraties dat gedaan wordt
%   ParSCE.factor           de factor die bepaalt waarbinnnen de populatie zich moet bevinden voor het algoritme stopt
%   ParSCE.threshold        threshold voor de objectieffunctie om te zeggen wanneer het algoritme moet stoppen

%output:
%xStar	                    vector het gevonden optimum
%iteratiematrix             matrix met in elke generatie het beste punt in de zoekruimte en bijhorende functiewaarde
%populatiematrix            matrix met alle punten op elke tijdstap


%Totaal aantal punten in de populatie
s = ParSCE.p*ParSCE.m;      

%initialisatie van x en de matrices
x = rand(s,ParSCE.n).*((bereik(:,2)-bereik(:,1))*ones(1,s))' + (bereik(:,1)*ones(1,s))';
fx = fun(x);

iteratiematrix = nan(ParSCE.maxit+1, ParSCE.n+1);
populatiematrix = nan(s, ParSCE.n, ParSCE.maxit+1);
complexes(ParSCE.p) = struct();

%Eerste punten toevoegen
[fx, index] = sort(fx);
x = x(index,:);    
iteratiematrix(1,:) = [x(1,:) fx(1)];
populatiematrix(:,:,1) = x;

t=1;


while       sum(((bereik(:,2)-bereik(:,1))'*ParSCE.factor)<(max(x)-min(x))) > 0 && t < ParSCE.maxit + 1 && abs(fx(1)-fx(end)) > ParSCE.threshold

 
    %punten herverdelen in p complexen en CCE toepassen op elk complex
    populatie=nan(s, ParSCE.n+1);
    
    for i = 1:ParSCE.p
        index = i:ParSCE.p:s;
        complexes(i).x = x(index,:);
        complexes(i).fx = fx(index);

        gemeenschap = [complexes(i).x complexes(i).fx]; 
        gemeenschap = CCE(gemeenschap,fun, bereik, ParSCE);
        populatie((ParSCE.m*(i-1)+1):ParSCE.m*i, :)=gemeenschap;
    end
    
    x=populatie(:,1:end-1);
    fx=populatie(:, end);
    
    %sorteren van laag naar hoog volgens de objectieffunctie
    [fx, index] = sort(fx);
    x = x(index,:);
    iteratiematrix(t+1,:) = [x(1,:) fx(1)];
    populatiematrix(:,:,t+1) = x;
    
    t=t+1
end

%verwijder overbodig NaN
iteratiematrix = iteratiematrix(1:t, :);
populatiematrix = populatiematrix(:,:,1:t);


xStar = iteratiematrix(t,1:end-1);
end