#!/usr/bin/python
# -*- coding: utf-8 -*-

# author coolharsh55
# Harshvardhan J. Pandit

# parse input to get boss stats
with open('./input.txt', 'r') as f:
    import re
    pattern = re.compile(r'(\d+)')
    BOSS_STATS = [int(pattern.findall(x)[0]) for x in f.readlines()]

# set player's starting stats
PLAYER_HP = 50
PLAYER_MANA = 500


class Game(object):

    """Game state object. Represents the state of Game at some instance."""

    class Player(object):

        """Player in the game, the protagonist."""

        def __init__(self):
            self.hp = PLAYER_HP
            self.mana = PLAYER_MANA
            self.damage = 0
            self.armor = 0
            self.mana_spent = 0

        def __str__(self):
            return 'player'

    class Monster(object):

        """Boss / Monster. Battles the Player."""

        def __init__(self):
            self.hp = BOSS_STATS[0]
            self.damage = BOSS_STATS[1]

        def __str__(self):
            return 'monster'

    def __init__(self):
        # depicts the winner in the game through a reference
        # If the player wins, winner = player
        # If the monster wins, winner = monster
        # Can be checked using:
        # type(winner) == Game.Player or Game.Monster
        self.winner = None
        # create a new player for this game
        self.player = self.Player()
        # create a new monster for this game
        self.monster = self.Monster()
        # indicators for spells that last more than one turn
        self.poison = 0
        self.shield = 0
        self.recharge = 0

    @classmethod
    def makegame(cls, game=None):
        """Make a copy of the game by copying its values.
        Accepts another game to copy from, or returns a new empty game."""

        # If no game is provided as reference, return a new empty game.
        if game is None:
            return cls()

        # Create a copy of the provided game.
        new_game = cls()

        new_game.winner = game.winner
        new_game.poison = game.poison
        new_game.shield = game.shield
        new_game.recharge = game.recharge

        new_game.player.hp = game.player.hp
        new_game.player.mana = game.player.mana
        new_game.player.damage = game.player.damage
        new_game.player.armor = game.player.armor
        new_game.player.mana_spent = game.player.mana_spent

        new_game.monster.hp = game.monster.hp

        return new_game


# Spells and their effects
spells = {
    'magic_missile': {
        'mana': 53,
        'damage': 4,
    },
    'drain': {
        'mana': 73,
        'damage': 2,
        'heal': 2,
    },
    'shield': {
        'mana': 113,
        'armor': 7,
        'turns': 6,
    },
    'poison': {
        'mana': 173,
        'damage': 3,
        'turns': 6,
    },
    'recharge': {
        'mana': 229,
        'turns': 5,
        'recharge_mana': 101,
    },
}


def check_game_over(game):
    """Check if someone has died, and it's GAME OVER."""

    # If the player's HP is gone, the monster has won
    if game.player.hp <= 0:
        game.winner = game.monster
        return True

    # If the monster's HP is gone, the player has won
    if game.monster.hp <= 0:
        game.winner = game.player
        return True

    # No one has died, the game is still ON
    return False


def apply_spells(game):
    """Apply the active spell effects on game."""

    # If shield is on, put on armor
    if game.shield > 0:
        game.shield -= 1
        game.player.armor = spells['shield']['armor']
    elif game.shield == 0:
        game.player.armor = 0

    # If poison is on, hurt the monster
    if game.poison > 0:
        game.poison -= 1
        game.monster.hp -= spells['poison']['damage']

    # If recharge is on, make a mana potion, drink it,
    # get mana added to the mana points
    if game.recharge > 0:
        game.recharge -= 1
        game.player.mana += spells['recharge']['recharge_mana']


