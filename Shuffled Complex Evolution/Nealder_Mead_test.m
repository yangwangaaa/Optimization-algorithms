%Dit kan direct gerund worden

fun = @kwadraat;
bereik = [0 10; 0 10];
grenzen = bereik;
ParSCE.q = 3;
ParSCE.n = 2;

%Test Nealder-Mead A
A = [1 1 2; 2 2 4; 2 3 13];
Nealder_Mead(A, fun, bereik, ParSCE, grenzen)

%Test Nealder-Mead B
B = [0 4 16; 2 2 8; 3 5 34];
Nealder_Mead(B, fun, bereik, ParSCE, grenzen)
