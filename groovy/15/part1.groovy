#!/usr/bin/env groovy

// Read ingredients and store their numeric characteristics
def lines = new File('input.txt') as String []
def rNumber = ~/-?\d+/
def ingredients = lines.collect({ it.findAll(rNumber)*.toInteger() })

def highScore = 0

// Combine the given ingredient proportions and test the score
def combine = { proportions ->
    def score = (0..3).collect { property ->
        def pScore = 0
        ingredients.eachWithIndex { ingredient, i ->
            pScore += ingredient[property] * proportions[i]
        }
        pScore = [pScore, 0].max()                // 0 if property score is negative
    }.inject(1) { product, item -> product*item } // mult all properties scores

    if (score > highScore) {
        highScore = score
    }
}

// Try all possible proportions of ingredients.
// When a valid proportion (=100%) is found, we test it directly
// rather than building a list of all combinations upfront
def mix
mix = { proportions ->
    def left = 100 - (proportions.sum() ?: 0)
    if (proportions.size()+1 == ingredients.size()) {
        combine(proportions + [left])
    } else {
        (0..left).each {
            def that = proportions + [it]
            mix(proportions + [it])
        }
    }
}

mix([] as List<Integer>)

println highScore
