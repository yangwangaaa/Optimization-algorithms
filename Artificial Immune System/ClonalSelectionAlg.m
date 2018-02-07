function M = ClonalSelectionAlg(S,N,n1,n2,rho,gamma1,gamma2,Nmax)
% Input:    S = Matrix van de patronen die herkend moeten worden
%               (het aantal kolommen stellen het aantal dimensies voor)
%           N = Integer, grootte van de populatie van detectoren
%           n1 = Integer, aantal elementen met een hoge affiniteit die gekloond moeten worden
%           n2 = Integer, aantal elementen met een lage affiniteit die
%                vervangen moeten worden 
%           rho = Reël getal, parameterwaarde voor permutatiefunctie
%           gamma1 = Reël getal, parameterwaarde voor de kloningsfunctie. Deze
%                    bepaalt vanaf welke affiniteit er extra klonen worden
%                    gegenereerd
%           gamma2 = Reël getal, parameterwaarde voor de kloningsfuncite. Deze 
%                    bepaalt hoe sterk een grotere affiniteit beloond wordt
%           Nmax = Integer, het maximaal aantal klonen die geproduceerd kunnen
%                  worden voor een bepaald antilichaam/detector
% Output:   M = Matrix van de gegenereerde geheugencellen, met in de
%               laatste kolom de bijbehorende affiniteiten

% Dimensie L bepalen
L=size(S,2);

% Initialiseren
M=NaN(size(S,1),L+1);

% Initialiseren
g=1;

% Genereren van random detectoren binnen het bereik van de data
P=rand(N,L);
mi=NaN(1,L);
ma=NaN(1,L);
range=NaN(1,L);


%% Clonale Selectie
for s=1:size(S,1)
    while g==1
        aff=NaN(1,N);
        
        % Genereren van random detectoren binnen het bereik van de data
        for k=1:L
            for n=1:N
                mi(k)=min(S(:,k));
                ma(k)=max(S(:,k));
                range(k)=ma(k)-mi(k);
                P(n,k)=rand*range(k)+mi(k);
            end
        end
        for p=1:size(P,1)
            % De affiniteit berekenen tussen de datapunten en de random
            % detectoren
            aff(p)=Affinity(P(p,:),S(s,:));
        end
        % De detectoren rangschikken volgens toenemende affiniteit
        Psort=[P aff'];
        Psort=sortrows(Psort,size(Psort,2));
        % De detectoren behouden met de beste affiniteiten (=laagste waarden, volgens
        % euclidische afstand)
        P1=Psort(1:n1,:);
        Dmax=max(P1(:,end));
        
        % Aanmaken van de klonen van de "beste" antilichamen
        m=1;
        for c=1:size(P1,1)
            Clones=Clone(P1(c,1:end-1),P1(c,end),gamma1,gamma2,Nmax,Dmax);
            aantal=size(Clones,1);
            C(m:(aantal+m-1),:)=Clones;
            m=m+aantal;
        end
        
        % Mutatie uitvoeren op de klonen
        D=NaN(size(C,1),L);
        for d=1:size(C,1)
            D(d,:)=Hypermut(C(d,1:end-1),C(d,end),Dmax,rho);
        end
        
        % Herinitialiseren van de affiniteiten
        aff=NaN(1,size(D,1));
        % Berekenen van de affiniteiten van de gemuteerde klonen op de data
        for c1=1:size(D,1)
            aff(c1)=Affinity(D(c1,:),S(s,:));
        end
        % De detectoren rangschikken volgens toenemende affiniteit
        D=[D aff'];
        Msort=sortrows(D,size(D,2));
        if Msort(1,end)<=0.3
            M(s,:)=Msort(1,:);
            g=g+1;
        end
        m=rand(n2,L);
        P(end-n2+1:end,:)=m;
    end
    g=1;
end
% Figuur maken
if L==2
    figure()
    plot(S(:,1),S(:,2),'g','markersize',10)
    hold on
    plot(M(:,1),M(:,2),'r.','markersize',10)   
    hold off
    axis([min(M(:,1)) max(M(:,1)) min(M(:,2)) max(M(:,2))])
    legende=legend('Normaal patroon','Geheugencellen');
    set(legende,'FontSize',10);
    title('Klonale selectie algoritme')
    xlabel('Tijd (dag)')   
    datetick('x',1)
    ylabel('Temperatuur (°C)')
    set(gca,'fontsize',15)
end
end

