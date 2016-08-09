import groovy.json.JsonSlurper;

total = 0

def add(o) {
    if (o instanceof Map) {
        // JSON object
        if (o.values().contains('red')) return
        o.each { k, v -> add v }
    } else if (o instanceof ArrayList) {
        // JSON array
        o.each { add it }
    } else {
        // JSON value + is numeric
        if (o instanceof Integer) total += o
    }
}

// Read input as a string
def json = new File('input.txt').text

// Turn it into a groovy object
def jsonObject = new JsonSlurper().parseText(json)

// Recursively add numbers and print total
add jsonObject
println total
