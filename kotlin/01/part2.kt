import java.io.File

fun main(args: Array<String>) {
    val input = File("input.txt").readText()

    var floor = 0
    for ((i, ch) in input.withIndex()) {
        floor += if (ch == '(') 1 else -1

        if (floor == -1) {
            println(i + 1)
            break
        }
    }
}