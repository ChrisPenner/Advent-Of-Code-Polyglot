import java.util.regex.*

def s = '3113322113'        // your puzzle input here
def regex = '((.)\\2*)'     // capture digit repetition

40.times {
    def p = Pattern.compile(regex)
    def m = p.matcher(s)
    def next = new StringBuilder()
    while (m.find()) {
        def g = m.group(1)
        next << g.length() << g.getAt(0)
    }
    s = next
}

println s.length()
