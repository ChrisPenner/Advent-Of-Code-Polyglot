#!/usr/bin/python
# -*- coding: utf-8 -*-

""" --- Day 21: RPG Simulator 20XX ---

Little Henry Case got a new video game for Christmas.
It's an RPG, and he's stuck on a boss.
He needs to know what equipment to buy at the shop.
He hands you the controller.

In this game, the player (you) and the enemy (the boss) take turns attacking.
The player always goes first.
Each attack reduces the opponent's hit points by at least 1.
The first character at or below 0 hit points loses.

Damage dealt by an attacker each turn is equal to
the attacker's damage score minus the defender's armor score.
An attacker always does at least 1 damage.
So, if the attacker has a damage score of 8,
and the defender has an armor score of 3, the defender loses 5 hit points.
If the defender had an armor score of 300,
the defender would still lose 1 hit point.

Your damage score and armor score both start at zero.
They can be increased by buying items in exchange for gold.
You start with no items and have as much gold as you need.
Your total damage or armor is equal to
the sum of those stats from all of your items.
You have 100 hit points.

Here is what the item shop is selling:

Weapons:    Cost  Damage  Armor
Dagger        8     4       0
Shortsword   10     5       0
Warhammer    25     6       0
Longsword    40     7       0
Greataxe     74     8       0

Armor:      Cost  Damage  Armor
Leather      13     0       1
Chainmail    31     0       2
Splintmail   53     0       3
Bandedmail   75     0       4
Platemail   102     0       5

Rings:      Cost  Damage  Armor
Damage +1    25     1       0
Damage +2    50     2       0
Damage +3   100     3       0
Defense +1   20     0       1
Defense +2   40     0       2
Defense +3   80     0       3

You must buy exactly one weapon; no dual-wielding.
Armor is optional, but you can't use more than one.
You can buy 0-2 rings (at most one for each hand).
You must use any items you buy. The shop only has one of each item,
so you can't buy, for example, two rings of Damage +3.

For example, suppose you have 8 hit points, 5 damage, and 5 armor,
and that the boss has 12 hit points, 7 damage, and 2 armor:

The player deals 5-2 = 3 damage; the boss goes down to 9 hit points.
The boss deals 7-5 = 2 damage; the player goes down to 6 hit points.
The player deals 5-2 = 3 damage; the boss goes down to 6 hit points.
The boss deals 7-5 = 2 damage; the player goes down to 4 hit points.
The player deals 5-2 = 3 damage; the boss goes down to 3 hit points.
The boss deals 7-5 = 2 damage; the player goes down to 2 hit points.
The player deals 5-2 = 3 damage; the boss goes down to 0 hit points.
In this scenario, the player wins! (Barely.)

You have 100 hit points. The boss's actual stats are in your puzzle input.
What is the least amount of gold you can spend and still win the fight?

--- Part Two ---

Turns out the shopkeeper is working with the boss,
and can persuade you to buy whatever items he wants.
The other rules still apply, and he still only has one of each item.

What is the most amount of gold you can spend and still lose the fight? """


# LOGIC
# weapons is non-optional
# all others are optional, therefore, an extra item is added to each type
# called None, it has all stats set to 0
# so that calculating variations will automatically
# use the None as a case where none of that item-types are bought

# shop items
weapons = {
    'Dagger': {
        'cost': 8,
        'damage': 4,
        'armor': 0,
    },
    'Shortsword': {
        'cost': 10,
        'damage': 5,
        'armor': 0,
    },
    'Warhammer': {
        'cost': 25,
        'damage': 6,
        'armor': 0,
    },
    'Longsword': {
        'cost': 40,
        'damage': 7,
        'armor': 0,
    },
    'Greataxe': {
        'cost': 74,
        'damage': 8,
        'armor': 0,
    },
}

armor = {
    'None': {
        'cost': 0,
        'damage': 0,
        'armor': 0,
    },
    'Leather': {
        'cost': 13,
        'damage': 0,
        'armor': 1,
    },
    'Chainmail': {
        'cost': 31,
        'damage': 0,
        'armor': 2,
    },
    'Splintmail': {
        'cost': 53,
        'damage': 0,
        'armor': 3,
    },
    'Bandedmail': {
        'cost': 75,
        'damage': 0,
        'armor': 4,
    },
    'Platemail': {
        'cost': 102,
        'damage': 0,
        'armor': 5,
    },
}

