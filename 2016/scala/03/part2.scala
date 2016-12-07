object Day3 {
  def main(args: Array[String]): Unit = {
    def isValidTriangle(v: Array[Int]): Boolean =
      v(0) + v(1) > v(2) && v(0) + v(2) > v(1) && v(1) + v(2) > v(0)

    val input = scala.io.Source.fromFile("input3.txt").mkString

    // Part 2
    val validTriangles2 = input
      .split('\n')
      .map(_.trim.split("""\s+""")
      .map(_.toInt)).grouped(3).toList
      .map(_.transpose)
      .flatten
      .filter(v => isValidTriangle(v.toArray)).length

    println("Part 2", validTriangles2)

  }
}
