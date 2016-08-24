#!/usr/bin/env groovy

// Read ingredients and store their numeric characteristics
def lines = new File('input.txt') as String []
def rNumber = ~/-?\d+/
def ingredients = lines.collect({ it.findAll(rNumber)*.toInteger() })
def calories = ingredients.collect { ingredient -> ingredient[4] }
def highScore = 0

// Combine the given ingredient proportions and test the score
def combine = { proportions ->
    // Check calories
    def recipeCalories = (0..ingredients.size() - 1).collect { i ->
        proportions[i] * calories[i]
    }.sum()
    if (recipeCalories != 500) return

    // Compute score
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
// and testing only afterwards
def mix
mix = { proportions ->
    def left = 100 - (proportions.sum() ?: 0)
    if (proportions.size()+1 == ingredients.size()) {
        combine(proportions + [left])
    } else {
        (0..left).each {
            mix(proportions + [it])
        }
    }
}

mix([] as List<Integer>)

println highScore
