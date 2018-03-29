clc
clear all
close all
start = datestr(now);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  Pad functies toevoegen %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

added_path = [pwd,'/functies']; 
addpath(added_path);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%      Fitness Param      %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ParFit.error = 'RMSE';      %root mean squared error ('RMSE') of mean absolute deviation (niet 'RMSE')
ParFit.maxDiepte=12;         %Vanaf deze diepte wordt de fitness op infinity gezet

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%     Offspring Param     %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ParOS.kruisKans = 0.8; 
ParOS.muteerKans = 0.05;
ParOS.mutMethode = 'punt';  %Puntmutatie of headless chicken
ParOS.nodeKans = 0.9;       %Verhoogt kans dat een functie geselecteerd wordt bij kruisen.
ParOS.puntKans = 0.10;      %Kans dat per node gemuteerd wordt.
ParOS.getalKans = 0.9;      %Kans dat constante muteert bij puntmutatie.
ParOS.diepteNieuw = 10;     %Diepte nieuw gegenereerde nakomeling
ParOS.methodeNieuw = 'grow';%Methode genereren nakomeling
ParOS.maxHeadless = 6;      %max diepte nieuwe tak bij headless chicken


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%      Data inlezen       %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('data.mat');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%     Herhaling Param     %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

aantalBeste=1;              %Aantal programma's dat je overhoudt van vorige herhaling
maxHerhalingen=1;          %Meerdere herhalingen lopen. Integer. Minstens 1.
vervolg=true;              %Bepalen of je verder doet van een vorige run of niet.
aantalvorig = 5;            %aantal keer programma uit vervolg herhaald wordt in nieuwe populatie
vervolgProgramma = 'weerSim.dat';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%      Instellingen       %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

generations = 200;           %Maximaal aantal iteraties. 
popSize = 50;               %Populatiegrootte
retain = 1;                 %Aantal programma's dat je overhoudt van vorige populatie (elitisme) binnen een herhaling.

%input
terminals={'x','x','x','x','x','x','3.14','2','3','random'};
functies={'Fsom','Fproduct','Faftrekking','Fsinus','Fcosinus'};

%Methode om random populatie te generen. Mag zijn: 'full', 'grow', 'rampedHalfAndHalf'
methode = 'full';
diepteTree=5;               %Voor full of grow: maximum diepte. Voor ramped half en half: maximumwaarde van range.

deleteConstants=true;       %Verwijder programma's die enkel constanten bevatten
delCtGrowMethod='grow';     %Methode voor creatie nieuw programma na verwijderen constant programma. Mag 'grow' of 'full' zijn.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%          Model          %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t=1;
fitness = zeros(popSize,1);
best=cell(1,generations);           %beste programma van de verschillende generaties
best_fitness=zeros(1,generations);  %beste fitness van de verschillende generaties
new_prog=cell(1,popSize);    

%plot van beste programma's
legendInfo=cell(1,maxHerhalingen+1);
legendInfo{1}='data';
best_fitness_sequenties=zeros(1,maxHerhalingen);
bestSequenties=cell(1,maxHerhalingen);
if maxHerhalingen>1
    figure(1)
    plot(data)
    hold on
end


