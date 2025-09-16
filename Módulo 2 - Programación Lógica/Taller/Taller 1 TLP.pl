% TALLER 1 TLP
% INTEGRANTES: Leonard David Vivas Dallos - Tomás Escobar Rivera

% Punto 1
% a) Cuenta la cantidad de ítems que contiene una lista.

contar([], 0). % Caso base: La lista vacía tiene 0 elementos.

contar([_ | Resto], N) :-
    contar(Resto, NResto), % Llamada recursiva para el resto de la lista.
    N is NResto + 1. % Aumenta el contador en 1 por cada elemento encontrado.

% b)Retira todas las ocurrencias de un elemento en una lista.

remover(_, [], []). % Caso base: Si la lista está vacía, el resultado también es una lista vacía.

remover(X, [X | Resto], NuevaLista) :-
    % Si el elemento X es igual al primer elemento de la lista, no lo incluimos en la lista resultante.
    remover(X, Resto, NuevaLista), !.

remover(X, [Y | Resto], [Y | NuevaLista]) :-
    % Si el elemento X no es igual al primer elemento de la lista, lo incluimos en la lista resultante y seguimos buscando en el resto de la lista.
    X \= Y,
    remover(X, Resto, NuevaLista), !.

% c) Calcular la potencia de un número.

potencia(_, 0, 1) :- !. % Cualquier número elevado a la potencia 0 es 1.

potencia(Base, Exponente, Resultado) :-
    Exponente > 0, % Nos aseguramos de que el exponente sea positivo.
    NExponente is Exponente - 1, % Reducimos el exponente en cada llamada recursiva.
    potencia(Base, NExponente, SubResultado), % Llamada recursiva para calcular la potencia con exponente reducido.
    Resultado is Base * SubResultado.


% Punto 2
invertir_numero(N, Invertido) :-
    invertir_numero(N, 0, Invertido).

invertir_numero(0, Invertido, Invertido) :- !. % Agregamos un corte para detener la recursión cuando el número original se ha invertido completamente.

invertir_numero(N, Acumulador, Invertido) :-
    Resto is N mod 10,
    NuevoAcumulador is Acumulador * 10 + Resto,
    NuevoN is N // 10,
    invertir_numero(NuevoN, NuevoAcumulador, Invertido).


% Punto 3
% Hechos
% viaje(origen, destino, precio, transporte) 
viaje(baku, monaco, 15000, jet_privado).
viaje(melbourne, barcelona, 25000, yate).
viaje(las_vegas, sao_paulo, 10000, avion).
viaje(silverstone, susuka, 7000, avion).
viaje(barcelona, baku, 12000, yate).
viaje(sao_paulo, silverstone, 8000, tren_orient_express).
viaje(barcelona, monaco, 12000, jet_privado).
viaje(sao_paulo, monza, 9000, tren_orient_express).
viaje(monza, imola, 21000, jet_privado).
viaje(baku, imola, 9000, yate).
viaje(silverstone, monza, 8000, avion).

% Recursión auxiliar para mostrar lista de Recorridos en el orden correcto
inversionLista(Lista, Invertida) :-
    inversionLista(Lista, [], Invertida).

inversionLista([], Invertida, Invertida).
inversionLista([Elemento | Resto], Acumulador, Invertida) :-
    inversionLista(Resto, NuevoAcumulador, Invertida),
    NuevoAcumulador = [Elemento | Acumulador].

% Llamar a enrutar con lista auxiliar
enrutar(Origen, Destino, Recorrido, Precio_por_trayecto, Precio_total, Tipos_transporte) :-
    enrutar(Origen, Destino, [Origen], RecorridoAux, Precio_por_trayecto, Precio_total, Tipos_transporte),
    inversionLista(RecorridoAux, Recorrido).

% Terminar si ya se llego al destino
enrutar(Origen, Destino, Recorrido, Recorrido, [], 0, []) :-
    Origen == Destino.

enrutar(Origen, Destino, Recorrido, RecorridoFinal, [Precio | RestoPrecios], Precio_total, [Transporte | RestoTransportes]) :-
    viaje(Origen, CiudadIntermedia, Precio, Transporte),
    enrutar(CiudadIntermedia, Destino, [CiudadIntermedia | Recorrido], RecorridoFinal, RestoPrecios, Subtotal, RestoTransportes),
    Precio_total is Precio + Subtotal.

% VIAJES POSIBLES
% las_vegas -> susuka
% las_vegas -> sao_paulo
% las_vegas -> silverstone
% las_vegas -> monza
% las_vegas -> imola
% 
% sao_paulo -> imola
% sao_paulo -> silverstone
% sao_paulo -> susuka
% sao_paulo -> monza
% 
% silverstone -> susuka
% silverstone -> monza
% silverstone -> imola
% 
% monza -> imola
% 
% baku -> monaco
% baku -> imola
% 
% melbourne -> monaco
% melbourne -> barcelona
% melbourne -> baku
% melbourne -> imola
% 
% barcelona -> monaco
% barcelona -> baku
% barcelona -> imola


