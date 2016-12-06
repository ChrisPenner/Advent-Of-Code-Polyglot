import scala.collection.mutable

object Day4 {

  val alphabet = "abcdefghijklmnopqrstuvwxyz"

  def main(args: Array[String]): Unit = {
    val input = scala.io.Source.fromFile("input4.txt").mkString

    val sum = input.split('\n')
      .filter(isValidChecksum)
      .map(parseSectorID)
      .reduce(_ + _)

    // Part 1
    println(sum)

  }

  def parseSectorID(line: String): Int = {
    val parts = line.split('-')
    parts.last.substring(0, parts.last.indexOf("[")).toInt
  }

  def isValidChecksum(line: String): Boolean = {
    val parts = line.split('-')
    val names = parts.dropRight(1)
    val checksum = parts.last.substring(parts.last.indexOf("[") + 1, parts.last.lastIndexOf("]"))

    val counts = new mutable.HashMap[Char, Int]
    names.mkString("").map(c => {
      if (!counts.contains(c)) {
        counts(c) = 0
      }
      counts(c) = counts(c) + 1
    })

    val calculatedChecksum = counts.toSeq.sortWith((a, b) => {
      if (a._2 == b._2) {
        a._1 < b._1
      } else {
        a._2 > b._2
      }
    }).take(5).map((pair) => {
      pair._1
    }).mkString("")

    calculatedChecksum == checksum
  }

}