while  t<=maxHerhalingen
    fprintf(strcat('Herhaling: ','\t',num2str(t),'\n'));
    if (t==1 && ~vervolg)
        %nieuwe random populatie
        populatie=rndPop(popSize,functies,terminals,diepteTree,methode);
    elseif (t==1 && vervolg)
        %Vorig resultaat laden.
        fid = fopen(vervolgProgramma,'rt');
        programma = textscan(fid, '%s', 'HeaderLines',0);
        programma = vereenvoudig(programma{1}');
        fclose(fid);
        terminals=modifyTerminals(programma,terminals);
        populatie=rndPop(popSize,functies,terminals,diepteTree,methode);
        %meerdere keren vorige progamma in populatie zetten zodat meer kans
        %op offspring genereren:
        indices=randi(popSize,1,aantalvorig);   
        populatie(indices)={programma};
    elseif t>1
        populatie=rndPop(popSize,functies,terminals,diepteTree,methode);
        %beste aantal van vorige herhaling in nieuwe pop steken
        for i= 1:aantalBeste
            populatie{i} = progBeste{i};
        end
    end
    
    for i= 1:popSize%Fitness van gehele populatie opslaan.
            fitness(i) = comparePoints(populatie{i},data,ParFit);
    end
    [~,I] = sort(fitness);
    best{1} = populatie{I(1)};                  %Opslaan programma met laagste fout.
    best_fitness(1) = fitness(I(1));            %Onthouden laagste fout.
    new_prog(1:retain) = populatie(I(1:retain));%Beste programma('s) behouden (elitisme)

    

    for k=2:generations
        %display(k); 
        fprintf('.'); %Monitor
        for i=retain+1:popSize 
            indexes1 = [randi(length(populatie)),randi(length(populatie))];%Kies random 2 individuen.
            [~,I1] = min(fitness(indexes1));%Kies beste van de 2: één ouder.
            indexes2 = [randi(length(populatie)),randi(length(populatie))];%Idem
            [~,I2] = min(fitness(indexes2));%Tweede ouder
            %maak offspring:
            new_prog{i}=offspring(populatie{indexes1(I1)},populatie{indexes2(I2)},functies,terminals,ParOS);
        end
        populatie = new_prog;%Populatie updaten voor nieuwe loop
        
        schak=0;
        for i=1:length(populatie)
            %Alle programma's waar de variabele x niet in voorkomt vervangen door random nieuw programma.
            if (~max(strcmp(populatie{i},'x')) && deleteConstants)
                populatie{i}=genRndPrg(functies,terminals,diepteTree,delCtGrowMethod);
                if i<=retain
                    schak=1;
                end
            end
            %Ook fitness nieuwe populatie opslaan.
            fitness(i) = comparePoints(populatie{i},data,ParFit);
        end
        if schak==1
            populatie(1:retain)=new_prog(1:retain);
            for i=1:retain
                fitness(i) = comparePoints(populatie{i},data,ParFit);
            end
        end
        [~,I] = sort(fitness);
        best{k} = populatie{I(1)};                  %Opslaan programma met laagste fout.
        best_fitness(k) = fitness(I(1));            %Onthouden laagste fout.
        new_prog(1:retain) = populatie(I(1:retain));%Beste programma('s) behouden (elitisme)

    end
    
    progBeste=cell(1,aantalBeste);                  %Beste bijhouden voor volgende herhaling
    for i=1:aantalBeste
        progBeste(i) = vereenvoudig(populatie(I(i)));
    end

    programma=vereenvoudig(best{end});
    bestSequenties{t}=programma;                    %Beste programma van deze herhaling opslaan.
    best_fitness_sequenties(t)=best_fitness(end);   %Laagste fout van deze herhaling opslaan.
    
    if maxHerhalingen>1
        plot(bereken(programma,[1:108]))                %Plot beste programma van deze herhaling
        legendInfo{t+1} = ['run ' num2str(t)];
        hold on
    end
    
    terminals=modifyTerminals(programma,terminals); 
    t=t+1;
    fprintf('\n');
end
if maxHerhalingen>1
    title('Evolutie')
    xlabel('maanden (1 = januari 2000)')
    ylabel('gemiddelde temperatuur (°C)')
    legend('data',legendInfo)
    hold off
end
%einde plot beste programma's

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  Opslaan laatste result %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fileID = fopen(strcat('eindProgramma','.dat'),'w');
formatSpec = '%s \n';
[nrows,ncols] = size(programma);
for row = 1:ncols
    fprintf(fileID,formatSpec,programma{row});
end
fclose(fileID);
