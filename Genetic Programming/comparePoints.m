function [ fitness ] = comparePoints( programma,datapunten,ParFit)
%Vergelijkt de output van een programma met een verzameling datapunten

%programma: te evalueren programma
%datapunten: waarmee vergeleken moet worden
%ParFit.error: vergelijken via root mean squared error of mean absolute deviation.
%Error mag de string 'RMSE' of een andere string zijn.

n=length(datapunten);%Aantal punten in dataset
					%Berekenen functiewaarden die programma oplevert en max diepte programma.
[prog,depth] = bereken(programma,[1:n]);
					%Als max diepte<12, bereken de fout.
if(depth < ParFit.maxDiepte)
    if strcmp(ParFit.error,'RMSE')
        fitness = sqrt(sum((datapunten-prog).^2)/n);
    else
        fitness = sum(abs(datapunten-prog))/n;
    end
	%Als max diepte>=12, wordt de fout van het programma infinity.
else
    fitness = Inf;
end

end

