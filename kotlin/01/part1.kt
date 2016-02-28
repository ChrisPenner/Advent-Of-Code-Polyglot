import java.io.File

fun main(args: Array<String>) {
    val input = File("input.txt").readText()

    println(2 * input.count { it == '(' } - input.length)
}