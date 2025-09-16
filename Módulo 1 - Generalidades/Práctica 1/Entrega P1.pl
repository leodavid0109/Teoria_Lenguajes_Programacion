hijo(sebas, estefa). hijo(sebas, mario).
hijo(juanita, estefa). hijo(juanita, mario).
hijo(estefa, carlos). hijo(estefa, claudia).
hijo(lola, mario). hijo(rodrigo, consuelo).
hijo(rodrigo, sebas). hijo(marta, juanita).
hijo(freddy, juanita). hijo(susana, juanita).
hijo(marta, luis). hijo(freddy, luis).
hijo(susana, luis).
hombre(sebas). hombre(mario). hombre(carlos). hombre(rodrigo). hombre(freddy).
hombre(luis).
mujer(estefa). mujer(juanita). mujer(claudia). mujer(marta). mujer(susana).
mujer(lola). mujer(consuelo).

padre(P,X) :- hijo(X,P), hombre(P).
madre(M,X) :- hijo(X,M), mujer(M).
sexo_opuesto(X,Y) :- hombre(X), mujer(Y).
sexo_opuesto(Y,X) :- hombre(X), mujer(Y).
abuelo(X,Z) :- padre(X,Y), hijo(Z,Y).
abuela(Y,Z) :- madre(Y,R), hijo(Z,R).
hermanos(X, Y) :- hijo(X, Z), hijo(Y, Z), X\=Y.

% Reglas para tío, sobrino, primos, bisabuela 
% Para el tío; una persona X es tío de una persona Y si X es hombre, y Y es hijo de un hermano de X
tio(X, Y) :- hombre(X), hijo(Y, Z), hermanos(X, Z).
% Para el sobrino; una persona X es sobrino de una persona Y si X es hijo de un hermano de Y
sobrino(X, Y) :- hijo(X, Z), hermanos(Z, Y).
% Para los primos; una persona X es primo de una persona Y si X es sobrino de una persona Z y Y es hijo de dicha persona Z
primos(X, Y) :- sobrino(X, Z), hijo(Y, Z).
% Para la bisabuela; una persona X es bisabuela de una persona Y si Y es hijo de una persona Z y X es abuela de la persona Z
bisabuela(X, Y) :- hijo(Y, Z), abuela(X, Z).
