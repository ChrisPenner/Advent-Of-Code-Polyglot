package advent

import scala.annotation.tailrec

import java.security.MessageDigest

/**
  * Created by james on 04/12/2015.
  */
object Day4 extends App {

  def md5(s: String) = MessageDigest.getInstance("MD5").digest(s.getBytes).map("%02X".format(_)).mkString

  val secret = "bgvyzdsv"

  @tailrec
  def solve(prefix: String, sec: String, i: Long = 0L): Long = if (md5(s"$sec$i").startsWith(prefix)) i else solve(prefix, sec, i + 1L)

  def part1 = solve("00000", secret)

  def part2 = solve("000000", secret)

  println(s"part1 = $part1")
  println(s"part2 = $part2")
}