% Punto 4
% Cada entrada del cuadrado mágico será reconocida con el patrón EIJ donde I representa la fila y J la columna de la entrada con 1 <= I, J <= 3
% NOTA: Por definición de un cuadrado mágico, si los números se limitan a ser del 1 al 9, la única suma que dará un resultado del mismo es si la suma es 15.

% Hechos (Números del 1 al 9)
num(1). num(2). num(3). num(4). num(5). num(6). num(7). num(8). num(9).

% Algoritmo Auxiliar para Verificar si un Elemento dado está en una Lista.
pertenece([Elemento | _], Elemento) :- !.
pertenece([_ | Resto], Elemento) :-
    pertenece(Resto, Elemento).

% Regla que verifica si los elementos de una lista son diferentes entre sí
diferentes([]) :- !.
diferentes([X | Resto]) :-
    not(pertenece(Resto, X)),
    diferentes(Resto).
    
verificador_sumas(N1, N2, N3, Suma) :-
    Suma is N1 + N2 + N3.


cuadrado_magico(R11, R12, R13,
                R21, R22, R23,
                R31, R32, R33,
                Suma) :-
    % Verifico que las Entredas del Cuadrado Mágico sean Números Apropiados
    num(R11), num(R12), num(R13), num(R21), num(R22), num(R23), num(R31), num(R32), num(R33),
    diferentes([R11, R12, R13, R21, R22, R23, R31, R32, R33]),
    % Filas suman lo esperado
    verificador_sumas(R11, R12, R13, Suma),
    verificador_sumas(R21, R22, R23, Suma),
    verificador_sumas(R31, R32, R33, Suma),
    % Columnas suman lo esperado
    verificador_sumas(R11, R21, R31, Suma),
    verificador_sumas(R12, R22, R32, Suma),
    verificador_sumas(R13, R23, R33, Suma),
    % Diagonales suman lo esperado
    verificador_sumas(R11, R22, R33, Suma),
    verificador_sumas(R31, R22, R13, Suma),
    
    % Impresión del cuadrado mágico
    write(' | '), write(R11), write(' | '), write(R12), write(' | '), write(R13), write(' | '), nl,
    write(' | '), write(R21), write(' | '), write(R22), write(' | '), write(R23), write(' | '), nl,
    write(' | '), write(R31), write(' | '), write(R32), write(' | '), write(R33), write(' | '), nl.


% Punto 5
% Definición de estudiantes, carreras y deportes
estudiante(hugo). estudiante(paco). estudiante(luis).

carrera(sistemas). carrera(industrial). carrera(quimica).

deporte(futbol). deporte(tenis). deporte(natacion).

% Vamos a llevar la información de los 3 estudiantes en listas, una para cada estudiante de la siguiente manera
% info = [Nombre, Carrera, Deporte].

% Vamos a llevar la instancia de la solución del acertijo en una lista, donde se encontrará la información de los tres estudiantes, en el formato descrito anteriormente.

% Reglas
% Regla 1: Paco es hermano del estudiante de sistemas.
hermano_paco([]) :- false.
hermano_paco([[Estudiante, sistemas |_] | _]) :-
    estudiante(Estudiante),
    Estudiante \= paco, !.
hermano_paco([_ | Resto]) :-
    hermano_paco(Resto).


% Regla 2: Al industrial le gusta el fútbol.
gusto([]) :- false.
gusto([[_, industrial, futbol] |_]).
gusto([_ | Resto]) :-
    gusto(Resto).


% Regla 3: Paco no estudia química.
no_quimica([]) :- false.
no_quimica([[paco, Carrera | _], _]) :-
    carrera(Carrera),
    Carrera \= quimica.
no_quimica([_ | Resto]) :-
    no_quimica(Resto).


% Regla 4: Hugo le regaló un café al nadador para que termina su taller de programación orientada a objetos.
regalo([]) :- false.
regalo([[Estudiante, sistemas, natacion] | _]) :-
    estudiante(Estudiante),
    Estudiante \= hugo.
regalo([_ | Resto]) :-
    regalo(Resto).


practica(_, _, []) :- false.
practica(Estudiante, Deporte, [[Estudiante, _, Deporte] | _]).
practica(Estudiante, Deporte, [_ | Resto]) :-
    practica(Estudiante, Deporte, Resto).


% Solución acertijo: ¿Quién practica tenis?
solucion_acertijo(Lista_hugo, Lista_paco, Lista_luis) :-
    carrera(CarreraH), carrera(CarreraP), carrera(CarreraL),
    deporte(DeporteH), deporte(DeporteP), deporte(DeporteL),
    Lista_hugo = [hugo, CarreraH, DeporteH],
    Lista_paco = [paco, CarreraP, DeporteP],
    Lista_luis = [luis, CarreraL, DeporteL],
    CarreraH \= CarreraP, CarreraL \= CarreraP, CarreraH \= CarreraL,
    DeporteH \= DeporteP, DeporteL \= DeporteP, DeporteH \= DeporteL,
    Lista_general = [Lista_hugo, Lista_paco, Lista_luis],
    hermano_paco(Lista_general),
    gusto(Lista_general),
    no_quimica(Lista_general),
    regalo(Lista_general),
    practica(Tenista, tenis, Lista_general),
    write('El estudiante que practica tenis es: '), write(Tenista), !.