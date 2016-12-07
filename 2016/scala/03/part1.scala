object Day3 {
  def main(args: Array[String]): Unit = {
    def isValidTriangle(v: Array[Int]): Boolean =
      v(0) + v(1) > v(2) && v(0) + v(2) > v(1) && v(1) + v(2) > v(0)

    val input = scala.io.Source.fromFile("input3.txt").mkString

    // Part 1
    val validTriangles1 = input.split('\n') map { line =>
      line.trim.split("""\s+""").map(_.toInt).sorted
    } filter { sides =>
      sides(2) < sides(0) + sides(1)
    }

    println("Part 1", validTriangles1.size)

  }
}
