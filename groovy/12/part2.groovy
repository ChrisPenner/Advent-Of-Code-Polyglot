import groovy.json.JsonSlurper

int add(o) {
    if (o instanceof Map) {                 // JSON object
        if (o.values().contains('red')) return 0
        return o.collect { k, v -> add v }.sum()
    }

    if (o instanceof ArrayList) {           // JSON array
        return o.collect { add it }.sum()
    }

    if (o instanceof Integer) return o      // JSON value (numeric)

    return 0                                // String
}

def json = new File('input.txt').text
def jsonObject = new JsonSlurper().parseText(json)
println add(jsonObject)
