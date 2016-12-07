
object Day2 {

  def findKeyCode(startX: Int, startY: Int, keypad: Array[Array[String]], input: String): Seq[String] = {
    def checkPoint(x: Int, y: Int): Boolean = {
      x >= 0 && y >= 0 && x < keypad.length && y < keypad.length && keypad(x)(y) != null
    }

    def foldInput(x: Int, y: Int, input: String): Seq[String] = {
      if (input.isEmpty) {
        Seq.empty[String]
      } else if (input.head == '\n') {
        Seq[String]{keypad(y)(x)} ++ foldInput(x, y, input.tail)
      } else {
        val newPoint = input.head match {
          case 'U' => (x, y - 1)
          case 'L' => (x - 1, y)
          case 'D' => (x, y + 1)
          case 'R' => (x + 1, y)
        }
        if (checkPoint(newPoint._1, newPoint._2)) {
          foldInput(newPoint._1, newPoint._2, input.tail)
        } else {
          foldInput(x, y, input.tail)
        }
      }
    }

    foldInput(startX, startY, input)
  }

  def main(args: Array[String]): Unit = {

    val input = scala.io.Source.fromFile("input.txt").mkString

    val part2 = Array[Array[String]](
      Array[String](null, null, "1", null, null),
      Array[String](null, "2", "3", "4", null),
      Array[String]("5", "6", "7", "8", "9"),
      Array[String](null, "A", "B", "C", null),
      Array[String](null, null, "D", null, null))

    println(findKeyCode(0, 2, part2, input))
  }
}
