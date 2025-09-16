object DistanciaPuntos {

  // Función de orden superior maxDistancia
  def maxDistancia(puntos: List[(Double, Double)], distancia: ((Double, Double), (Double, Double)) => Double): Double = {
    // Inicializa la distancia máxima con un valor bajo
    var distanciaMaxima = Double.MinValue

    // Calcula la distancia máxima entre todos los pares de puntos
    for {
      punto1 <- puntos
      punto2 <- puntos if punto1 != punto2
    } {
      // Calcula la distancia entre punto1 y punto2
      val dist = distancia(punto1, punto2)
      if (dist > distanciaMaxima) {
        distanciaMaxima = dist
      }
    }

    distanciaMaxima
  }

  def main(args: Array[String]): Unit = {
    // Ejemplo de uso de maxDistancia
    val puntos = List((1.0, 2.0), (4.0, 3.0), (13.0, 6.0), (8.0, 10.0))

    // Ejemplo de una función para calcular la distancia entre dos puntos (euclidiana)
    def distanciaEuclidiana(punto1: (Double, Double), punto2: (Double, Double)): Double = {
      val dx = punto1._1 - punto2._1
      val dy = punto1._2 - punto2._2
      Math.sqrt(dx * dx + dy * dy)
    }

    // Calcula y muestra la distancia máxima utilizando la distancia euclidiana
    val distanciaMax = maxDistancia(puntos, distanciaEuclidiana)
    println(s"La distancia euclidiana máxima entre los puntos es: $distanciaMax")

    // Ejemplo de una función para calcular la distancia de Manhattan entre dos puntos
    def distanciaManhattan(punto1: (Double, Double), punto2: (Double, Double)): Double = {
      val dx = Math.abs(punto1._1 - punto2._1)
      val dy = Math.abs(punto1._2 - punto2._2)
      dx + dy
    }

    // Calcula y muestra la distancia máxima utilizando la distancia de Manhattan
    val distanciaMax2 = maxDistancia(puntos, distanciaManhattan)
    println(s"La distancia de Manhattan máxima entre los puntos es: $distanciaMax2")
  }
}