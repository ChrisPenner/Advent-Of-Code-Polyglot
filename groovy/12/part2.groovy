import groovy.json.JsonSlurper;

int add(o) {
    if (o instanceof Map) {
        // JSON object
        if (o.values().contains('red')) return 0
        return o.collect { k, v -> add v }.sum()
    }
    if (o instanceof ArrayList) {
        // JSON array
        return o.collect { add it }.sum()
    }
    // JSON value + is numeric
    if (o instanceof Integer) return o

    return 0    // String
}

// Read input as a string
def json = new File('input.txt').text

// Turn it into a groovy object
def jsonObject = new JsonSlurper().parseText(json)

// Recursively add numbers and print total
println add(jsonObject)
