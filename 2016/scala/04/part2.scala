import scala.collection.mutable

object Day4 {

  val alphabet = "abcdefghijklmnopqrstuvwxyz"

  def main(args: Array[String]): Unit = {
    val input = scala.io.Source.fromFile("input4.txt").mkString

    val npStorageLine = input.split('\n')
        .map((line) => {
          val sectorID =  parseSectorID(line)
          decodeNames(line.split('-').dropRight(1), sectorID).mkString(" ") + " " + sectorID
        })
        .filter(_.contains("north"))
        .head

    // Part 2
    println(npStorageLine)

  }

  def parseSectorID(line: String): Int = {
    val parts = line.split('-')
    parts.last.substring(0, parts.last.indexOf("[")).toInt
  }

  def decodeNames(names: Array[String], sectorID: Int): Array[String] = {
    names.map((s) => {
      s.map((c) => {
        alphabet.charAt((alphabet.indexOf(c) + sectorID) % alphabet.size)
      })
    })
  }

}
