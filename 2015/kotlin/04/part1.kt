import java.io.File
import java.security.MessageDigest

fun main(args: Array<String>) {
    val input = File("input.txt").readText()

    val res = (0L..Long.MAX_VALUE).first { i -> md5("$input$i").isFirstFiveZero() }

    println(res)
}


fun md5(str: String): ByteArray {
    md5.update(str.toByteArray())
    return md5.digest()
}

fun ByteArray.isFirstFiveZero(): Boolean =
        this[0] == zb && this[1] == zb && this[2] <= 0x0f.toByte() && this[2] > 0

val md5 = MessageDigest.getInstance("MD5")
val zb = 0.toByte()