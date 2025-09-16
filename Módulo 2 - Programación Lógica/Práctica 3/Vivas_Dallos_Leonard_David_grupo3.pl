% Algoritmo Potencia con Recursión Normal
potencia(0, _, 1) :- !.
potencia(Exponente, Número, Resultado) :-
    Exponente > 0,
    Exponente1 is Exponente - 1,
    potencia(Exponente1, Número, Subresultado),
    Resultado is Número * Subresultado.

% Uso ejemplo: potencia(exponente, número, Resultado). Cambiar exponente y número por los dos valores deseados.


% Algoritmo Potencia con Tail Recursion
potencia2(Exponente, Número, Resultado) :-
    potencia2_aux(Exponente, Número, 1, Resultado).

potencia2_aux(0, _, Acumulador, Acumulador) :- !.
potencia2_aux(Exponente, Número, Acumulador, Resultado) :-
    Exponente > 0,
    NuevoAcumulador is Número * Acumulador,
    NuevoExponente is Exponente - 1,
    potencia2_aux(NuevoExponente, Número, NuevoAcumulador, Resultado).

% Uso ejemplo: potencia2(exponente, número, Resultado). Cambiar exponente y número por los dos valores deseados.


% Algoritmo Auxiliar para Verificar si un Elemento dado está en una Lista.
pertenece([Elemento | _], Elemento).
pertenece([_ | Resto], Elemento) :-
    pertenece(Resto, Elemento).

% Algoritmo para Contar los Elementos Repetidos de una Lista.
duplicados(Lista, CantidadDuplicados) :-
    duplicados_aux(Lista, [], 0, CantidadDuplicados), !.

% Se usará una lista auxiliar emulando una lista de unicidad de los elementos. Si un elemento de la lista ya pertenece a esta lista, es decir que es repetido, de lo contrario no lo es, y se agrega a la lista.
duplicados_aux([], _, AcumuladorCantidadDuplicados, AcumuladorCantidadDuplicados) :- !.
% Caso en el cual el elemento ya está en la lista de unicidad (ya se pasó alguna vez por este elemento).
duplicados_aux([Elemento | Resto], ListaUnicidad, AcumuladorCantidadDuplicados, CantidadDuplicados) :-
    pertenece(ListaUnicidad, Elemento), 
    NuevaCantidadDuplicados is AcumuladorCantidadDuplicados + 1,
    duplicados_aux(Resto, ListaUnicidad, NuevaCantidadDuplicados, CantidadDuplicados).

% Caso en el cual el elemento no está en la lista de unicidad, se visita por primera vez.
duplicados_aux([Elemento | Resto], ListaUnicidad, AcumuladorCantidadDuplicados, CantidadDuplicados) :-
    duplicados_aux(Resto, [Elemento | ListaUnicidad], AcumuladorCantidadDuplicados, CantidadDuplicados).

% Uso ejemplo: duplicados(lista, CantidadDuplicados). Cambiar lista por la lista a la cual le queremos contar los duplicados.

