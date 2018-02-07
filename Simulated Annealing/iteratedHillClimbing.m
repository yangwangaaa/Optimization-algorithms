n = 10;         %aantal iteraties
plotDoelfunctie(@alpine, [0 100], [0 100]);
xStar = [];

for i = 1:n
    [xStar_nieuw iteratiematrix] = hillClimbing(@alpine, 2, 2, [0 100;0 100]);
    plotIteratiesColor(iteratiematrix)
    xStar = [xStar; xStar_nieuw];
end

