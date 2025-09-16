# APLICATIVO: Juego FC Mobile
# CASOS DE USO:
# 1. Carga de FC Points y/o Monedas
# 2. Redención de Sobre
# 3. Compra de Jugadores

# REQUERIMIENTOS: En la creación de nuestro juego, cada jugador inicia con 500 FC Points, 1000 Monedas y 5 Jugadores
# en su equipo, cada uno con 70 de valoración. Se lleva la valoración del equipo. La valoración del equipo es el
# promedio de la valoración de los jugadores. Puedo agregar FC Points o Monedas a mi cuenta. Por cada 100 FC Points
# que agregue, mejora el peor jugador de su plantilla en 1 punto (si hay dos o más jugadores con la misma valoración,
# mejora cualquiera de ellos. Para la mejora de jugadores se mejora tomando el piso de la cantidad de FC Points
# agregados. La valoración máxima a la que puede llegar dicha mejora es 90, el resto de mejoras disponibles por la
# recarga serán perdidas). Puedo redimir un sobre. Por cada sobre redimido, se añade un jugador aleatorio a mi
# plantilla con valoración entre 70 y 90. Cada sobre descuenta 50 FC Points o 100 Monedas. (La primera opción es
# descontar FC Points, si no se cuenta con FC Points, se descuentan Monedas). Se pueden comprar jugadores,
# por cada jugador comprado, se descuenta su valoración multiplicada por 10 Monedas. (Por ejemplo, si quiero comprar
# un jugador de 80 de valoración, se descuentan 800 Monedas). Cada jugador comprado se añade a mi plantilla y me da
# 10 FC Points.


import unittest
import random


class Jugador:
    def __init__(self, valoracion):
        self.valoracion = valoracion


