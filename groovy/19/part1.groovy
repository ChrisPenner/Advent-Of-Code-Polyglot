#!/usr/bin/env groovy

def rReplacements = /(.*) => (.*)/
def replacements = [:]
def input = new File('input.txt') as String []
input.findAll({ it.contains('=>') }).each { s ->
    def (_, k, v) = (s =~ rReplacements)[0]
    if (!(k in replacements.keySet())) replacements[k] = []
    replacements[k] << v
}

def molecule = input[-1]

def transformed = [] as Set
def i = 0
while (i < molecule.length()) {
    def m = molecule[i..-1]
    def k = replacements.keySet().find({ m.startsWith(it) })
    if (k) {
        transformed.addAll(replacements[k].collect({ molecule[0..i-1] + m.replaceFirst(k, it) }))
        i += k.length()
    } else {
        i++
    }
}

println transformed.size()