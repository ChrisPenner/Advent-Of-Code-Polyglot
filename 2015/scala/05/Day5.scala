package advent

import Math.abs

/**
  * Created by james on 05/12/2015.
  */
object Day5 extends App {

  val input = io.Source.fromInputStream(getClass.getClassLoader.getResourceAsStream("day5.txt")).getLines.toList

  def part1 = {
    def isVowel(c: Char) = "aeiou" contains c
    def prop1(s: String) = (s count isVowel) >= 3

    def isDouble(pair: String) = pair.head == pair.last
    def prop2(s: String) = s.sliding(2) exists isDouble

    def banned(pair: String) = Set("ab", "cd", "pq", "xy") contains pair
    def prop3(s: String) = !(s.sliding(2) exists banned)

    def isNice(s: String) = prop1(s) && prop2(s) && prop3(s)

    input count isNice
  }

  def part2 = {
    // build a map of pair -> ordered pair occurrences
    // "abcabc" => Map(ab -> List(0, 3), bc -> List(1, 4), ca -> List(2))
    def positionPairs(s: String): Map[String, List[Int]] = s.sliding(2).zipWithIndex.toList.groupBy(_._1).mapValues(_.map(_._2))
    // given a pair of occurences, determine if they are non-overlapping
    def nonAdjacentPair(pair: List[Int]) = abs(pair.head - pair.last) > 1
    // determine if there is a non-overlapping pair in the combination of all pairs of occurences
    def nonAdjacent(xs: List[Int]) = xs.combinations(2) exists nonAdjacentPair
    def prop1(s: String) = positionPairs(s).values exists nonAdjacent

    def repeatsWith1LetterBetween(triple: String) = triple.head == triple.last
    def prop2(s: String) = s.sliding(3) exists repeatsWith1LetterBetween

    def isNice(s: String) = prop1(s) && prop2(s)

    input count isNice
  }

  println(s"part1 = $part1")
  println(s"part2 = $part2")
}
