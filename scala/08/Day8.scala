package advent

import scala.util.parsing.combinator.JavaTokenParsers

/**
  * Created by james on 07/12/2015.
  */
object Day8 extends App with JavaTokenParsers {

  val input = io.Source.fromInputStream(getClass.getClassLoader.getResourceAsStream("day8.txt")).getLines.toList

  // Parse each element of an input string
  def bs = "\\"
  def quot = "\""
  def escBs = bs ~ bs
  def escQuot = bs ~ quot
  def escChr = bs ~ "x[0-9a-f][0-9a-f]".r
  def oneChr = "[a-z]".r
  def char = escBs | escQuot | escChr | oneChr
  def escapedLine = {
    quot ~> (char +) <~ quot
  }

  def part1 = input.map(_.length).sum - input.map(parse(escapedLine, _).get.size).sum

  // Parse each element of an input string and just output the size (doesn't depend on the input)
  def quotLen = quot ^^^ { 2 }
  def bsLen = bs ^^^ { 2 }
  def escQuotLen = escQuot ^^^ { 4 }
  def escChrLen = escChr ^^^ { 5 }
  def charLen = oneChr ^^^ { 1 }
  def lineLen = quotLen | escChrLen | charLen | bsLen | escQuotLen
  def escape(line: String) = {
    parse(lineLen +, line).get.sum + 2
  }

  def part2 = input.map(escape).sum - input.map(_.length).sum

  println(s"part1 = $part1")
  println(s"part1 = $part2")
}



