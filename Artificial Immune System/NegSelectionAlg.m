function A = NegSelectionAlg(S,r,n)
% Input:    S = Matrix van de data die als normaal beschouwd wordt
%           r = Scalair, de drempelwaarde
%           n = Integer, aantal detectoren die gegenereerd moeten worden
% Output:   A = Matrix van de detectoren die abnormaal gedrag kunnen waarnemen

% Dimensie bepalen
L=size(S,2);

% Initialiseren 
j=1;
A=NaN(n,L);
aff=NaN(1,size(S,1));
m=NaN(1,L);

%% Negatieve Selectie Algoritme implementeren

while j<=n
    % Genereren van random detectoren binnen het interval van de data
    mi=nan(1,L);
    ma=nan(1,L);
    range=nan(1,L);

    for k=1:L
        mi(k)=min(S(:,k));
        ma(k)=max(S(:,k));
        range(k)=ma(k)-mi(k);
        m(1,k)=rand*range(k)*2+mi(k)-range(k)/2;
    end

    % Voor elke datapunt de affiniteit berekenen met alle detectoren
    for i=1:size(S,1)
        % er wordt gewerkt met de euclidische afstand
        aff(i)=Affinity(m,S(i,:));
    end
    
    % Rekening houdend met het feit dat een grote affiniteit overeenkomt
    % met een kleine afstand
    min_aff=min(aff);
    
    % Indien de affiniteit groter is dan een bepaald threshold, wordt de
    % detector behouden
    if min_aff >= r
        A(j,:) = m;
    end
    
    % Volgende detector initialiseren
    j=j+1;
end

% Figuur maken
if L==2
    figure()
    plot(S(:,1),S(:,2),'g.','Markersize',10)
    hold on
    plot(A(:,1),A(:,2),'r.','Markersize',10)
    hold off
    legende=legend('Normaal gedrag data','Detectoren die abnormaal gedrag detecteren');
    set(legende,'FontSize',10);
    title('Negatief selectie algoritme')
    xlabel('Tijd (uur)')   
    datetick('x',15)
    ylabel('Temperatuur (°C)')
    set(gca,'fontsize',15)
end

end
