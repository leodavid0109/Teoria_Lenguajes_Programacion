object Museo {

  // Clase para representar una obra
  class Obra(val autor: String, val ano: Int, val descripcion: String, val tipologia: String, val precio: Double)

  // Clase para representar una colección de obras
  class Coleccion(var obrasColeccion: List[Obra]) {
    // Método para agregar una obra a la colección
    def agregarObra(obra: Obra): Unit = obrasColeccion = obra :: obrasColeccion

    // Método para la segmentación de las obras por tipología y su impresión detallada
    def segmentarObrasPorTipologia(tipologia: String): Unit = {
      val obrasTipologia = obrasColeccion.filter(_.tipologia == tipologia)
      println(s"Obras de tipología $tipologia: ")
      obrasTipologia.foreach(obra => println(s"- Autor: ${obra.autor}, Año: ${obra.ano}, Descripción: ${obra.descripcion}, Tipología: ${obra.tipologia}, Precio: ${obra.precio}"))
    }

    // Método para encontrar la obra más costosa con más de 20 años de antigüedad
    def obraMasCostosaAntigua: Obra = {
      val obrasAntiguas = obrasColeccion.filter(_.ano < 2004)
      obrasAntiguas.maxBy(_.precio)
    }

    // Método para encontrar el patrimonio actual del museo
    def patrimonioActual: Double = obrasColeccion.map(_.precio).sum

    // Método para organizar la lista por año de manera recursiva de mayor a menor, es decir, de la más reciente a la más antigua
    def organizarPorAno(obras: List[Obra]): List[Obra] = {
      if (obras.isEmpty) Nil // Lista está vacía "Caso base"
      else {
        val max = obras.maxBy(_.ano)
        max :: organizarPorAno(obras.filter(_ != max))
      }
    }

    // Método para organizar la lista por precio utilizando métodos funcionales de menor a mayor
    def organizarPorPrecio: List[Obra] = obrasColeccion.sortBy(_.precio)

    // Método para calcular el descuento de las obras de una categoría definida por el usuario
    def calcularDescuento(dia: String, categoria: String): List[Obra] = {
      if (dia.toLowerCase() == "viernes") {
        obrasColeccion.filter(_.tipologia == categoria).map {
          obra => new Obra(obra.autor, obra.ano, obra.descripcion, obra.tipologia, obra.precio * 0.5)}
      } else {
        List.empty[Obra]
      }
    }
  }

  def main(args: Array[String]): Unit = {
    // Creación de las obras

    // Obras de tipología pintura
    val pintura1 = new Obra("Leonardo Da Vinci", 1503, "La Gioconda", "Pintura", 1000000)
    val pintura2 = new Obra("Vincent Van Gogh", 1889, "La noche estrellada", "Pintura", 2000000)
    val pintura3 = new Obra("Pablo Picasso", 1937, "Guernica", "Pintura", 3000000)
    val pintura4 = new Obra("Frida Kahlo", 1940, "Las dos Fridas", "Pintura", 4000000)

    // Obras de tipología escultura
    val escultura1 = new Obra("Miguel Ángel", 1504, "David", "Escultura", 5000000)
    val escultura2 = new Obra("Auguste Rodin", 1889, "El pensador", "Escultura", 6000000)
    val escultura3 = new Obra("Constantin Brancusi", 1910, "El beso", "Escultura", 7000000)
    val escultura4 = new Obra("Henry Moore", 1943, "Madre e hijo", "Escultura", 8000000)

    // Obras de tipología escritura
    val escritura1 = new Obra("William Shakespeare", 1603, "Hamlet", "Escritura", 9000000)
    val escritura2 = new Obra("Miguel de Cervantes", 1605, "Don Quijote de la Mancha", "Escritura", 9900000)
    val escritura3 = new Obra("Gabriel García Márquez", 1967, "Cien años de soledad", "Escritura", 9500000)
    val escritura4 = new Obra("Mario Vargas Llosa", 2011, "La guerra del fin del mundo", "Escritura", 9999000)

    // Obras de tipología audio
    val audio1 = new Obra("The Beatles", 1967, "Sgt. Pepper's Lonely Hearts Club Band", "Audio", 8000000)
    val audio2 = new Obra("Pink Floyd", 1973, "The Dark Side of the Moon", "Audio", 7000000)
    val audio3 = new Obra("Michael Jackson", 1982, "Thriller", "Audio", 5500000)
    val audio4 = new Obra("Nirvana", 1991, "Nevermind", "Audio", 300000)

    // Creación de la colección de obras
    val coleccion = new Coleccion(List(pintura1, pintura2, pintura3, pintura4, escultura1, escultura2, escultura3, escultura4, escritura1, escritura2, escritura3, escritura4))
    // Impresión de la colección de obras
    println("Colección de obras: ")
    coleccion.obrasColeccion.foreach(obra => println(s"- Autor: ${obra.autor}, Año: ${obra.ano}, Descripción: ${obra.descripcion}, Tipología: ${obra.tipologia}, Precio: ${obra.precio}"))
    println()

    // Agregar las obras de tipología audio
    coleccion.agregarObra(audio1)
    coleccion.agregarObra(audio2)
    coleccion.agregarObra(audio3)
    coleccion.agregarObra(audio4)
    // Impresión de la colección de obras
    println("Colección de obras actualizada: ")
    coleccion.obrasColeccion.foreach(obra => println(s"- Autor: ${obra.autor}, Año: ${obra.ano}, Descripción: ${obra.descripcion}, Tipología: ${obra.tipologia}, Precio: ${obra.precio}"))
    println()

    // Segmentación de las obras por tipología
    coleccion.segmentarObrasPorTipologia("Pintura")
    println()
    coleccion.segmentarObrasPorTipologia("Escultura")
    println()
    coleccion.segmentarObrasPorTipologia("Escritura")
    println()
    coleccion.segmentarObrasPorTipologia("Audio")
    println()

    // Obra más costosa con más de 20 años de antigüedad
    val obraMasCostosaAntigua = coleccion.obraMasCostosaAntigua
    println(s"Obra más costosa con más de 20 años de antigüedad: Autor: ${obraMasCostosaAntigua.autor}, Año: ${obraMasCostosaAntigua.ano}, Descripción: ${obraMasCostosaAntigua.descripcion}, Tipología: ${obraMasCostosaAntigua.tipologia}, Precio: ${obraMasCostosaAntigua.precio}")
    println()

    // Patrimonio actual del museo
    val patrimonioActual = coleccion.patrimonioActual
    println(s"Patrimonio actual del museo: $patrimonioActual")
    println()

    // Organización de la lista por año de manera recursiva
    val obrasPorAno = coleccion.organizarPorAno(coleccion.obrasColeccion)
    println("Obras organizadas por año de manera recursiva: ")
    obrasPorAno.foreach(obra => println(s"- Autor: ${obra.autor}, Año: ${obra.ano}, Descripción: ${obra.descripcion}, Tipología: ${obra.tipologia}, Precio: ${obra.precio}"))
    println()

    // Organización de la lista por precio de menor a mayor
    val obrasPorPrecio = coleccion.organizarPorPrecio
    println("Obras organizadas por precio de menor a mayor: ")
    obrasPorPrecio.foreach(obra => println(s"- Autor: ${obra.autor}, Año: ${obra.ano}, Descripción: ${obra.descripcion}, Tipología: ${obra.tipologia}, Precio: ${obra.precio}"))
    println()

    // Cálculo del descuento de las obras de una categoría definida por el usuario
    val descuento = coleccion.calcularDescuento("viernes", "Pintura")
    println("Descuento de las obras de la categoría Pintura: ")
    descuento.foreach(obra => println(s"- Autor: ${obra.autor}, Año: ${obra.ano}, Descripción: ${obra.descripcion}, Tipología: ${obra.tipologia}, Precio: ${obra.precio}"))
    println()

    // Caso en el que no es viernes
    val descuentoNoViernes = coleccion.calcularDescuento("lunes", "Escultura")
    println("Descuento de las obras de la categoría Escultura: ")
    descuentoNoViernes.foreach(obra => println(s"- Autor: ${obra.autor}, Año: ${obra.ano}, Descripción: ${obra.descripcion}, Tipología: ${obra.tipologia}, Precio: ${obra.precio}"))
    println()
  }
}
