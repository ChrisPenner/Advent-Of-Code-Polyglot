import scala.collection.mutable.ListBuffer

object Day6 {
  def main(args: Array[String]): Unit = {
    val input = scala.io.Source.fromFile("input6.txt").mkString

    var mostCommon = new ListBuffer[Char]()

    input.split('\n').map(_.toCharArray).transpose.map((column) => {
      column.groupBy(identity).mapValues(_.size)
    }).map((c) => {
      mostCommon += c.maxBy(_._2)._1
    })

    println(mostCommon.mkString(""))
  }
}
