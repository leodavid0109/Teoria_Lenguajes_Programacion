object MaximoComunDivisor {
  def algoritmoEuclides(a: Int, b: Int): Int = {
    if (b == 0) a
    else algoritmoEuclides(b, a % b)
  }

  def main(args: Array[String]): Unit = {

    val algoritmoEuclides1 = algoritmoEuclides(252: Int, 105: Int)
    println(s"El máximo común divisor de 252 y 105 es: $algoritmoEuclides1")

    val algoritmoEuclides2 = algoritmoEuclides(1989: Int, 867: Int)
    println(s"El máximo común divisor de 1989 y 867 es: $algoritmoEuclides2")

    val algoritmoEuclides3 = algoritmoEuclides(120: Int, 36: Int)
    println(s"El máximo común divisor de 120 y 36 es: $algoritmoEuclides3")
  }
}
