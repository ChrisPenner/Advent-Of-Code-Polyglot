import java.util.regex.*

// Your puzzle input here
def s = '3113322113'

// Capture digit repetition in the second group
def p = Pattern.compile('((\\d)\\2*)')

50.times {
    def m = p.matcher(s)
    def next = new StringBuilder()
    while (m.find()) {
        def g = m.group(1)
        next << g.length() << g.getAt(0)
    }
    s = next
}

println s.length()
