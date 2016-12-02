package advent

import scala.language.postfixOps

import scala.util.parsing.combinator.JavaTokenParsers

import scala.reflect.runtime._
import scala.tools.reflect.ToolBox

/**
  * Created by james on 07/12/2015.
  */
object Day7 extends App with JavaTokenParsers {

  // Since wires are isomorphic to variables, translate the input into Scala source code and
  // compile that. Use lazy vals in the compiled-to source as memoization.

  val input = io.Source.fromInputStream(getClass.getClassLoader.getResourceAsStream("day7.txt")).getLines.mkString("\n")

  // Handle variables called reserved words like `do` or `if`
  def quotedIdent = ident ^^ { case i => s"`$i`" }

  // Parse the expressions giving us the wire input.
  def source = {
    def expr = quotedIdent | wholeNumber
    def and = (expr <~ "AND") ~ expr ^^ { case l~r => s"$l & $r" }
    def or = (expr <~ "OR") ~ expr ^^ { case l~r => s"$l | $r" }
    def lshift = (expr <~ "LSHIFT") ~ expr ^^ { case l~r => s"$l << $r" }
    def rshift = (expr <~ "RSHIFT") ~ expr ^^ { case l~r => s"$l >> $r" }
    def not = "NOT" ~> expr ^^ { case i => s"~$i" }
    and | or | lshift | rshift | not | expr
  }

  // Parse a line
  def line = (source <~ "->") ~ quotedIdent ^^ { case o~i => s"lazy val $i = $o" }

  // This is the Scala source we've translated to.
  val wires = parse(line +, input).get.mkString("; ")

  // This is our compiler
  val tb = universe.runtimeMirror(getClass.getClassLoader).mkToolBox()

  // Wrap up the wires in a class and then get the value of the `a` wire.
  def part1 = tb.eval(tb.parse(s"class C { $wires }; (new C).a"))
  // Wrap up the wires in a class, set `b` to be the output of a calculated `a`, and then get
  // the value of the `a` wire
  def part2 = tb.eval(tb.parse(s"class C { $wires }; class D extends C { override lazy val b = (new C).a }; (new D).a"))

  println(s"part1 = $part1")
  println(s"part2 = $part2")
}

