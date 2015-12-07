package advent

import Math._

/**
  * Created by james on 03/12/2015.
  */
object Day2 extends App {

  val input = io.Source.fromInputStream(getClass.getClassLoader.getResourceAsStream("day2.txt")).getLines.toList
  val boxes = input.map(Box.apply)

  case class Box(w: Int, h: Int, l: Int) {
    def dims = List(w, h, l)
    def sides = List(l*w, w*h, h*l)
    def paper: Int = sides.map(_*2).sum + sides.min
    def shortest = dims.sorted.take(2).map(_*2).sum
    def bow = w*h*l
    def ribbon = shortest + bow
  }
  object Box {
    def apply(s: String): Box = {
      val Array(w, h, l) = s.split('x')
      Box(w.toInt, h.toInt, l.toInt)
    }
  }

  def part1 = {
    boxes.map(_.paper).sum
  }

  def part2 = {
    boxes.map(_.ribbon).sum
  }

  println(s"part1 = $part1")
  println(s"part2 = $part2")
}
