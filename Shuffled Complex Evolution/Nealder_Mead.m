function subcomplex = Nealder_Mead(subcomplex, fun, bereik, ParSCE, grenzen)

%input:
%subcomplex         de geselecteerde punten uit het complex
%fun                string van te evalueren functie
%bereik             matrix van het bereik van het probleem (1 rij per dimensie)
%ParSCE             bevat alle parameters nodig voor het algoritme (zie SCE.m)
%grenzen            matrix met de grenzen van de kleinte hypercube (1 rij per dimensie)

%ouput:
%subcomplex         het nieuwe bepaalde subcomplex waarbij het slechste punt vervangen is


%Bepaal slechtste punt 
slechtste = subcomplex(end,1:end-1);
%Bepaal het zwaartepunt van het complex zonder het slechtste punt
g = 1/(ParSCE.q-1)*sum(subcomplex(1:end-1,1:end-1));
%Spiegel het zwaartepunt rond het slechtste punt
r = 2*g-slechtste;
%Indien r buiten het bereik ligt, nieuw punt selecteren binnen het complex
for i = 1:ParSCE.n
    if r(i) < bereik(i,1) || r(i) > bereik(i,2)
        r = rand(1,ParSCE.n).*((grenzen(:,2)-grenzen(:,1))*ones(1,1))' + (grenzen(:,1)*ones(1,1))';
    end
end


%Kijk of r beter is zoniet contractie, indien contractie slechter is nieuw punt selecteren binnen het complex
if fun(r) < fun(slechtste)
    subcomplex = [subcomplex(1:end-1,:); [r fun(r)]];
else
    c = (g + slechtste)/2;
    if fun(c) < fun(slechtste)
       subcomplex = [subcomplex(1:end-1,:); [c fun(c)]];
    else
        r = rand(1,ParSCE.n).*((grenzen(:,2)-grenzen(:,1))*ones(1,1))' + (grenzen(:,1)*ones(1,1))';
        subcomplex = [subcomplex(1:end-1,:); [r fun(r)]]; 
    end
end

end