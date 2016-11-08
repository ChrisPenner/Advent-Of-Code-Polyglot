import java.io.File
import java.security.MessageDigest

fun main(args: Array<String>) {
    val input = File("input.txt").readText()

    // a loop is not that much faster than `(0L..Long.MAX_VALUE).first {...}`: 3317ms vs 3970ms
    for (i in 0L..Long.MAX_VALUE) {
        if (md5("$input$i").isFirstSixZero()) {
            println(i)
            break
        }
    }
}


fun md5(str: String): ByteArray = md.apply { update(str.toByteArray()) }.digest()

fun ByteArray.isFirstSixZero() = (this[0] == zb && this[1] == zb && this[2] == zb)

val md = MessageDigest.getInstance("MD5")
val zb = 0.toByte()
