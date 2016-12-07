
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

    val part1 = Array.tabulate(3,3){(x,y) => (y + (3*x) + 1).toString}

    println(findKeyCode(0, 2, part1, input))
  }
}
