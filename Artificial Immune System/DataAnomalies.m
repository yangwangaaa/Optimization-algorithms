function fig = DataAnomalies(detectorset,dataset,drempelwaarde)
%Deze functie test aan de hand van een set detectoren of er anomaliën
%aanwezig zijn
% Input:    detectorset = Matrix met N rijen en L kolommen set detectoren gegenereerd a.d.h.v. het negatieve selectie
%                         algoritme (N: aantal detectoren & L: aantal dimensies)
%           dataset = Dataset die we willen onderwerpen aan test 
%                     (matrix met L kolommen)
%           drempelwaarde = Scalair die bepaalt of iets normaal is of niet
% Output: fig = figuur van de gedetecteerde anomalieën 

% Initialiseren
m=1;
aff=NaN(1,size(detectorset,1));

%% Anomalie detecteren
for i=1:size(dataset,1)
    for j=1:size(detectorset,1)
        aff(j)=Affinity(detectorset(j,:),dataset(i,:));  
    end
    aff_min=min(aff);
    if aff_min<drempelwaarde
        anomalie(m)=i; 
        m=m+1;
    end    
end

% Figuur maken
if size(detectorset,2)==2
    fig=plot(dataset(:,1),dataset(:,2),'g.','Markersize',20);
    hold on
    plot(dataset(anomalie,1),dataset(anomalie,2),'ro','Markersize',15);
    hold off
    legende=legend('Normaal gedrag data ','Anomalieën');
    set(legende,'FontSize',10);
    title('Anomalie detectie')
    xlabel('Tijd (dag)')   
    datetick('x',15)
    ylabel('Temperatuur (°C)')
    set(gca,'fontsize',15)
end
    
end

