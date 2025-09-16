object Segmentacion {
  def expresionCorreo(correo: String): List[String] = {
    // usuario + @ + dominio (gmail.com, unal.edu.co y med.gov.co)
    val cregex = """([\w.]+)@(gmail\.com|unal\.edu\.co|med\.gov\.co)""".r
    cregex.findAllIn(correo).toList
  }

  def expresionCelular(celular: String): List[String] = {
    // 3 números (0-7) + - + 3 números (0-7) + - + 2 números (3-5) + - + 2 números (3-5)
    val ceregex = """([0-7]{3}-[0-7]{3}-[3-5]{2}-[3-5]{2})""".r
    ceregex.findAllIn(celular).toList
  }

  def expresionDirecciones(direccion: String): List[String] = {
    // Cra o Cll + 2 números + # + 2 números + - + 1 número
    val dregex = """(Cra|Cll) \d{2} # \d{2}-\d""".r
    dregex.findAllIn(direccion).toList
  }

  def main(args: Array[String]): Unit = {
    val listaDeCadenas = List(
      "Correo principal: contacto@med.gov.co",
      "Número de teléfono: 320-657-45-43",
      "Mi dirección es: Cra 70 # 45-7",
      "Correo de emergencia: emergencia@gmail.com",
      "Mi otro número es 315-654-32-10",
      "Dirección incorrecta: Calle 50 # 101-XY",
      "Correo alternativo: info@company.org",
      "Teléfono de la oficina: 876-543-21-09",
      "Otra dirección: Cra 22 # 44-5",
      "Segundo correo: second@example.org",
      "Teléfono secundario: 666-777-88-99",
      "Dirección errónea: Cll 60 # 80-8",
      "Correo de ayuda: help@unal.edu.co",
      "Nueva dirección: Cra 3 # 44-5",
      "Teléfono de contacto: 320-654-34-55"
    )


    // Test correos
    println("Correos:")
    val correos = listaDeCadenas.flatMap(cadena => expresionCorreo(cadena))
    correos.foreach(correo => println("- " + correo))

    // Test números de celular
    println("\nNúmeros de celular:")
    val numerosCelular = listaDeCadenas.flatMap(cadena => expresionCelular(cadena))
    numerosCelular.foreach(numero => println("- " + numero))

    // Test direcciones
    println("\nDirecciones:")
    val direcciones = listaDeCadenas.flatMap(cadena => expresionDirecciones(cadena))
    direcciones.foreach(direccion => println("- " + direccion))

  }
}
