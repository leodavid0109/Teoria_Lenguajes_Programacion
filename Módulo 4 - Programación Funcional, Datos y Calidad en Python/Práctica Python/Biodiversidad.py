from functools import reduce
from array import array


# Diccionario con especies en el parque nacional donde la clave es el nombre de la especie y el valor una tupla con el
# tipo de especie, la cantidad observada y el hábitat principal.
biodiversidad = {
    "Águila": ("animal", 2, "montaña"),
    "León": ("animal", 4, "sabana"),
    "Caballo": ("animal", 10, "pradera"),
    "Tigre": ("animal", 1, "selva"),
    "Pino": ("planta", 10, "bosque"),
    "Roble": ("planta", 20, "bosque"),
    "Cedro": ("planta", 5, "bosque"),
    "Palma": ("planta", 15, "playa")
}

# Imprimir el diccionario
print("Biodiversidad en el parque nacional:")
print(biodiversidad)
print()


# Función para actualizar la cantidad de una especie en el inventario
def actualizar_cantidad(especie, cantidad):
    if especie in biodiversidad:
        biodiversidad[especie] = (biodiversidad[especie][0], cantidad, biodiversidad[especie][2])
    else:
        print(f"La especie {especie} no se encuentra en el inventario")


# Prueba de la función
print("Actualización de cantidad de especies:")
actualizar_cantidad("León", 6)
actualizar_cantidad("Jirafa", 3)
actualizar_cantidad("Cedro", 8)
print(biodiversidad)
print()


# Función para cambiar el hábitat de una especie
def cambiar_habitat(especie, habitat):
    if especie in biodiversidad:
        biodiversidad[especie] = (biodiversidad[especie][0], biodiversidad[especie][1], habitat)
    else:
        print(f"La especie {especie} no se encuentra en el inventario")


# Prueba de la función
print("Cambio de hábitat de especies:")
cambiar_habitat("Pino", "montaña")
cambiar_habitat("Roble", "montaña")
cambiar_habitat("Pino", "playa")
cambiar_habitat("Jirafa", "pradera")
cambiar_habitat("Tigre", "sabana")
print(biodiversidad)
print()


# Función para listar especies por tipo
def listar_especies(tipo):
    print([especie for especie, datos in biodiversidad.items() if datos[0] == tipo])


# Prueba de la función
print("Listado de especies por tipo:")
print("Animales:", end=" ")
listar_especies("animal")
print("Plantas:", end=" ")
listar_especies("planta")
print()


# Función para calcular el total de individuos observados
def total_individuos():
    return reduce(lambda x, y: x + y, [datos[1] for datos in biodiversidad.values()])


# Prueba de la función
print("Total de individuos observados:", total_individuos())
print()


# Crear un arreglo con las cantidades observadas de todas las especies
cantidades_observadas = array('i', [datos[1] for datos in biodiversidad.values()])
print("Arreglo de cantidades observadas:", cantidades_observadas)
print("Cantidad promedio de individuos observados:", sum(cantidades_observadas) / len(cantidades_observadas))