import java.io.File
import java.util.*

fun main(args: Array<String>) {
    val input = File("input.txt").readText()

    val santa = visitedHouses(input.filterIndexed { i, c -> i % 2 == 0 })
    val robot = visitedHouses(input.filterIndexed { i, c -> i % 2 == 1 })

    println((santa union robot).size)
}

fun visitedHouses(script: String): HashSet<Pair<Int, Int>> {
    val set = hashSetOf(Pair(0, 0))

    var x = 0
    var y = 0

    for (c in script) {
        when (c) {
            '^' -> y++
            'v' -> y--
            '>' -> x++
            '<' -> x--
        }

        set.add(Pair(x, y))
    }

    return set
}