import java.io.File

fun main(args: Array<String>) {
    val input = File("input.txt").readText()

    val santa = hashSetOf(Pair(0, 0))

    var x = 0
    var y = 0

    for(c in input) {
        when(c) {
            '^' -> y++
            '>' -> x++
            '<' -> x--
            'v' -> y--
        }

        santa.add(Pair(x, y))
    }

    println(santa.size)
}