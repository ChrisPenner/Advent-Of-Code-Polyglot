package advent


/**
  * Created by james on 03/12/2015.
  */
object Day1 extends App {

  val input = io.Source.fromInputStream(getClass.getClassLoader.getResourceAsStream("day1.txt")).getLines.mkString

  def isUp(c: Char) = c == '('

  def part1: Int = {
    val (up, down) = input.partition(isUp)
    up.length - down.length
  }

  def part2: Int = {
    val runningFloor = input.scanLeft(0){ case (floor, op) =>
      if (isUp(op)) floor + 1
      else floor - 1
    }
    runningFloor.takeWhile(_ != -1).size
  }

  println(s"part 1 = $part1")
  println(s"part 2 = $part2")

}