def player_plays(game, spell):
    """Player's turn, cast a spell, and apply it's effects."""

    # Check if someone (the player) has died and it's GAME OVER.
    if check_game_over(game):
        return

    # Apply the effects of the spell currently active
    apply_spells(game)

    # If someone has died, the game is over.
    if check_game_over(game):
        return

    # If the player does not have enough mana to cast another spell,
    # it's already game over. Declare the monster as the winner.
    if game.player.mana < spells['magic_missile']['mana']:
        game.winner = game.monster
        return

    # Check if player has enough mana, Cast the spell, and apply it's effects.
    # If player doesn't have enough mana to cast that spell,
    # consider it's GAME OVER, with the monster as the winner,
    # and return so that this move can be considered invalid.

    if spell == 'magic_missile' and game.player.mana >= spells[spell]['mana']:
        game.player.mana -= spells[spell]['mana']
        game.player.mana_spent += spells[spell]['mana']
        game.monster.hp -= spells[spell]['damage']

    elif spell == 'drain' and game.player.mana >= spells[spell]['mana']:
        game.player.mana -= spells[spell]['mana']
        game.player.mana_spent += spells[spell]['mana']
        game.player.hp += spells[spell]['heal']
        game.monster.hp -= spells[spell]['damage']

    elif spell == 'shield' and game.shield == 0 and \
            game.player.mana >= spells[spell]['mana']:
        game.player.mana -= spells[spell]['mana']
        game.player.mana_spent += spells[spell]['mana']
        game.shield = spells[spell]['turns']

    elif spell == 'poison' and game.poison == 0 and \
            game.player.mana >= spells[spell]['mana']:
        game.player.mana -= spells[spell]['mana']
        game.player.mana_spent += spells[spell]['mana']
        game.poison = spells[spell]['turns']

    elif spell == 'recharge' and game.recharge == 0 and \
            game.player.mana >= spells[spell]['mana']:
        game.player.mana -= spells[spell]['mana']
        game.player.mana_spent += spells[spell]['mana']
        game.recharge = spells[spell]['turns']

    else:
        game.winner = game.monster

    check_game_over(game)


def monster_plays(game):
    """Monster's turn. Hurt the player. That's all it does."""

    # Apply the effects of active spells.
    apply_spells(game)

    # Check if someone has died, and it's GAME OVER.
    if check_game_over(game):
        return

    # Hurt the player.
    # If the player has some armour, the minimum damage
    # done is still 1HP
    game.player.hp -= max(game.monster.damage - game.player.armor, 1)

    check_game_over(game)


def game_states(gamestate):
    """Generate all possible game states for given game state.
    Will apply all spells possible, and if the spell results in a winner,
    or is not invalid, yields the game state."""

    # Go over each spell available
    for spell in spells.keys():

        # Create a copy of the game,
        # so that it is a new game state
        # and the original can be reused again
        game = Game.makegame(gamestate)

        # Player plays first step
        player_plays(game, spell)

        # If the player has won, return this game state
        if game.winner:
            if type(game.winner) == Game.Player:
                yield game

            # If the monster has won, or even when continuing
            # from the previous yield,
            # go to the next loop iteration
            continue

        # Monster plays next
        monster_plays(game)

        # Check if the winner isn't the monster.
        # That means the winner is the Player, or there is no winner.
        # Both are valid states.
        if type(game.winner) != Game.Monster:
                yield game


class Stack(list):

    """Wrapper over python's list just to use 'push' instead of 'append'."""

    def push(self, obj):
        """Does the same thing as append: puts object at end of list."""

        return self.append(obj)


# Declare a stack to hold the game states
stack = Stack()
# Add the first, empty game state to the stack
stack.push(Game.makegame())

# Hold the minimum mana costs.
# Set this to some sane high value,
# so that the first value gets set as min automatically.
min_mana_cost = 999999


# Go over each game state as long as they're in the stack.
while(stack):

    # Take the most recent game state out, and act on it.
    # This follows the DFS principle: Depth-First-Search
    # Go visiting the nodes and leaves of a tree before all its branches
    game = stack.pop()

    # OPTIMIZATION:
    # Iterate only over those game states that have a possibility
    # of generating the min value.
    # Check whether their current mana cost is more than the previous cost
    # If not, they're not eligible.
    if game.player.mana_spent > min_mana_cost:
        continue

    # Check if the current game state has a winner, and it's the player.
    # If it is, see if it's mana cost is a new minimum.
    if game.winner is not None:
        if type(game.winner) == Game.Player:
            min_mana_cost = min(min_mana_cost, game.player.mana_spent)
        continue

    # go over each state possible for this game state
    for state in game_states(game):

        # check if there's no winner, and put it back on stack
        # if game.winner is None:
        stack.push(state)

print(min_mana_cost)