class JuegoFCMobile:
    def __init__(self):
        self.fc_points = 500
        self.monedas = 1000
        self.plantilla = [Jugador(70) for _ in range(5)]

    def valoracion_promedio(self):
        total = sum(jugador.valoracion for jugador in self.plantilla)
        return total / len(self.plantilla)

    def agregar_fc_points(self, puntos):
        self.fc_points += puntos

        # Mejora el peor jugador
        peor_jugador = min(self.plantilla, key=lambda jugador: jugador.valoracion)
        peor_jugador.valoracion = min(90, peor_jugador.valoracion + puntos // 100)

    def agregar_monedas(self, monedas):
        self.monedas += monedas

    def redimir_sobre(self):
        costo_sobre_fc_points = 50
        costo_sobre_monedas = 100
        nuevo_jugador_valoracion = random.randint(70, 90)

        if self.fc_points >= costo_sobre_fc_points:
            self.fc_points -= costo_sobre_fc_points
            self.plantilla.append(Jugador(nuevo_jugador_valoracion))
        elif self.monedas >= costo_sobre_monedas:
            self.monedas -= costo_sobre_monedas
            self.plantilla.append(Jugador(nuevo_jugador_valoracion))
        else:
            print("No hay suficientes FC Points ni Monedas para redimir un sobre.")

    def comprar_jugador(self, valoracion):
        costo = valoracion * 10
        if self.monedas >= costo:
            self.monedas -= costo
            self.fc_points += 10
            self.plantilla.append(Jugador(valoracion))
        else:
            print("No hay suficientes Monedas para comprar el jugador.")


class TestJuegoFCMobile(unittest.TestCase):

    def setUp(self):
        # Inicialización del juego para cada prueba
        self.juego = JuegoFCMobile()

    def test_creacion_juego(self):
        # Entonces el juego inicia con 500 FC Points, 1000 Monedas y 5 jugadores en la plantilla
        self.assertEqual(self.juego.fc_points, 500)
        self.assertEqual(self.juego.monedas, 1000)
        self.assertEqual(len(self.juego.plantilla), 5)
        self.assertEqual(self.juego.valoracion_promedio(), 70)

    def test_valoracion_promedio(self):
        # Dado un equipo con jugadores de valoración [70, 70, 70, 80, 80, 80]
        self.juego.plantilla = [Jugador(70), Jugador(70), Jugador(70), Jugador(80), Jugador(80), Jugador(80)]
        # Cuando calculo la valoración promedio
        promedio = self.juego.valoracion_promedio()
        # Entonces el promedio debe ser 75
        self.assertEqual(promedio, 75)

    def test_carga_fc_points_mejora_jugador(self):
        # Dado un equipo con valoraciones [70, 70, 71, 72, 73] y 100 FC Points
        self.juego.plantilla = [Jugador(70), Jugador(70), Jugador(71), Jugador(72), Jugador(73)]
        self.juego.fc_points = 100
        # Cuando agrego 100 FC Points
        self.juego.agregar_fc_points(100)
        # Entonces el peor jugador (70) mejora en 1 punto
        valoraciones = [jugador.valoracion for jugador in self.juego.plantilla]
        self.assertEqual(valoraciones, [71, 70, 71, 72, 73])
        # Los FC Points resultan en 200
        self.assertEqual(self.juego.fc_points, 200)

    def test_carga_fc_points_multiples_mejoras(self):
        # Dado un equipo con valoraciones [70, 71, 72, 73, 74] y 300 FC Points
        self.juego.plantilla = [Jugador(70), Jugador(71), Jugador(72), Jugador(73), Jugador(74)]
        self.juego.fc_points = 300
        # Cuando agrego 300 FC Points (3 mejoras)
        self.juego.agregar_fc_points(300)
        # Entonces el equipo debe tener valoraciones [73, 71, 72, 73, 74]
        valoraciones = [jugador.valoracion for jugador in self.juego.plantilla]
        self.assertEqual(valoraciones, [73, 71, 72, 73, 74])
        # Los FC Points resultan en 600
        self.assertEqual(self.juego.fc_points, 600)

    def test_carga_fc_points_mejora_maxima(self):
        # Dado un equipo con un jugador ya con valoración 90 y 200 FC Points
        self.juego.plantilla = [Jugador(90), Jugador(90), Jugador(86), Jugador(88), Jugador(87)]
        self.juego.fc_points = 200
        # Cuando agrego 500 FC Points (una mejora)
        self.juego.agregar_fc_points(500)
        # Entonces el jugador con valoración 86 mejora a 90 y el resto se pierde
        valoraciones = [jugador.valoracion for jugador in self.juego.plantilla]
        self.assertEqual(valoraciones, [90, 90, 90, 88, 87])
        # Los FC Points resultan en 700
        self.assertEqual(self.juego.fc_points, 700)

    def test_carga_fc_points_sin_mejora_excedida(self):
        # Dado un equipo con todos los jugadores en valoración 90 y 200 FC Points
        self.juego.plantilla = [Jugador(90), Jugador(90), Jugador(90), Jugador(90), Jugador(90)]
        self.juego.fc_points = 200
        # Cuando agrego 200 FC Points (2 mejoras)
        self.juego.agregar_fc_points(200)
        # Entonces ningún jugador debe mejorar, ya que todos tienen 90
        valoraciones = [jugador.valoracion for jugador in self.juego.plantilla]
        self.assertEqual(valoraciones, [90, 90, 90, 90, 90])
        # Los FC Points resultan en 400
        self.assertEqual(self.juego.fc_points, 400)

    def test_agregar_monedas(self):
        # Dado que el jugador tiene 1000 Monedas
        self.juego.monedas = 1000
        # Cuando agrega 500 Monedas
        self.juego.agregar_monedas(500)
        # Entonces las Monedas resultan en 1500
        self.assertEqual(self.juego.monedas, 1500)

    def test_redimir_sobre_fc_points(self):
        # Dado que el jugador tiene 500 FC Points y 1000 Monedas
        self.juego.fc_points = 500
        self.juego.monedas = 1000
        num_jugadores_inicial = len(self.juego.plantilla)
        # Cuando redime un sobre
        self.juego.redimir_sobre()
        # Entonces se descuentan 50 FC Points
        self.assertEqual(self.juego.fc_points, 450)
        # Y se añade un nuevo jugador a la plantilla
        self.assertEqual(len(self.juego.plantilla), num_jugadores_inicial + 1)

    def test_redimir_sobre_con_monedas(self):
        # Dado que el jugador tiene 40 FC Points y 1000 Monedas
        self.juego.fc_points = 40
        self.juego.monedas = 1000
        num_jugadores_inicial = len(self.juego.plantilla)
        # Cuando redime un sobre
        self.juego.redimir_sobre()
        # Entonces se descuentan 100 Monedas (FC Points insuficientes)
        self.assertEqual(self.juego.monedas, 900)
        # Y se añade un nuevo jugador a la plantilla
        self.assertEqual(len(self.juego.plantilla), num_jugadores_inicial + 1)

    def test_redimir_sobre_sin_recursos(self):
        # Dado que el jugador tiene 40 FC Points y 50 Monedas
        self.juego.fc_points = 40
        self.juego.monedas = 50
        num_jugadores_inicial = len(self.juego.plantilla)
        # Cuando intenta redimir un sobre
        self.juego.redimir_sobre()
        # Entonces no se realiza la redención
        self.assertEqual(self.juego.fc_points, 40)
        self.assertEqual(self.juego.monedas, 50)
        # Y no se añade un nuevo jugador a la plantilla
        self.assertEqual(len(self.juego.plantilla), num_jugadores_inicial)

    def test_comprar_jugador(self):
        # Dado que el jugador tiene 1000 Monedas y 500 FC Points
        self.juego.monedas = 1000
        self.juego.fc_points = 500
        num_jugadores_inicial = len(self.juego.plantilla)
        # Cuando compra un jugador con valoración 80
        self.juego.comprar_jugador(80)
        # Entonces se descuentan 800 Monedas
        self.assertEqual(self.juego.monedas, 200)
        # Y se añaden 10 FC Points
        self.assertEqual(self.juego.fc_points, 510)
        # Además, la plantilla debe tener un jugador adicional
        self.assertEqual(len(self.juego.plantilla), num_jugadores_inicial + 1)

    def test_comprar_jugador_sin_monedas(self):
        # Dado que el jugador tiene 500 Monedas y 500 FC Points y 5 jugadores
        self.juego.monedas = 500
        self.juego.fc_points = 500
        # Cuando intenta comprar un jugador con valoración 80
        self.juego.comprar_jugador(80)
        # Entonces no se realiza la compra
        self.assertEqual(self.juego.monedas, 500)
        # Y no se añaden FC Points
        self.assertEqual(self.juego.fc_points, 500)
        # Además, la plantilla no debe tener un jugador adicional
        self.assertEqual(len(self.juego.plantilla), 5)

if __name__ == '__main__':
    unittest.main()