rings_damage = {
    'None': {
        'cost': 0,
        'damage': 0,
        'armor': 0,
    },
    'Damage +1': {
        'cost': 25,
        'damage': 1,
        'armor': 0,
    },
    'Damage +2': {
        'cost': 50,
        'damage': 2,
        'armor': 0,
    },
    'Damage +3': {
        'cost': 100,
        'damage': 3,
        'armor': 0,
    },
}

rings_armor = {
    'None': {
        'cost': 0,
        'damage': 0,
        'armor': 0,
    },
    'Defense +1': {
        'cost': 20,
        'damage': 0,
        'armor': 1,
    },
    'Defense +2': {
        'cost': 40,
        'damage': 0,
        'armor': 2,
    },
    'Defense +3': {
        'cost': 80,
        'damage': 0,
        'armor': 3,
    },
}

player = {
    'hits': 100,
    'damage': 0,
    'armor': 0,
}


# parse boss stats from input
import re
pattern = re.compile(r'(\d+)')
with open('./input.txt', 'r') as f:
    # make a dictionary
    boss = dict(zip(
        # attach input to stats
        ('hits', 'damage', 'armor'),
        [int(pattern.findall(line)[0]) for line in f.readlines()]))


def calculate_gold(*items):
    """Calculate gold for buying given items"""

    # access cost in the item dictionary
    get_cost = lambda x: x[0][x[1]]['cost']

    # return sum of costs of all items
    return sum(
        # get cost of each item
        map(get_cost,
            # map items onto their categories
            zip(
                (weapons, armor, rings_damage, rings_armor),
                (*items))))


def get_stats(*items):
    """Get damange and armor stats from given items"""

    # get damage from item dictionary
    get_damage = lambda x: x[0][x[1]]['damage']
    # get armor from item dictionary
    get_armor = lambda x: x[0][x[1]]['armor']

    # map items onto their categories
    stats = list(zip((weapons, armor, rings_damage, rings_armor), (*items)))

    # get sum of total damage from all items
    stat_damage = sum(map(get_damage, stats))
    # get armor of total damage from all items
    stat_armor = sum(map(get_armor, stats))

    return (stat_damage, stat_armor)


def simulate_gameplay(*items):
    """Simulate gameplay battle for given items
    Returns outcome and gold spent."""

    # get damage and armor from items
    p_damage, p_armor = get_stats(*items)
    # calculate gold used to buy items
    gold = calculate_gold(*items)

    # player stats
    p_hits = player['hits']
    p_damage += player['damage']
    p_armor += player['armor']

    # boss stats
    b_hits = boss['hits']

    # amount of hurt dealt to player
    # minimum damage dealt is 1
    p_hurt = boss['damage'] - p_armor
    if p_hurt <= 0:
        p_hurt = 1
    # amount of hurt dealt to boss
    # minimum damage dealt is 1
    b_hurt = p_damage - boss['armor']
    if b_hurt <= 0:
        b_hurt = 1

    # simulate steps until one of the players is dead
    # minimum number of plays is steps equal to player's hit points
    # since 1 damage is dealt at each step
    for i in range(0, player['hits']):

        # player plays
        b_hits -= b_hurt
        # check if boss is dead
        if b_hits <= 0:
            return (True, gold)
        # boss plays
        p_hits -= p_hurt
        # check if player is dead
        if p_hits <= 0:
            return (False, gold)


# calculate all variations of items possible
# uses dictionary keys, which are item names
# product selects each item from a iterable,
# and matches it with each item from other lists
from itertools import product
variations = product(
    weapons.keys(), armor.keys(),
    rings_damage.keys(), rings_armor.keys())

# get results for all variations
games = [simulate_gameplay(i) for i in variations]

# select outcomes where the player has lost
gold = [gold for outcome, gold in games if outcome is False]

print(max(gold))
