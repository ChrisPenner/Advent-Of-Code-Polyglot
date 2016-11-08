#!/usr/bin/env groovy

def capacities = new File('input.txt') as List<Integer>

println capacities
        // hack for reference
        .collect { new Expando(foo: it as int) }
        // all subssequences
        .subsequences()
        // filter out capacity
        .findAll { it.foo.sum() == 150 }
        // group by number of containers: k=nb containers, v=corresponding subseq
        .groupBy { it.size() }
        // group by number of containers: k=nb containers, v=how many subseq
        .collectEntries { howMany, seq -> [howMany, seq.size()] }
        // smallest amount of containers
        .min { it.key }
        // how many ways w/ lowest number of containers
        .value


/* Expando hack: see part 1 */
