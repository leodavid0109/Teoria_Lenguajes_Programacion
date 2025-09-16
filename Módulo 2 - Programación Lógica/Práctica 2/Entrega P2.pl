% Un estudiante estará identificado por su nombre, su edad y su identificación
estudiante(david, 18, 1234).
estudiante(pablo, 21, 5678).
estudiante(david, 23, 9876).
estudiante(tomás, 16, 5432).

% Cada curso estará relacionado, a un estudiante, al nombre del curso y a una nota.
curso(david, cálculo, 5.0).
curso(david, ética, 4.9).
curso(david, sociales, 4.8).

curso(pablo, cálculo, 3.8).
curso(pablo, ética, 1.2).
curso(pablo, inglés, 2.8).

curso(david, cálculo, 3.8).
curso(david, ética, 2.4).
curso(david, inglés, 1.8).

curso(tomás, ética, 4.6).
curso(tomás, sociales, 3.6).
curso(tomás, inglés, 5.0).

% Para acceder a los nombres de todos los estudiantes, usamos la consulta:
% estudiante(Nombre, _, _)

% Para ver cuales son los cursos que está cursando un estudiante, usamos la consulta:
% (Reemplazar las palabras en comillas por el nombre de un estudiante, o en su defecto una variable Estudiante.
% curso("nombre del estudiante", Materia, _)


ganando(Estudiante, Materia) :- 
    curso(Estudiante, Materia, Nota),
    Nota >= 3.0.

% Para ver quiénes van ganando una materia hacemos uso de la regla "ganando", para todos los casos ganando(Estudiante, Materia), ahora, para los solicitados...
% Ver quiénes van ganando cálculo:
% ganando(Estudiante, cálculo)

% Ver quiénes van ganando ética:
% ganando(Estudiante, ética)


mayoria(Estudiante) :-
    estudiante(Estudiante, Edad, _),
    Edad >= 18.

% Para ver cuáles estudiantes son mayores de edad, hacemos uso de la regla "mayoria" así: mayoria(Estudiante)


notas(Estudiante, Referencia) :-
    curso(Estudiante, _, Nota),
    Nota >= Referencia.

% Para ver cuáles estudiantes tienes notas mayores que 4.0 hacemos uso de la regla "notas" de la siguiente manera: notas(Estudiante, 4.0)


mismo_nombre(Nombre1) :-
    estudiante(Nombre1, _, Id1),
    estudiante(Nombre2, _, Id2),
    Nombre1 == Nombre2,
    Id1 \= Id2.

% Para ver cuáles estudiantes tienes el mismo nombre (es decir, para ver si hay dos estudiantes con mismo nombre y ver cual es dicho nombre), aprovecharemos el uso de su Id (que debe ser distinta para cada persona), haciendo uso de la regla "mismo_nombre" de la siguiente manera: mismo_nombre(Nombre)