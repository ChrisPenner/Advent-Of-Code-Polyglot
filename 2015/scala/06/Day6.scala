package advent

import scala.annotation.tailrec
import scala.util.parsing.combinator._
import Math.max

/**
  * Created by james on 06/12/2015.
  */
object Day6 extends App with JavaTokenParsers {

  val input = io.Source.fromInputStream(getClass.getClassLoader.getResourceAsStream("day6.txt")).getLines.toList

  case class Coord(x: Int, y: Int)
  case class Rect(topLeft: Coord, bottomRight: Coord) {
    // Determine if a co-ordinate is within the bounding rectangle
    def contains(c: Coord) = c match {
      case Coord(x, _) if x < topLeft.x || x > bottomRight.x => false
      case Coord(_, y) if y < topLeft.y || y > bottomRight.y => false
      case _ => true
    }
  }
  // Represents a single line of the input
  case class Mutate(op: String, rect: Rect)

  // Parse an operation
  def op = "toggle" | "turn on" | "turn off"

  // Parse a co-ordinate from a pair of whole numbers separated by a comma
  def coord = (wholeNumber <~ ",") ~ wholeNumber ^^ { case x~y => Coord(x.toInt, y.toInt) }

  // Parse a bounding rectangle from a pair of coordinates separated by "through"
  def rect = (coord <~ "through") ~ coord ^^ { case tl~br => Rect(tl, br) }

  // Parse a line from an op, a coordinate, a separating word and another coordinate
  def line = op ~ rect ^^ { case op~rect => Mutate(op, rect) }

  // Represents the display of lights given a series of inputs
  case class Display(history: List[Mutate]) {
    // Since in part1 we never care about what happens to a light before it gets its final
    // "turn on" or "turn off" signal, go back in time from the last input
    private val r = history.reverse
    def lightOnAt(c: Coord) = {
      def intersect(h: List[Mutate]): Boolean = h match {
        case Nil => false
        case Mutate("turn on", r) :: tail if r.contains(c) => true
        case Mutate("turn off", r) ::tail if r.contains(c) => false
        case Mutate("toggle", r) :: tail if r.contains(c) => !intersect(tail)
        case nop :: tail => intersect(tail)
      }
      intersect(r)
    }

    // Since all history is relevant to the eventual brightness, just accumulate the whole
    // operation
    def lightBrightnessAt(c: Coord) = history.foldLeft(0) { (brightness, mut) => mut.op match {
      case "turn on" if mut.rect.contains(c) => brightness + 1
      case "turn off" if mut.rect.contains(c) => max(0, brightness - 1)
      case "toggle" if mut.rect.contains(c) => brightness + 2
      case _ => brightness
    }}
  }

  // Parse the input and create a display from it
  val d = Display(input.map(parse(line, _).get))

  // Work out the value of each light in turn and count the lit ones
  def part1 = {
    for {
      x <- 0 to 999
      y <- 0 to 999
      if d.lightOnAt(Coord(x, y))
    } yield true
  }.size

  def part2 = {
    for {
      x <- 0 to 999
      y <- 0 to 999
    } yield d.lightBrightnessAt(Coord(x, y))
  }.sum
}
