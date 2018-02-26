% TSP waarbij volgende steden dienen bezocht te worden:
% Athene, Barcelona, Peking, Brussel, Cairo, Bangkok, Guatemala City,
% Havana, Helsinki, Londen, Mexico City, New Delhi, Moskou, Chicago, Las
% Vegas, Montreal, New York, Houston, Dakar, Mecca, Buenos Aires, Brasilia,
% Dar es Salaam, Jakarta, Johannesburg, Kingshasa, Lima, Montevideo, Punta
% Arenas, Sydney

clc
clear all
close all

cordi = [37.97, 23.72;  % Athene
    41.38, 2.15;        % Barcelona
    39.92, 116.42;      % Peking
    50.87, 4.37;        % Brussel
    30.03, 31.35;       % Caïro
    13.75, 100.50;      % Bangkok
    14.62, -90.52;      % Guatemala City
    23.13, -82.38;      % Havana  
    60.17, 25.00;       % Helsinki
    51.53, -0.83;       % Londen
    19.43, -99.12;      % Mexico City
    28.58, 77.20;       % New Delhi
    55.75, 37.60;       % Moskou
    41.83, -87.62;      % Chicago
    36.17, -115.20;     % Las Vegas
    45.50, -73.58;      % Montreal
    40.78, -73.97;      % New York
    29.75, -95.35;      % Houston
    14.67, -17.93;      % Dakar
    21.48, 39.75;       % Mekka
    -34.60, -58.38;     % Buenos Aires
    -15.78, -47.92;     % Brasilia
    -6.82, 39.28;       % Dar es Salaam
    -6.13, 106.82;      % Jakarta
    -26.20, 28.07;      % Johannesburg
    -4.33, 15.32;       % Kingshasa
    -12.03, -77.02;     % Lima
    -34.87, -56.16;     % Montevideo
    -53.17, -70.93;     % Punta Arenas
    -33.86, 152.2];     % Sydney

ParAS.fer0 = 0.00005;
ParAS.n_ants = 50;
ParAS.alfa = 1;
ParAS.beta = 2;
ParAS.rho = 0.1;
ParAS.tmax = 100;
ParAS.e = 30; % optionele parameter, gebruikt indien Daemon-actie geïmplementeerd wordt
beginstad = 4; % start vanuit Brussel

[paden, lengtes] = AntSystem(cordi,ParAS,4);

bestePad = paden(:, find(lengtes==min(lengtes),1,'first'));
kortsteLengte = min(lengtes);

%% figuur evolutie kortste pad op kaart: 
lg = 18;                        % opmaakparameter
scrsz = get(0,'ScreenSize');    % opmaakparameter
load('World.mat');              % contouren wereld inladen
figure('Position',scrsz)
for t = 1:ParAS.tmax
    clf
    hold on
    colormap('winter')
    imagesc(-179.875:0.25:179.875,-89.875:0.25:89.875,flipud(World))
    axis([-180, 180, -90, 90])
    scatter(cordi(:,2),cordi(:,1),'filled','black') % alle steden in zwart
    plot(cordi(beginstad,2),cordi(beginstad,1),'go','markerfacecolor','m') % beginstad in magenta
    xlabel('Longitude','fontsize',lg)
    ylabel('Latitude','fontsize',lg)
    set(gca,'fontsize',lg)
    set(gca,'xtick',-180:30:180)
    set(gca,'ytick',-90:30:90)
    cordi_pad = cordi(paden(:,t),:);
    plot(cordi_pad(:,2), cordi_pad(:,1),'r-','linewidth',4) % kortste van iteratie t route in rood
    title(['iteration ', num2str(t), ', length shortest path = ', num2str(lengtes(t)), ' km'])
    hold off
    pause(0.1)
end

%% figuur evolutie lengte kortste pad overheen iteraties
lg = 12;
figure()
plot(1:ParAS.tmax,lengtes/1000, '.')
xlabel('iteratie (-)','fontsize',lg)
ylabel('padlengte (10^3 km)','fontsize',lg)
title(['Evolutie lengte kortste pad overheen iteraties, \alpha = ', num2str(ParAS.alfa), ', \beta = ', num2str(ParAS.beta)],'fontsize',lg)
