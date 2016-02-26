import java.io.File

fun main(args: Array<String>) {
    val input = File("input.txt").readLines()

    val res = input.sumBy { str ->
        val (l, w, h) = str.split('x').map {it.toInt()}

        val a = l + w
        val b = l + h
        val c = w + h

        val min = listOf(a, b, c).min()!!

        2 * min + l * w * h
    }

    println(res)
}