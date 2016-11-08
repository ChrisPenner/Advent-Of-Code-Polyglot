#!/usr/bin/env groovy

import java.security.MessageDigest
import java.util.stream.IntStream

String md5(String text) {
	def md = MessageDigest.getInstance('MD5')
	new BigInteger(1, md.digest(text.bytes))
			.toString(16)
			.padLeft(32, "0")
}

println IntStream.iterate(0, { n -> n+1 })
		.filter({ md5(String.format("XXXXXXXX%d", it)).startsWith('000000') })
		.findFirst()
		.orElse(0)


/*
Note: the following md5 version yields the same result but is much slower
MessageDigest.getInstance('MD5')
		.digest(text.bytes)
		.collect { String.format("%02x", it) }
		.join('')
*/
