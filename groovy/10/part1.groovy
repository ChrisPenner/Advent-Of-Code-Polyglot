import java.util.regex.*

def regex = '((.)\\2*)'
def s = '113332'

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
