#!/usr/bin/env groovy

def capacities = new File('input.txt') as List<Integer>

// Map each container capacity to an object
def containers = capacities.collect({ new Expando(foo: it as int) })
println containers.subsequences().findAll({ it.foo.sum() == 150 }).size()


/*
Expando hack: 'subsequences' called on a list of integers will omit
identical values. However, the puzzle mandates to treat two containers
as distinct even if they have the same capacity. Expandos all have different
references regardeless of their 'foo' capacity.

Examples:

def foo = [1, 1, 1, 2]
assert 7 == foo.subsequences().size()   // not what we want!
def bar = [1, 1, 1, 2].collect({ new Expando(foo: it) })
assert 15 == bar.subsequences().size()   // that's better
*/
